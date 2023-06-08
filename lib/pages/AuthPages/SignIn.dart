import 'package:flutter/material.dart';
import 'package:mobile_tracking/constants/TextDecorationFile.dart';
import 'package:http/http.dart' as http;
import "dart:convert";


class SignInPage extends StatefulWidget {

  @override
  State<SignInPage> createState() => _SignInPageState();

}

class _SignInPageState extends State<SignInPage> {

  String localhost = "192.168.104.127";
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

                    Image(image: AssetImage("assets/6387974.jpg")),

                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Text("Welcome",style: TextStyle(
                        fontSize: 35, fontWeight: FontWeight.bold,
                      ),),
                    ),

                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: Text("Back", style: TextStyle(
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
                            final url = Uri.parse('http://${localhost}:3001/signIn');

                            dynamic result  = await http.post(url,body: jsonEncode({"name":username,"password":password}),
                              headers: {'Content-Type': 'application/json'});
                            print("Hello User");
                            result = jsonDecode(result.body);
                            print(result);
                            if (result["error"] != null){
                              setState(() {
                                error = "Wrong Username or Password";
                              });
                            }
                            else{
                              print("THe Id is ${result["_id"]}");
                              Navigator.pushNamed(context, '/nav', arguments: {"id" : result["_id"]});
                            }


                          }




                        }, child: Text("Sign In ",style: TextStyle(color: Colors.white)),style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black))),
                      ),
                    ),

                    Text(error,style: TextStyle(
                        color: Colors.red
                    ),),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(

                        children: [

                          Text("      Don't have an account?",style: TextStyle(color: Colors.black,fontSize: 15),),

                          SizedBox(width: 10,),

                          TextButton(onPressed: (){
                            Navigator.pushNamed(context, '/signUp');
                          }, child: Text("Sign Up"))

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





