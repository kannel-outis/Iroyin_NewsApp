import '../../../app/routes/route_generator.gr.dart';
import '../../../ui/const/color.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatefulWidget {
  @override
  _ErrorPageState createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Connection Error"),
        automaticallyImplyLeading: false,
      ),
      body: ConnectivityWidgetWrapper(
        decoration: BoxDecoration(
          color: constColor2,
        ),
        disableInteraction: true,
        message: "Connect to an active internet Connection to Continue",
        child: Center(
          child: FlatButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, Routes.myHomePage);
            },
            child: Text("Continue"),
          ),
        ),
      ),
    );
  }
}
