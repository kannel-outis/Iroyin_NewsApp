import 'package:flutter/material.dart';

class DummyPage extends StatefulWidget {
  @override
  _DummyPageState createState() => _DummyPageState();
}

double media;
getQuery(BuildContext context) {
  media = MediaQuery.of(context).size.width;
  // return media;
}

class _DummyPageState extends State<DummyPage> {
  @override
  Widget build(BuildContext context) {
    print("rebuilding...");
    getQuery(context);
    // print(MediaQuery.of(context).size.height);
    // print(MediaQuery.of(context).size.width);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: media,
        child: Center(
            child: Container(
          child: const TextField(),
        )),
      ),
    );
  }
}
