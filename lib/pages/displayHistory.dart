import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import "dart:convert";
import 'package:mobile_tracking/constants/LocalHost.dart';

import 'package:mobile_tracking/pages/utilsDirectory/LoadingPage.dart';
class HistoryPage extends StatefulWidget {

  List<dynamic> centre = [];
  String id ="";
  HistoryPage({Key? key,    required  this.centre, required this.id}) : super(key: key);


  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  late GoogleMapController mapController;
  late String name;
  // String localhost = "192.168.105.127";

  void _onMapCreated(GoogleMapController controller) {

    mapController = controller;
  }





  Future<List<LatLng>> get_data() async{
    print("I am in the get_data()");
    final url = Uri.parse('http://${localhost}:3001/history');
    final response = await http.post(url,body: jsonEncode({"VehicleId":widget.id}),headers:{'Content-Type': 'application/json'} );
    dynamic result = json.decode(response.body);
    List<LatLng> points = [];
    // res
    // print("I before the loop");
    print("THe result length is ");
    for (int i=0; i<result["locations"].length; i++){

      points.add(LatLng(result["locations"][i]["lat"], result["locations"][i]["lng"]));
    };
    print("These are the points ${points}");
    return points;
  }



  @override
  Widget build(BuildContext context) {



    return Scaffold(

      body: FutureBuilder(

        future: get_data(),
        builder: ((context,snapshot){

          if (snapshot.connectionState == ConnectionState.done){

            List<LatLng> points = [];
            if (snapshot.data != null){
              points = snapshot.data as List<LatLng>;
            }
            print("THe snapshot data is ${points}");
            return GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(widget.centre[0].toDouble(), widget.centre[1].toDouble()),
                zoom: 15,
              ),
              polylines: {
                Polyline(
                  polylineId: PolylineId('line'),
                  points: points,
                  color: Colors.red,
                  width: 3,
                ),
              },
            );
          }
          return LoadingPage();

        })

      ),
    );
  }
}
