// // import 'dart:html';
//
// // import 'dart:html';
//
//
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:maps_toolkit/maps_toolkit.dart' as map_tool;
// // import 'package:vehicle_tracking/services/database.dart';
//
// // import 'loadingPage.dart';
//
//
// class DisplayPage extends StatefulWidget {
//   const DisplayPage({Key? key}) : super(key: key);
//
//   @override
//   State<DisplayPage> createState() => _DisplayPageState();
// }
//
// class _DisplayPageState extends State<DisplayPage> {
//
//
//   late GoogleMapController mapController;
//   late String name;
//
//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }
//
//
//   // Future<dynamic> update_data(String name,LatLng val,int index) async {
//   //
//   //   // DocumentReference documentReference = FirebaseFirestore.instance.collection("vehicles").doc(name);
//   //   // dynamic data =  await get_data(name);
//   //   // data['pos'][index]=GeoPoint(val.latitude, val.longitude);
//   //   // Map<String, dynamic> y = {
//   //
//   //     'ownerID' : data['ownerID'],
//   //     'plateNumber':data['plateNumber'],
//   //     'tracker':  data['tracker'],
//   //     'position':data['position'],
//   //     'pos':data['pos']
//   //
//   //   };
//   //   return y;
//     // documentReference.set(y).whenComplete(() => print("Succesfully wrote to database"));
//
//   }
//
//   // Future<dynamic> get_data(String name) async {
//   //
//   //   DocumentReference documentReference = FirebaseFirestore.instance.collection("vehicles").doc(name);
//   //   dynamic x = await documentReference.get();
//   //   print("Helo There");
//   //   return x.data();
//   // }
//
//
//
//
//
//
//
//   dynamic data;
//   bool isInSelectedArea = true;
//
//
//   @override
//   Widget build(BuildContext context)  {
//     data = ModalRoute.of(context)?.settings.arguments;
//     // DocumentReference documentReference = FirebaseFirestore.instance.collection("vehicles").doc(data['name']);
//     // dynamic
//     // List<LatLng> polygonPoints = [
//     //   LatLng(data['polygon'][0].latitude,data['polygon'][0].longitude),
//     //   LatLng(data['polygon'][1].latitude,data['polygon'][1].longitude),
//     //   LatLng(data['polygon'][2].latitude,data['polygon'][2].longitude),
//     //   LatLng(data['polygon'][3].latitude,data['polygon'][3].longitude),
//     //   LatLng(data['polygon'][4].latitude,data['polygon'][4].longitude)
//     //
//     //
//     // ];
//
//     // dynamic data2 = get_data(data['name']);
//
//     // List<LatLng> polygonPoints = data2['poly'];
//     // update_value(data['name']);
//     // polygonPoints = [LatLng(23.766315 , 90.425778),
//     // LatLng(23.764691 , 90.424767),
//     // LatLng(23.761916 , 90.426862),
//     // LatLng(23.758532 , 90.428588),
//     // LatLng(23.763698 , 90.431324)];
//
//     // LatLng(23.762912 ,  90.427816);
//     return Scaffold(
//
//       appBar: AppBar(
//         title: Text("Location Tracking"),
//       ),
//
//       body:
//       FutureBuilder(
//           future: get_data(data['name']),
//           builder:((context,snapshot){
//
//             if (snapshot.connectionState == ConnectionState.done){
//
//               Map<String,dynamic> z = snapshot.data as Map<String, dynamic>;
//               List<LatLng> polygonPoints = [
//                 LatLng(z['pos'][0].latitude, z['pos'][0].longitude),
//                 LatLng(z['pos'][1].latitude, z['pos'][1].longitude),
//                 LatLng(z['pos'][2].latitude, z['pos'][2].longitude),
//                 LatLng(z['pos'][3].latitude, z['pos'][3].longitude),
//                 LatLng(z['pos'][4].latitude, z['pos'][4].longitude),
//               ] ;
//
//               // void checkUpdatedLocation (LatLng pointLatLng){
//               //   List<map_tool.LatLng> convatedPolygonPoints = polygonPoints.map((
//               //       point) => map_tool.LatLng(point.latitude , point.longitude),
//               //   ).toList();
//               //
//               //   setState(() {
//               //     isInSelectedArea = map_tool.PolygonUtil.containsLocation(
//               //         map_tool.LatLng(pointLatLng.latitude , pointLatLng.longitude ),
//               //         convatedPolygonPoints,
//               //         false
//               //     );
//               //   });
//               // }
//               return GoogleMap(
//                 zoomGesturesEnabled: true,
//                 onMapCreated: _onMapCreated,
//                 initialCameraPosition: CameraPosition(
//                   target: LatLng(z['position'].latitude,z['position'].longitude),
//                   zoom: 15,
//                 ),
//                 markers: {
//
//                   Marker(
//
//                       markerId: MarkerId("Vehicle 1"),
//                       icon: BitmapDescriptor.defaultMarkerWithHue(100),
//                       position: LatLng(z['position'].latitude,z['position'].longitude),
//                       draggable: false
//                   ),
//                   Marker(
//                     markerId: MarkerId("0"),
//
//                     position: LatLng(z['pos'][0].latitude,z['pos'][0].longitude),
//                     draggable: true,
//                     onDragEnd: (val) async{
//                       // GeoPoint update_value = GeoPoint(val.latitude, val.longitude);
//                       dynamic x = await update_data(data['name'],val,0);
//                       setState(() {
//                         DocumentReference documentReference = FirebaseFirestore.instance.collection("vehicles").doc(data['name']);
//                         documentReference.set(x).whenComplete(() => print("Done writing To Database"));
//
//
//
//                       });
//
//
//
//
//                     },
//                   ),
//                   Marker(
//                     markerId: MarkerId("Index1"),
//                     position: LatLng(z['pos'][1].latitude,z['pos'][1].longitude),
//                     //   position: LatLng(23.762912 ,  90.427816),
//                     draggable: true,
//                     onDragEnd: (val) async{
//                       // GeoPoint update_value = GeoPoint(val.latitude, val.longitude);
//                       dynamic x = await update_data(data['name'],val,1);
//                       setState(() {
//                         DocumentReference documentReference = FirebaseFirestore.instance.collection("vehicles").doc(data['name']);
//                         documentReference.set(x).whenComplete(() => print("Done writing To Database"));
//
//
//
//                       });
//
//
//
//
//                     },
//                   ),
//                   Marker(
//                     markerId: MarkerId("Index2"),
//                     position: LatLng(z['pos'][2].latitude,z['pos'][2].longitude),
//                     draggable: true,
//                     onDragEnd: (val) async{
//                       // GeoPoint update_value = GeoPoint(val.latitude, val.longitude);
//                       dynamic x = await update_data(data['name'],val,2);
//                       setState(() {
//                         DocumentReference documentReference = FirebaseFirestore.instance.collection("vehicles").doc(data['name']);
//                         documentReference.set(x).whenComplete(() => print("Done writing To Database"));
//
//
//
//                       });
//
//
//
//
//                     },
//                   ),
//                   Marker(
//                     markerId: MarkerId("Index3"),
//                     position: LatLng(z['pos'][3].latitude,z['pos'][3].longitude),
//                     draggable: true,
//                     onDragEnd: (val) async{
//                       // GeoPoint update_value = GeoPoint(val.latitude, val.longitude);
//                       dynamic x = await update_data(data['name'],val,3);
//                       setState(() {
//                         DocumentReference documentReference = FirebaseFirestore.instance.collection("vehicles").doc(data['name']);
//                         documentReference.set(x).whenComplete(() => print("Done writing To Database"));
//
//
//
//                       });
//
//
//
//
//                     },
//                   ),
//                   Marker(
//                     markerId: MarkerId("Index4"),
//                     position: LatLng(z['pos'][4].latitude,z['pos'][4].longitude),
//                     //   position: LatLng(23.762912 ,  90.427816),
//                     draggable: true,
//                     onDragEnd: (val) async{
//                       // GeoPoint update_value = GeoPoint(val.latitude, val.longitude);
//                       dynamic x = await update_data(data['name'],val,4);
//                       setState(() {
//                         DocumentReference documentReference = FirebaseFirestore.instance.collection("vehicles").doc(data['name']);
//                         documentReference.set(x).whenComplete(() => print("Done writing To Database"));
//
//
//
//                       });
//
//
//
//
//                     },
//                   ),
//
//
//                 },
//                 polygons: {
//
//                   Polygon(
//
//                     polygonId: PolygonId("geoFence"),
//                     points: polygonPoints.cast<LatLng>(),
//                     strokeWidth: 1,
//                     fillColor: Colors.blue.withOpacity(0.2),
//
//                   )
//
//                 },
//
//
//               );
//             }
//             return LoadingPage();
//
//
//
//
//           })
//       ),
//
//
//     );
//
//   }
// }
//
//
//
//
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:geolocator/geolocator.dart';
// // import 'package:flutter/material.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:maps_toolkit/maps_toolkit.dart' as map_tool;
// // import 'package:vehicle_tracking/services/database.dart';
// //
// //
// // class DisplayPage extends StatefulWidget {
// //   const DisplayPage({Key? key}) : super(key: key);
// //
// //   @override
// //   State<DisplayPage> createState() => _DisplayPageState();
// // }
//
// // class _DisplayPageState extends State<DisplayPage> {
// //
// //
// //   late GoogleMapController mapController;
// //   late String name;
// //
// //   void _onMapCreated(GoogleMapController controller) {
// //     mapController = controller;
// //   }
// //
// //   // DataBaseService x = DataBaseService();
// //   // print(x.vehicleCollection)
// //
// //   Future<dynamic> update_data(String name,LatLng val,int index) async {
// //
// //     DocumentReference documentReference = FirebaseFirestore.instance.collection("vehicles").doc(name);
// //     dynamic data =  await get_data(name);
// //     data['pos'][index]=val;
// //     Map<String, dynamic> y = {
// //
// //       'ownerID' : data['ownerID'],
// //       'plateNumber':data['plateNumber'],
// //       'tracker':  data['tracker'],
// //       'position':data['position'],
// //       'pos':data['pos']
// //
// //     };
// //     return y;
// //     // documentReference.set(y).whenComplete(() => print("Succesfully wrote to database"));
// //
// //   }
// //
// //   Future<dynamic> get_data(String name) async {
// //
// //     DocumentReference documentReference = FirebaseFirestore.instance.collection("vehicles").doc(name);
// //     dynamic x = await documentReference.get();
// //     return x.data();
// //   }
// //
// //
// //
// //
// //
// //
// //
// //   dynamic data;
// //   bool isInSelectedArea = true;
// //
// //   // data = ModalRoute.of(context)?.settings.arguments;
// //
// //   @override
// //   Widget build(BuildContext context)  {
// //     // print("I am buildin")
// //     data = ModalRoute.of(context)?.settings.arguments;
// //     // DocumentReference documentReference = FirebaseFirestore.instance.collection("vehicles").doc(data['name']);
// //     // dynamic
// //     // List<LatLng> polygonPoints = [
// //     //   LatLng(data['polygon'][0].latitude,data['polygon'][0].longitude),
// //     //   LatLng(data['polygon'][1].latitude,data['polygon'][1].longitude),
// //     //   LatLng(data['polygon'][2].latitude,data['polygon'][2].longitude),
// //     //   LatLng(data['polygon'][3].latitude,data['polygon'][3].longitude),
// //     //   LatLng(data['polygon'][4].latitude,data['polygon'][4].longitude)
// //     //
// //     //
// //     // ];
// //
// //     // dynamic data2 = get_data(data['name']);
// //
// //     // List<LatLng> polygonPoints = data2['poly'];
// //     // update_value(data['name']);
// //     // polygonPoints = [LatLng(23.766315 , 90.425778),
// //     // LatLng(23.764691 , 90.424767),
// //     // LatLng(23.761916 , 90.426862),
// //     // LatLng(23.758532 , 90.428588),
// //     // LatLng(23.763698 , 90.431324)];
// //
// //     // LatLng(23.762912 ,  90.427816);
// //     void checkUpdatedLocation (LatLng pointLatLng){
// //       List<map_tool.LatLng> convatedPolygonPoints = polygonPoints.map((
// //           point) => map_tool.LatLng(point.latitude , point.longitude),
// //       ).toList();
// //
// //       setState(() {
// //         isInSelectedArea = map_tool.PolygonUtil.containsLocation(
// //             map_tool.LatLng(pointLatLng.latitude , pointLatLng.longitude ),
// //             convatedPolygonPoints,
// //             false
// //         );
// //       });
// //     }
// //
// //     return Scaffold(
// //
// //       appBar: AppBar(
// //         title: Text("Location Tracking"),
// //       ),
// //
// //       body:
// //       FutureBuilder(
// //         future: get_data(data['name']),
// //         child: GoogleMap(
// //           zoomGesturesEnabled: true,
// //           onMapCreated: _onMapCreated,
// //           initialCameraPosition: CameraPosition(
// //             target: LatLng(data['location'].latitude,data['location'].longitude),
// //             zoom: 15,
// //           ),
// //           markers: {
// //
// //             Marker(
// //                 markerId: MarkerId("Vehicle 1"),
// //                 position: LatLng(data['location'].latitude,data['location'].longitude),
// //                 //   position: LatLng(23.762912 ,  90.427816),
// //                 draggable: false
// //             ),
// //             Marker(
// //               markerId: MarkerId("0"),
// //               position: LatLng(data['polygon'][0].latitude,data['polygon'][0].longitude),
// //               //   position: LatLng(23.762912 ,  90.427816),
// //               draggable: true,
// //               onDragEnd: (val) async{
// //                 GeoPoint update_value = GeoPoint(val.latitude, val.longitude);
// //                 dynamic x = await update_data(data['name'],val,0);
// //                 setState(() {
// //                   // print("Helsdf");
// //                   // polygonPoints[0]=val;
// //
// //
// //                 });
// //
// //
// //
// //
// //               },
// //             ),
// //             Marker(
// //                 markerId: MarkerId("Index1"),
// //                 position: LatLng(data['polygon'][1].latitude,data['polygon'][1].longitude),
// //                 //   position: LatLng(23.762912 ,  90.427816),
// //                 draggable: false
// //             ),
// //             Marker(
// //               markerId: MarkerId("Index2"),
// //               position: LatLng(data['polygon'][2].latitude,data['polygon'][2].longitude),
// //               //   position: LatLng(23.762912 ,  90.427816),
// //               // draggable: true
// //             ),
// //             Marker(
// //               markerId: MarkerId("Index3"),
// //               position: LatLng(data['polygon'][3].latitude,data['polygon'][3].longitude),
// //               //   position: LatLng(23.762912 ,  90.427816),
// //               // draggable: true
// //             ),
// //             Marker(
// //               markerId: MarkerId("Index4"),
// //               position: LatLng(data['polygon'][4].latitude,data['polygon'][4].longitude),
// //               //   position: LatLng(23.762912 ,  90.427816),
// //               // draggable: true
// //             ),
// //
// //
// //           },
// //           polygons: {
// //
// //             Polygon(
// //
// //               polygonId: PolygonId("geoFence"),
// //               points: polygonPoints,
// //               strokeWidth: 1,
// //               fillColor: Colors.blue.withOpacity(0.2),
// //
// //             )
// //
// //           },
// //
// //
// //         ),
// //       ),
// //
// //
// //     );
// //   }
// // }
//
//


import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'loadingPage.dart';


class DisplayPage extends StatefulWidget {
  const DisplayPage({Key? key}) : super(key: key);

  @override
  State<DisplayPage> createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {


  late GoogleMapController mapController;
  late String name;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }


  Future<dynamic> update_data(String name,LatLng val,int index) async {

    DocumentReference documentReference = FirebaseFirestore.instance.collection("vehicles").doc(name);
    dynamic data =  await get_data(name);
    data['pos'][index]=GeoPoint(val.latitude, val.longitude);
    Map<String, dynamic> y = {

      'ownerID' : data['ownerID'],
      'plateNumber':data['plateNumber'],
      'tracker':  data['tracker'],
      'position':data['position'],
      'pos':data['pos']

    };
    return y;
    // documentReference.set(y).whenComplete(() => print("Succesfully wrote to database"));

  }

  // Future<dynamic> get_data(String name) async {
  //
  //   DocumentReference documentReference = FirebaseFirestore.instance.collection("vehicles").doc(name);
  //   dynamic x = await documentReference.get();
  //   print("Helo There");
  //   return x.data();
  // }







  dynamic data;
  bool isInSelectedArea = true;


  @override
  Widget build(BuildContext context)  {
    data = ModalRoute.of(context)?.settings.arguments;

    return Scaffold(

      appBar: AppBar(
        title: Text("Location Tracking"),
      ),

      body:
      FutureBuilder(
          future: get_data(data['name']),
          builder:((context,snapshot){

            if (snapshot.connectionState == ConnectionState.done){

              Map<String,dynamic> z = snapshot.data as Map<String, dynamic>;
              List<LatLng> polygonPoints = [
                LatLng(z['pos'][0].latitude, z['pos'][0].longitude),
                LatLng(z['pos'][1].latitude, z['pos'][1].longitude),
                LatLng(z['pos'][2].latitude, z['pos'][2].longitude),
                LatLng(z['pos'][3].latitude, z['pos'][3].longitude),
                LatLng(z['pos'][4].latitude, z['pos'][4].longitude),
              ] ;

              // void checkUpdatedLocation (LatLng pointLatLng){
              //   List<map_tool.LatLng> convatedPolygonPoints = polygonPoints.map((
              //       point) => map_tool.LatLng(point.latitude , point.longitude),
              //   ).toList();
              //
              //   setState(() {
              //     isInSelectedArea = map_tool.PolygonUtil.containsLocation(
              //         map_tool.LatLng(pointLatLng.latitude , pointLatLng.longitude ),
              //         convatedPolygonPoints,
              //         false
              //     );
              //   });
              // }
              return GoogleMap(
                zoomGesturesEnabled: true,
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: LatLng(z['position'].latitude,z['position'].longitude),
                  zoom: 15,
                ),
                markers: {

                  Marker(

                      markerId: MarkerId("Vehicle 1"),
                      icon: BitmapDescriptor.defaultMarkerWithHue(100),
                      position: LatLng(z['position'].latitude,z['position'].longitude),
                      draggable: false
                  ),
                  Marker(
                    markerId: MarkerId("0"),

                    position: LatLng(z['pos'][0].latitude,z['pos'][0].longitude),
                    draggable: true,
                    onDragEnd: (val) async{
                      // GeoPoint update_value = GeoPoint(val.latitude, val.longitude);
                      dynamic x = await update_data(data['name'],val,0);
                      setState(() {
                        DocumentReference documentReference = FirebaseFirestore.instance.collection("vehicles").doc(data['name']);
                        documentReference.set(x).whenComplete(() => print("Done writing To Database"));



                      });




                    },
                  ),
                  Marker(
                    markerId: MarkerId("Index1"),
                    position: LatLng(z['pos'][1].latitude,z['pos'][1].longitude),
                    //   position: LatLng(23.762912 ,  90.427816),
                    draggable: true,
                    onDragEnd: (val) async{
                      // GeoPoint update_value = GeoPoint(val.latitude, val.longitude);
                      dynamic x = await update_data(data['name'],val,1);
                      setState(() {
                        DocumentReference documentReference = FirebaseFirestore.instance.collection("vehicles").doc(data['name']);
                        documentReference.set(x).whenComplete(() => print("Done writing To Database"));



                      });




                    },
                  ),
                  Marker(
                    markerId: MarkerId("Index2"),
                    position: LatLng(z['pos'][2].latitude,z['pos'][2].longitude),
                    draggable: true,
                    onDragEnd: (val) async{
                      // GeoPoint update_value = GeoPoint(val.latitude, val.longitude);
                      dynamic x = await update_data(data['name'],val,2);
                      setState(() {
                        DocumentReference documentReference = FirebaseFirestore.instance.collection("vehicles").doc(data['name']);
                        documentReference.set(x).whenComplete(() => print("Done writing To Database"));



                      });




                    },
                  ),
                  Marker(
                    markerId: MarkerId("Index3"),
                    position: LatLng(z['pos'][3].latitude,z['pos'][3].longitude),
                    draggable: true,
                    onDragEnd: (val) async{
                      // GeoPoint update_value = GeoPoint(val.latitude, val.longitude);
                      dynamic x = await update_data(data['name'],val,3);
                      setState(() {
                        DocumentReference documentReference = FirebaseFirestore.instance.collection("vehicles").doc(data['name']);
                        documentReference.set(x).whenComplete(() => print("Done writing To Database"));



                      });




                    },
                  ),
                  Marker(
                    markerId: MarkerId("Index4"),
                    position: LatLng(z['pos'][4].latitude,z['pos'][4].longitude),
                    //   position: LatLng(23.762912 ,  90.427816),
                    draggable: true,
                    onDragEnd: (val) async{
                      // GeoPoint update_value = GeoPoint(val.latitude, val.longitude);
                      dynamic x = await update_data(data['name'],val,4);
                      setState(() {
                        DocumentReference documentReference = FirebaseFirestore.instance.collection("vehicles").doc(data['name']);
                        documentReference.set(x).whenComplete(() => print("Done writing To Database"));



                      });




                    },
                  ),


                },
                polygons: {

                  Polygon(

                    polygonId: PolygonId("geoFence"),
                    points: polygonPoints.cast<LatLng>(),
                    strokeWidth: 1,
                    fillColor: Colors.blue.withOpacity(0.2),

                  )

                },


              );
            }
            return LoadingPage();




          })
      ),


    );

  }
}