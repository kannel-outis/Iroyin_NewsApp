import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
  var hive;

  void hiveIt(String name) async {
    hive = await Hive.openBox("testing");
    hive.add("name", name);
  }

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
            child: Column(
          children: [
            Container(
              child: const TextField(),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: FlatButton(
                color: Theme.of(context).primaryColor,
                onPressed: () {},
                child: Center(
                  child: Text("Save",
                      style: TextStyle(
                        color: Colors.white,
                      )),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Text(hive.getAt(0).toString());
                })
          ],
        )),
      ),
    );
  }
}
