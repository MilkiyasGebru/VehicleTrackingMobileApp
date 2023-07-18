import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_tracking/constants/LocalHost.dart';
import 'package:http/http.dart' as http;

class AddVehiclePage extends StatefulWidget {
  String id = "";
  AddVehiclePage({Key? key, required this.id}) : super(key: key);

  @override
  State<AddVehiclePage> createState() => _AddVehiclePageState();
}

class _AddVehiclePageState extends State<AddVehiclePage> {

  _AddVehiclePageState(){
    selectedVal = lockStatus[0];
  }

  final lockStatus = ['locked' , 'unlocked'];
  String? selectedVal = "";

  final _formKey = GlobalKey<FormState>();

  final myController = TextEditingController();
  var PlateNumber = "";
  var vehicleStatus = "";
  String error = "";
  String success = "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              TextFormField(
                validator: (value){
                  if (value == null || value.isEmpty){
                    return "Please enter the plateNumber ";
                  }
                  else{
                    null;
                  }
                },
                onChanged: (val){
                  setState(() {
                    PlateNumber = val;
                  });
                },
                // controller: myController ,
                decoration: InputDecoration(
                  labelText: "Plate number",
                  prefixIcon: Icon(Icons.numbers_outlined , color: Colors.deepPurple,),
                  border: UnderlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple.shade300),
                  ),
                  labelStyle: TextStyle(color: Colors.deepPurple),
                ),
              ),

              SizedBox(height: 5,),
              Text(error, style: TextStyle(
                color: Colors.red
              ),),

              SizedBox(height: 20,),
              DropdownButtonFormField(
                value: selectedVal,
                items: lockStatus.map((e) =>
                    DropdownMenuItem(child: Text(e) , value: e ,)
                ).toList(),
                onChanged: (val){

                  setState(() {
                    selectedVal = val as String;
                    print(selectedVal);
                  });

                },
                icon: Icon(
                  Icons.arrow_drop_down_circle,
                  color: Colors.deepPurple,
                ),
                dropdownColor: Colors.deepPurple.shade50,
                decoration: InputDecoration(
                  labelText: "Vehicle status",
                  prefixIcon: Icon(
                    Icons.car_crash_outlined,
                    color: Colors.deepPurple,
                  ),
                  border: UnderlineInputBorder(),

                ),
              ),
              SizedBox(height: 20,),
              ElevatedButton(

                onPressed: () async{
                  if(_formKey.currentState!.validate()){
                    dynamic result = await http.post(Uri.parse("http://${localhost}:3001/addVehicle"),headers: {"Content-Type":"application/json"}, body: jsonEncode({"Owner":widget.id,"PlateNumber":PlateNumber,"Engine":(selectedVal!)=="locked"}));
                    result = jsonDecode(result.body);
                    setState(() {

                      if (result["error"] != null){
                        success = "";
                        error = result["error"];
                      }
                      else{
                        error = "";
                        success = "vehicle add successfully";
                      }


                    });

                  }
                },
                child: Text(
                  'Add',
                  style: TextStyle(
                    fontSize: 18 ,
                  ),
                ),
              ),
              SizedBox(height: 5,),
              Text(success,style: TextStyle(
                color : Colors.green
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
