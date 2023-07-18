

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_tracking/pages/AuthPages/SignUp.dart';
import 'package:mobile_tracking/pages/Navigation/NavBar.dart';
import 'package:mobile_tracking/pages/Other/addVehicle.dart';
import 'package:mobile_tracking/pages/Other/cardTest.dart';
import 'package:mobile_tracking/pages/Other/changePassword.dart';
import 'package:mobile_tracking/pages/Other/theft.dart';
import 'package:mobile_tracking/pages/displayHistory.dart';
import 'package:mobile_tracking/pages/displayLocation.dart';
import 'package:mobile_tracking/pages/home.dart';
import 'package:mobile_tracking/pages/AuthPages/SignIn.dart';



void main(){


  runApp(MaterialApp(
    initialRoute: '/',
    routes: {

      '/':(context)=>SignInPage(),
      // '/cardtest':(context)=> CartTest2(),

      '/map': (context){
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return MapPage(geofence: args['geofence'], centre: args['centre'],id:args["id"] );
      },
      '/home': (context){

          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return MyHomePage(id:args["id"]);},
      '/signUp':(context)=> SignUpPage(),
      '/theft':(context){
        final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

        return TheftPage(id:args["id"]);},
      '/nav' : (context) {
        final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

        return NavBarPage(id:args["id"]);},
      '/history': (context){
        final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
        return HistoryPage(centre: args["centre"], id: args["id"]);
      },
      '/change':(context){
        final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
        return ChangePasswordPage(id: args["id"]);
      },
      'add':(context){
        final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
        return AddVehiclePage(id:args["id"]);
      }
  },


    // home: MapPage(),
    // home:MyHomePage()
  ));
}