import 'package:flutter/material.dart';
import 'package:mobile_tracking/constants/TextDecorationFile.dart';
import 'package:http/http.dart' as http;
import "dart:convert";
import 'package:mobile_tracking/constants/LocalHost.dart';

class SignUpPage extends StatefulWidget {

  @override
  State<SignUpPage> createState() => _SignUpPageState();

}

class _SignUpPageState extends State<SignUpPage> {

  // String localhost = "192.168.105.127";
  final _formkey = GlobalKey<FormState>();
  bool _ishidden = true;
  String username = "";
  String error = "";
  String password = "";



  @override
  Widget build(BuildContext context) {


    return Scaffold(


      body: Center(

        // padding: EdgeInsets.all(15.0),
          child:SingleChildScrollView(

            child: Form(
              key: _formkey,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    Image(image: AssetImage('assets/6383307.jpg')),

                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Text("Sign",style: TextStyle(
                        fontSize: 35, fontWeight: FontWeight.bold,
                      ),),
                    ),

                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: Text("Up", style: TextStyle(
                          fontSize: 35,fontWeight: FontWeight.bold
                      ),),
                    ),

                    SizedBox(height: 6,),

                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                      child: Text("UserName", style: TextStyle(
                          fontSize: 18,fontWeight: FontWeight.bold
                      ),),
                    ),



                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: "Username",prefixIcon: Icon(Icons.person,color: Colors.black,)),
                        validator: (val)=>(val == null || val.isEmpty)? "Enter your username":null,
                        onChanged: (val){
                          setState(() {
                            username=val;
                          });
                        },

                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Text("Password", style: TextStyle(
                          fontSize: 18,fontWeight: FontWeight.bold
                      ),),
                    ),


                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: "Password",prefixIcon: Icon(Icons.key,color: Colors.black,),suffix: InkWell(
                          onTap: (){
                            setState(() {
                              // print("$_ishidden is the value" );
                              _ishidden = !_ishidden;
                            });
                          }

                          ,child: Icon(_ishidden? Icons.visibility: Icons.visibility_off),

                        )),
                        validator: (val)=> (val == null || val.length < 3)? "Password Should be greater than 3 characters":null,
                        obscureText: _ishidden,
                        onChanged: (val){
                          setState(() {
                            password = val;
                          });
                        },

                      ),
                    ),

                    SizedBox(height: 20.0,),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: SizedBox(
                        height: 60,width: 400,
                        child: ElevatedButton(onPressed: ()async{




                          print("I am pressed ");
                          if (_formkey.currentState!.validate())  {
                            final url = Uri.parse('http://${localhost}:3001/signUp');

                            dynamic result  = await http.post(url,body: jsonEncode({"name":username,"password":password}),
                                headers: {'Content-Type': 'application/json'});
                            print("Hello User");
                            result = jsonDecode(result.body);
                            print(result);
                            if (result["error"] != null){
                              setState(() {
                                error = result["error"];
                              });
                            }
                            else{
                              Navigator.pushNamed(context, '/nav', arguments: {"id" : result["_id"]});
                            }


                          }




                        }, child: Text("Sign Up ",style: TextStyle(color: Colors.white)),style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black))),
                      ),
                    ),

                    Text(error,style: TextStyle(
                        color: Colors.red
                    ),),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(

                        children: [

                          Text("      Already have an account?",style: TextStyle(color: Colors.black,fontSize: 15),),

                          SizedBox(width: 10,),

                          TextButton(onPressed: (){
                            Navigator.pushNamed(context, '/');
                          }, child: Text("Sign In"))

                        ],

                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        // error,style: TextStyle(
        //         color: Colors.red
      ),);


  }



}





