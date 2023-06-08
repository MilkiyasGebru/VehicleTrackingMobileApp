import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      color: Colors.blueAccent[100],
      child: Center(

        child: SpinKitChasingDots(

          color: Colors.grey[200],
          size: 250.0,

        ),
      ),

    );
  }
}