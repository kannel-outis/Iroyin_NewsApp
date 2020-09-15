import 'package:NewsApp_Chingu/ui/model_repo.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'app/routes/route_generator.gr.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ModelRepo().hiveInit();
  await DotEnv().load('myApiKey.env');
  runApp(
    MyApp(),
  );
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
        initialRoute: Routes.myHomePage,
        onGenerateRoute: Router().onGenerateRoute,
      ),
    );
  }
}
