import 'package:NewsApp_Chingu/ui/model_repo.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'app/routes/route_generator.gr.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ModelRepo().hiveInit();
  getRoute();
  runApp(MyApp());
}

String _route;
getRoute() async {
  if (await ConnectivityWrapper.instance.isConnected) {
    return _route = Routes.myHomePage;
  } else {
    return _route = Routes.errorPage;
  }
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConnectivityAppWrapper(
      app: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'IROYIN',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: _route,
        onGenerateRoute: Router().onGenerateRoute,
      ),
    );
  }
}
