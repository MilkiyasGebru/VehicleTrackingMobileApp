import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sse_client/sse_client.dart';
import 'package:maps_toolkit/maps_toolkit.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mobile_tracking/constants/LocalHost.dart';

Future _showNotificationWithDefaultSound(flip, plateNumber) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'Milkiyas', 'Gebru',
      importance: Importance.max, priority: Priority.high);

  var platformChannelSpecifics =
  NotificationDetails(android: androidPlatformChannelSpecifics);

  await flip.show(
      0,
      'Smart Tracker',
      'Your car with plateNumber $plateNumber is out of its GeoFence',
      platformChannelSpecifics,
      payload: 'Default_Sound');
}
bool checkPointPolygon(LatLng point, List<dynamic> geofence, PlateNumber){

  List<LatLng> geofence_points = [];

  for (int i=0; i < geofence.length; i++){
    geofence_points.add(LatLng(geofence[i]["lat"].toDouble(),geofence[i]["lng"].toDouble() ));

  }
  if (!PolygonUtil.containsLocation(point, geofence_points, true)){
    FlutterLocalNotificationsPlugin flip = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var settings = new InitializationSettings(android: android);
    flip.initialize(settings);
    _showNotificationWithDefaultSound(flip, PlateNumber);
  }
  return PolygonUtil.containsLocation(point, geofence_points, true);

}

class MyHomePage extends StatefulWidget {
  String id = "";
  MyHomePage({Key? key,  required this.id}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List data = [];
  late SseClient sseClient;
  // String localhost =  "192.168.105.127";

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


    backgroundColor: Colors.black12,

      body: data != null

          ? ListView.builder(

        itemCount: data.length,

        itemBuilder: (context, index) {
          return Card(

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),

            clipBehavior: Clip.antiAliasWithSaveLayer,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.indigoAccent, width: 3),
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      Text(
                        "${data[index]["PlateNumber"]}",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.grey[800],
                        ),
                      ),

                      Container(height: 10),

                      Text(
                        checkPointPolygon(LatLng(data[index]["CurrentLocation"]["coordinates"][0].toDouble(),data[index]["CurrentLocation"]["coordinates"][1].toDouble() ), data[index]["GeoFence"],data[index]["PlateNumber"])? "Vehicle is in the fence":"Vehicle is out of fence",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[700],
                        ),
                      ),

                      Row(
                        children: <Widget>[

                          const Spacer(),

                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.transparent,
                            ),
                            child:  Text(
                              data[index]["Engine"]? "Turn Off Engine": "Turn On Engine",
                              style: TextStyle(
                                  color: Colors.indigoAccent
                              ),
                            ),
                            onPressed: () async {
                              final url = Uri.parse("http://${localhost}:3001/updateEngine");
                              await http.post(url,body:jsonEncode({"_id":data[index]["_id"], "Engine":data[index]["Engine"]}),headers: {'Content-Type': 'application/json'});
                            },
                          ),

                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.transparent,
                            ),
                            child:  Text(
                              "Location",
                              style: TextStyle(color: Colors.indigoAccent),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/map',arguments:{"geofence":data[index]["GeoFence"], "id":data[index]["_id"], "centre":data[index]["CurrentLocation"]["coordinates"]} );
                            },
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.transparent,
                            ),
                            child:  Text(
                              "History",
                              style: TextStyle(
                                  color: Colors.indigoAccent
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/history', arguments: {"id":data[index]["_id"], "centre":data[index]["CurrentLocation"]["coordinates"]} );
                            },
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.transparent,
                            ),
                            child:  Text(
                              "Report Theft",
                              style: TextStyle(
                                  color: Colors.indigoAccent
                              ),
                            ),
                            onPressed: () async {
                              final url = Uri.parse('http://${localhost}:3001/reportTheft');
                              dynamic result  = await http.post(url,body: jsonEncode({"TheftLocation": {"lat":data[index]["CurrentLocation"]["coordinates"][0],"lng":data[index]["CurrentLocation"]["coordinates"][1]},
                                "Owner" : data[index]["Owner"],
                                "PlateNumber": data[index]["PlateNumber"],}),
                                  headers: {'Content-Type': 'application/json'});
                              Navigator.pushNamed(context, '/theft',arguments:{"id":widget.id} );
                            },
                          )

                        ],
                      ),
                    ],
                  ),
                ),
                Container(height: 5),
              ],
            ),
          );

          // return Card(
          //
          //   child: Column(
          //
          //   children:[
          //     // First Child
          //     ListTile(
          //     title: Text(data[index]['PlateNumber']),
          //     subtitle: Text(checkPointPolygon(LatLng(data[index]["CurrentLocation"]["coordinates"][0].toDouble(),data[index]["CurrentLocation"]["coordinates"][1].toDouble() ), data[index]["GeoFence"],data[index]["PlateNumber"])? "Vehicle is in the fence":"Vehicle is out of fence"),
          //   ),
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       children: [
          //
          //         InkWell(
          //           child: Text(
          //             "Location",
          //             style: TextStyle(
          //               color: Colors.blue,
          //               fontWeight: FontWeight.bold
          //             ),
          //
          //           ),
          //           onTap: (){
          //               // print("The geofence is ${data[index]["GeoFence"]}");
          //               // print("The Id is ${data[index]["_id"]}");
          //               // print("THe current location is ${data[index]["CurrentLocation"]["coordinates"]}");
          //               Navigator.pushNamed(context, '/map',arguments:{"geofence":data[index]["GeoFence"], "id":data[index]["_id"], "centre":data[index]["CurrentLocation"]["coordinates"]} );
          //           },
          //
          //         ),
          //         InkWell(
          //           child: Text(
          //             "Report Theft",
          //             style: TextStyle(
          //                 color: Colors.blue,
          //                 fontWeight: FontWeight.bold
          //             ),
          //
          //           ),
          //           onTap: () async {
          //             final url = Uri.parse('http://${localhost}:3001/reportTheft');
          //             dynamic result  = await http.post(url,body: jsonEncode({"TheftLocation": {"lat":data[index]["CurrentLocation"]["coordinates"][0],"lng":data[index]["CurrentLocation"]["coordinates"][1]},
          //               "Owner" : data[index]["Owner"],
          //               "PlateNumber": data[index]["PlateNumber"],}),
          //                 headers: {'Content-Type': 'application/json'});
          //             Navigator.pushNamed(context, '/theft',arguments:{"id":widget.id} );
          //           },
          //
          //         ),
          //
          //         InkWell(
          //           child: Text(
          //             "History",
          //             style: TextStyle(
          //               color: Colors.blue,
          //               fontWeight: FontWeight.bold
          //             ),
          //           ),
          //           onTap: () async{
          //             Navigator.pushNamed(context, '/history', arguments: {"id":data[index]["_id"], "centre":data[index]["CurrentLocation"]["coordinates"]} );
          //           },
          //         ),
          //         InkWell(
          //           child: Text(data[index]["Engine"]? "Turn Off Engine": "Turn On Engine",
          //           style: TextStyle(
          //               color: Colors.blue,
          //               fontWeight: FontWeight.bold
          //           ),),
          //           onTap: () async{
          //             final url = Uri.parse("http://${localhost}:3001/updateEngine");
          //             await http.post(url,body:jsonEncode({"_id":data[index]["_id"], "Engine":data[index]["Engine"]}),headers: {'Content-Type': 'application/json'});
          //           },
          //         )
          //
          //       ],
          //     )
          //
          //   ]
          //   )
          //
          //
          // );
        },
      )
          : Center(child: CircularProgressIndicator()),
    );
  }
}



