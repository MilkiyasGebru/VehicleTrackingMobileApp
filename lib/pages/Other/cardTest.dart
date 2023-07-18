// import 'package:flutter/material.dart';
//
// class CartTest2 extends StatelessWidget {
//   const CartTest2({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       appBar: AppBar(
//         title: Text("Hey"),
//       ),
//       body: Padding(
//
//         padding: const EdgeInsets.all(10.0),
//         child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Card(
//
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//
//                 clipBehavior: Clip.antiAliasWithSaveLayer,
//
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//
//                     Container(
//                       decoration: const BoxDecoration(
//                         border: Border(
//                           bottom: BorderSide(color: Colors.indigoAccent, width: 3),
//                         ),
//                       ),
//                       padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//
//                           Text(
//                             "${data[index]["PlateNumber"]}",
//                             style: TextStyle(
//                               fontSize: 24,
//                               color: Colors.grey[800],
//                             ),
//                           ),
//
//                           Container(height: 10),
//
//                           Text(
//                             checkPointPolygon(LatLng(data[index]["CurrentLocation"]["coordinates"][0],data[index]["CurrentLocation"]["coordinates"][1] ), data[index]["GeoFence"],data[index]["PlateNumber"])? "Vehicle is in the fence":"Vehicle is out of fence",
//                             style: TextStyle(
//                               fontSize: 15,
//                               color: Colors.grey[700],
//                             ),
//                           ),
//
//                           Row(
//                             children: <Widget>[
//
//                               const Spacer(),
//
//                               TextButton(
//                                 style: TextButton.styleFrom(
//                                   foregroundColor: Colors.transparent,
//                                 ),
//                                 child:  Text(
//                                   data[index]["Engine"]? "Turn Off Engine": "Turn On Engine",
//                                   style: TextStyle(
//                                       color: Colors.indigoAccent
//                                   ),
//                                 ),
//                                 onPressed: () async {
//                                   final url = Uri.parse("http://${localhost}:3001/updateEngine");
//                                   await http.post(url,body:jsonEncode({"_id":data[index]["_id"], "Engine":data[index]["Engine"]}),headers: {'Content-Type': 'application/json'});
//                                 },
//                               ),
//
//                               TextButton(
//                                 style: TextButton.styleFrom(
//                                   foregroundColor: Colors.transparent,
//                                 ),
//                                 child:  Text(
//                                   "Location",
//                                   style: TextStyle(color: Colors.indigoAccent),
//                                 ),
//                                 onPressed: () {
//                                   Navigator.pushNamed(context, '/map',arguments:{"geofence":data[index]["GeoFence"], "id":data[index]["_id"], "centre":data[index]["CurrentLocation"]["coordinates"]} );
//                                 },
//                               ),
//                               TextButton(
//                                 style: TextButton.styleFrom(
//                                   foregroundColor: Colors.transparent,
//                                 ),
//                                 child:  Text(
//                                   "History",
//                                   style: TextStyle(
//                                       color: Colors.indigoAccent
//                                   ),
//                                 ),
//                                 onPressed: () {
//                                     Navigator.pushNamed(context, '/history', arguments: {"id":data[index]["_id"], "centre":data[index]["CurrentLocation"]["coordinates"]} );
//                                 },
//                               ),
//                               TextButton(
//                                 style: TextButton.styleFrom(
//                                   foregroundColor: Colors.transparent,
//                                 ),
//                                 child:  Text(
//                                   "Report Theft",
//                                   style: TextStyle(
//                                       color: Colors.indigoAccent
//                                   ),
//                                 ),
//                                 onPressed: () async {
//                                   final url = Uri.parse('http://${localhost}:3001/reportTheft');
//                                   dynamic result  = await http.post(url,body: jsonEncode({"TheftLocation": {"lat":data[index]["CurrentLocation"]["coordinates"][0],"lng":data[index]["CurrentLocation"]["coordinates"][1]},
//                                     "Owner" : data[index]["Owner"],
//                                     "PlateNumber": data[index]["PlateNumber"],}),
//                                       headers: {'Content-Type': 'application/json'});
//                                   Navigator.pushNamed(context, '/theft',arguments:{"id":widget.id} );
//                                 },
//                               )
//
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(height: 5),
//                   ],
//                 ),
//               ),
//
//             ]
//         ),
//       ),
//     );
//   }
// }
//
//
