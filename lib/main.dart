import 'package:NewsApp_Chingu/services/hive_prefs.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'app/routes/route_generator.gr.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveInit().hiveInit();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConnectivityAppWrapper(
      app: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: Routes.myHomePage,
        onGenerateRoute: Router().onGenerateRoute,
      ),
    );
  }
}
