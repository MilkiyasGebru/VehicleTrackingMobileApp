// class DisplayLocation extends StatefulWidget {
//   // const DisplayLocation({Key? key}) : super(key: key);
//
//   @override
//   State<DisplayLocation> createState() => _DisplayLocationState();
// }
// class _DisplayLocationState extends State<DisplayLocation> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class MapPage extends StatefulWidget {
//   // MyHomePage({Key key}) : super(key: key);
//
//   @override
//   _MapPage createState() => _MapPage();
// }
//
// class _MapPage extends State<MapPage> {
//   late GoogleMapController mapController;
//
//   final LatLng _center = const LatLng(45.521563, -122.677433);
//
//   void _onMapCreated(GoogleMapController controller) {
//     if (controller != null) {
//       mapController = controller;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Google Maps Example'),
//       ),
//       body: GoogleMap(
//         onMapCreated: _onMapCreated,
//         initialCameraPosition: CameraPosition(
//           target: _center,
//           zoom: 11.0,
//         ),
//         polygons: {
//           Polygon(
//             polygonId: PolygonId('polygon'),
//             points: [
//               LatLng(45.521563, -122.677433),
//               LatLng(45.511563, -122.677433),
//               LatLng(45.511563, -122.667433),
//               LatLng(45.521563, -122.667433),
//             ],
//             strokeColor: Colors.red,
//             fillColor: Colors.red.withOpacity(0.5),
//           ),
//         },
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class MapPage extends StatefulWidget {
//   @override
//   _MapPage createState() => _MapPage();
// }
//
// class _MapPage extends State<MapPage> {
//   late GoogleMapController mapController;
//   final LatLng _center = const LatLng(45.521563, -122.677433);
//   final Set<Polygon> _polygons = {};
//   final Set<Marker> _markers = {};
//
//   void _onMapCreated(GoogleMapController controller) {
//     if (controller != null) {
//       mapController = controller;
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _addPolygon();
//     _addMarkers();
//   }
//
//   void _addPolygon() {
//     final polygon = Polygon(
//       polygonId: PolygonId('polygon'),
//       points: [
//         LatLng(45.521563, -122.677433),
//         LatLng(45.511563, -122.677433),
//         LatLng(45.511563, -122.667433),
//         LatLng(45.521563, -122.667433),
//       ],
//       strokeColor: Colors.red,
//       fillColor: Colors.red.withOpacity(0.5),
//     );
//     setState(() {
//       _polygons.add(polygon);
//     });
//   }
//
//   void _addMarkers() {
//     final polygon = _polygons.first;
//     for (int i = 0; i < polygon.points.length; i++) {
//       final point = polygon.points[i];
//       final marker = Marker(
//         markerId: MarkerId('marker_$i'),
//         position: point,
//         draggable: true,
//         onDragEnd: (newPosition) {
//           setState(() {
//             final points = polygon.points.map((point) {
//               if (point == marker.position) {
//                 return newPosition;
//               } else {
//                 return point;
//               }
//             }).toList();
//             _polygons.remove(polygon);
//             _polygons.add(polygon.copyWith(pointsParam: points));
//           });
//         },
//       );
//       setState(() {
//         _markers.add(marker);
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Google Maps Example'),
//       ),
//       body: GoogleMap(
//         onMapCreated: _onMapCreated,
//         initialCameraPosition: CameraPosition(
//           target: _center,
//           zoom: 11.0,
//         ),
//         polygons: _polygons,
//         markers: _markers,
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class MapPage extends StatefulWidget {
//   @override
//   _MapPage createState() => _MapPage();
// }
//
// class _MapPage extends State<MapPage> {
//   late GoogleMapController mapController;
//   final LatLng _center = const LatLng(45.521563, -122.677433);
//   final Set<Polygon> _polygons = {};
//   final Set<Marker> _markers = {};
//
//   void _onMapCreated(GoogleMapController controller) {
//     if (controller != null) {
//       mapController = controller;
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _addPolygon();
//     _addMarkers();
//   }
//
//   void _addPolygon() {
//     final polygon = Polygon(
//       polygonId: PolygonId('polygon'),
//       points: [
//         LatLng(45.521563, -122.677433),
//         LatLng(45.511563, -122.677433),
//         LatLng(45.511563, -122.667433),
//         LatLng(45.521563, -122.667433),
//       ],
//       strokeColor: Colors.red,
//       fillColor: Colors.red.withOpacity(0.5),
//     );
//     setState(() {
//       _polygons.add(polygon);
//     });
//   }
//
//   void _addMarkers() {
//     final polygon = _polygons.first;
//     for (int i = 0; i < polygon.points.length; i++) {
//       final point = polygon.points[i];
//       final newMarker = Marker(
//         markerId: MarkerId('marker_$i'),
//         position: point,
//         draggable: true,
//         onDragEnd: (newPosition) {
//           setState(() {
//             final points = polygon.points.map((point) {
//               if (point == newMarker.position) {
//                 return newPosition;
//               } else {
//                 return point;
//               }
//             }).toList();
//             _polygons.remove(polygon);
//             _polygons.add(polygon.copyWith(pointsParam: points));
//           });
//         },
//       );
//       setState(() {
//         _markers.add(newMarker);
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Google Maps Example'),
//       ),
//       body: GoogleMap(
//         onMapCreated: _onMapCreated,
//         initialCameraPosition: CameraPosition(
//           target: _center,
//           zoom: 11.0,
//         ),
//         polygons: _polygons,
//         markers: _markers,
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class MapPage extends StatefulWidget {
//   @override
//   _MapPage createState() => _MapPage();
// }
//
// class _MapPage extends State<MapPage> {
//   late GoogleMapController mapController;
//   final LatLng _center = const LatLng(45.521563, -122.677433);
//   final Set<Polygon> _polygons = {};
//   final Set<Marker> _markers = {};
//
//   void _onMapCreated(GoogleMapController controller) {
//     if (controller != null) {
//       mapController = controller;
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _addPolygon();
//     _addMarkers();
//   }
//
//   void _addPolygon() {
//     final polygon = Polygon(
//       polygonId: PolygonId('polygon'),
//       points: [
//         LatLng(45.521563, -122.677433),
//         LatLng(45.511563, -122.677433),
//         LatLng(45.511563, -122.667433),
//         LatLng(45.521563, -122.667433),
//       ],
//       strokeColor: Colors.red,
//       fillColor: Colors.red.withOpacity(0.5),
//     );
//     setState(() {
//       _polygons.add(polygon);
//     });
//   }
//
//   void _addMarkers() {
//     final polygon = _polygons.first;
//     for (int i = 0; i < polygon.points.length; i++) {
//       final point = polygon.points[i];
//       final markerId = 'marker_$i';
//       final newMarker = Marker(
//         markerId: MarkerId(markerId),
//         position: point,
//         draggable: true,
//         onDragEnd: (newPosition) {
//           setState(() {
//             final points = List<LatLng>.from(polygon.points);
//             points[i] = newPosition;
//             _polygons.remove(polygon);
//             _polygons.add(polygon.copyWith(pointsParam: points));
//           });
//         },
//       );
//       setState(() {
//         _markers.add(newMarker);
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Google Maps Example'),
//       ),
//       body: GoogleMap(
//         onMapCreated: _onMapCreated,
//         initialCameraPosition: CameraPosition(
//           target: _center,
//           zoom: 11.0,
//         ),
//         polygons: _polygons,
//         markers: _markers,
//       ),
//     );
//   }
// }


import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import "dart:convert";
import 'package:mobile_tracking/constants/LocalHost.dart';
class MapPage extends StatefulWidget {
    List<dynamic> geofence = [] ;
    List<dynamic> centre = [];
    String id ="";
   MapPage({Key? key,   required this.geofence, required  this.centre, required this.id}) : super(key: key);
  // List<LatLng> points = [];


  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  late GoogleMapController mapController;
  late String name;
  // String localhost = "192.168.105.127";

  void _onMapCreated(GoogleMapController controller) {
    print("The geofence is ${widget.geofence}");
    mapController = controller;
  }
  // List<LatLng> points = [];
  List<LatLng> points = [
    // LatLng(45.521563, -122.677433),
    // LatLng(45.511563, -122.677433),
    // LatLng(45.511563, -122.667433),
    // LatLng(45.521563, -122.667433),
    // LatLng(45.521563, -122.668433),
    // LatLng(45.521563, -122.668433)
  ];

  void drawPolygon(){
    for (int i=0;i < widget.geofence.length;i++){
        points.add(LatLng(widget.geofence[i]["lat"].toDouble(), widget.geofence[i]["lng"].toDouble()));
    }
  }

  void initState() {
  //
    super.initState();
    drawPolygon();
    print("The length of the geofence is ${widget.geofence.length}");
    print("THe geofence is ${widget.geofence}");
  }

  void _makePostRequest() async{final url = Uri.parse('http://${localhost}:3001/updateLocation');
  final response = await http.post(
    url,
    body: jsonEncode({"GeoFence":widget.geofence,"_id":widget.id}),
    headers: {'Content-Type': 'application/json'},
  );}
  // setState(() {
  //   _response = response.body;
  // });



  @override
  Widget build(BuildContext context) {

    Set<Marker> _addMarkers(){
      Set<Marker> ans = {};
      var centreMarker = Marker(markerId: MarkerId("Centre"),
        draggable: false,
        position: LatLng(widget.centre[0].toDouble(), widget.centre[1].toDouble()),
        icon: BitmapDescriptor.defaultMarkerWithHue(200)
      );
      ans.add(centreMarker);
      for (int i = 0; i < points.length; i++){
        var newMarker = Marker(markerId: MarkerId("${i}"),
            icon: BitmapDescriptor.defaultMarkerWithHue(100),
            position: points[i],
            draggable: true,
            onDragEnd:(val){
              setState(() {
                points[i] = val;
                // print("The changed latitutde is ${points[i].latitude}");
                // print("The points are ${points}");
                widget.geofence[i]["lat"] = points[i].latitude;
                widget.geofence[i]["lng"] = points[i].longitude;
                _makePostRequest();

                // fetch("http://localhost:3001/updateLocation",{
                //   method : "POST",
                //   headers : {
                //     "Content-Type" : 'application/json'
                //   },
                //   body: JSON.stringify({ GeoFence: geoFence,_id:_id})
                // })
              });
            }

        );
        ans.add(newMarker);
      }
      return ans;
    }

    return GoogleMap(

      zoomGesturesEnabled: true,
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: LatLng(widget.centre[0].toDouble(), widget.centre[1].toDouble()),
        zoom: 13,
      ),

      markers: _addMarkers(),
      polygons:  {

    Polygon(

    polygonId: PolygonId("geoFence"),
    points: points,
    strokeWidth: 1,
    fillColor: Colors.blue.withOpacity(0.2),

    )

    },



    );
  }
}


