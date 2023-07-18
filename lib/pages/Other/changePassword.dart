import 'dart:convert';
import 'package:mobile_tracking/constants/LocalHost.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChangePasswordPage extends StatefulWidget {
  String id="";
   ChangePasswordPage({Key? key, required this.id}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {

  // String localhost="192.168.105.127";
  String error = "";
  String success = "";
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();
  String oldPassword = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  TextFormField(
                    obscureText: true,
                    decoration:  InputDecoration(
                        labelText: "current password",
                        labelStyle: TextStyle(fontSize: 20),
                        border: OutlineInputBorder(),
                        errorStyle: TextStyle(
                            color: Colors.black26,
                            fontSize: 15

                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your current password';
                      }
                      return null;
                    },
                    onChanged: (val){
                        setState(() {
                          oldPassword = val;
                        });
                    },
                  ),
                  SizedBox(height:5),
                  Text(error,style: TextStyle(
                    color: Colors.red
                  ),),
                  SizedBox(height: 20,),

                  TextFormField(
                    controller: _newPasswordController,
                    obscureText: true,

                    decoration: InputDecoration(
                        labelText: "Enter your new password",
                        labelStyle: TextStyle(fontSize: 20),
                        border: OutlineInputBorder(),
                        errorStyle: TextStyle(
                            color: Colors.black26,
                            fontSize: 15

                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your new password';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 20,),

                  TextFormField(
                    controller: _confirmNewPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: "Confirm you new password",
                        labelStyle: TextStyle(fontSize: 20),
                        border: OutlineInputBorder(),
                        errorStyle: TextStyle(
                            color: Colors.black26,
                            fontSize: 15

                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your new password';
                      }
                      if (value != _newPasswordController.text) {
                        return 'New passwords do not match';
                      }
                      return null;
                    },
                  ),


                  SizedBox(height: 20,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {

                            dynamic result = await http.post(Uri.parse("http://${localhost}:3001/changePassword"),

                              body: jsonEncode({"oldPassword":oldPassword,"newPassword":_newPasswordController.text,"id":widget.id}),
                              headers: {'Content-Type': 'application/json'},

                            );
                            result = jsonDecode(result.body);
                            print("tHE result IS ${result}");
                            if (result["error"] != null){
                              setState(() {
                                success = "";
                                error = "Incorrect Password";
                              });
                            }
                            else{
                              setState((){
                                error = "";
                                success = "Password changed successfully";
                              });

                            }
                            // Process data.
                          }
                        },
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Text(success,style: TextStyle(
                    color: Colors.green
                  ),)

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
