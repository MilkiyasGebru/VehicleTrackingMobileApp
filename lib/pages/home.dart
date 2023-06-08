import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sse_client/sse_client.dart';

class MyHomePage extends StatefulWidget {
  String id = "";
  MyHomePage({Key? key,  required this.id}) : super(key: key);
  // MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List data = [];
  late SseClient sseClient;
  String localhost =  "192.168.104.127";

  @override
  void initState() {

    super.initState();
    fetchData();
    _listenForUpdates();

  }
  void _listenForUpdates() {

    sseClient = SseClient.connect(Uri.parse("http://${localhost}:3001/updates"));

    sseClient.stream?.listen((event) {
      // Handle the event here

      dynamic response = jsonDecode(event);

      dynamic array = response["array"];
      dynamic filiterdArray = array.where((item) => item["Owner"] == widget.id);
      setState(() {
        data = filiterdArray.toList();

      });
    });
  }
  fetchData() async {

    final response = await http.get(Uri.parse('http://${localhost}:3001/vehicles'));

      setState(() {
        dynamic result = json.decode(response.body);
        dynamic filiterdResult = result.where((item) => item["Owner"] == widget.id);
        data = filiterdResult.toList();

      });

  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(




      body: data != null

          ? ListView.builder(

        itemCount: data.length,

        itemBuilder: (context, index) {

          return Card(

            child: Column(

            children:[
              // First Child
              ListTile(
              title: Text(data[index]['PlateNumber']),
              subtitle: Text("Milkiyas Vehicels"),
            ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  InkWell(
                    child: Text(
                      "Location",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold
                      ),

                    ),
                    onTap: (){
                        print("The geofence is ${data[index]["GeoFence"]}");
                        print("The Id is ${data[index]["_id"]}");
                        print("THe current location is ${data[index]["CurrentLocation"]["coordinates"]}");
                        Navigator.pushNamed(context, '/map',arguments:{"geofence":data[index]["GeoFence"], "id":data[index]["_id"], "centre":data[index]["CurrentLocation"]["coordinates"]} );
                    },

                  ),
                  InkWell(
                    child: Text(
                      "Report Theft",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold
                      ),

                    ),
                    onTap: () async {
                      final url = Uri.parse('http://${localhost}:3001/reportTheft');
                      dynamic result  = await http.post(url,body: jsonEncode({"TheftLocation": {"lat":data[index]["CurrentLocation"]["coordinates"][0],"lng":data[index]["CurrentLocation"]["coordinates"][1]},
                        "Owner" : data[index]["Owner"],
                        "PlateNumber": data[index]["PlateNumber"],}),
                          headers: {'Content-Type': 'application/json'});
                      Navigator.pushNamed(context, '/theft',arguments:{"id":data[index]["_id"]} );
                    },

                  ),

                ],
              )

            ]
            )


          );
        },
      )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
