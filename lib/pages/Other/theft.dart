
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../utilsDirectory/LoadingPage.dart';

// class TheftPage extends StatelessWidget {
//   const TheftPage({Key? key, required id}) : super(key: key);
//
//   void
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//         appBar: AppBar(
//           title: Text('My Vehicles'),
//         ),
//
//       body : DataTable(
//       columns: [
//         DataColumn(label: Text('PlateNumber')),
//         DataColumn(label: Text('Latitude')),
//         DataColumn(label: Text('Longitude')),
//         DataColumn(label: Text('Date')),
//       ],
//       rows: [
//         DataRow(cells: [
//           DataCell(Text('ABC123')),
//           DataCell(Text('37.421999')),
//           DataCell(Text('-122.084057')),
//           DataCell(Text('2022-01-01')),
//         ]),
//         DataRow(cells: [
//           DataCell(Text('XYZ789')),
//           DataCell(Text('40.712776')),
//           DataCell(Text('-74.005974')),
//           DataCell(Text('2022-02-02')),
//         ]),
//       ],
//     ));
//   }
// }


class TheftPage extends StatefulWidget {
  String id = "";
  TheftPage({Key? key, required this.id}) : super(key: key);

  @override
  State<TheftPage> createState() => _TheftPageState();
}

class _TheftPageState extends State<TheftPage> {
  String localhost =  "192.168.104.127";
  Future<List<dynamic>> get_data() async {

    final response = await http.get(Uri.parse('http://${localhost}:3001/theft'));
    dynamic result = json.decode(response.body);
    dynamic filiterdResult = result.where((item) => item["Owner"] == widget.id).toList();

    return filiterdResult;
  }
  @override
  Widget build(BuildContext context)  {


    return Scaffold(



      body:
      FutureBuilder(
          future: get_data(),
          builder:((context,snapshot){

            if (snapshot.connectionState == ConnectionState.done){

              List<dynamic> data = [];
              if (snapshot.data != null){
                data = snapshot.data as List<dynamic>;
              }


              return DataTable(
                columns: [
                  DataColumn(label: Text('PlateNumber')),
                  DataColumn(label: Text('Latitude')),
                  DataColumn(label: Text('Longitude')),
                  DataColumn(label: Text('Date')),
                ],

                rows: [
                  for (var item in data)
                    DataRow(cells: [
                      DataCell(Text('${item["PlateNumber"]}')),
                      DataCell(Text('${item["TheftLocation"]["lat"]}')),
                      DataCell(Text('${item["TheftLocation"]["lng"]}')),
                      DataCell(Text('${item["TheftDate"]}')),
                    ]),

                ],
              ); }
            return LoadingPage();




          })
      ),


    );

  }
}


