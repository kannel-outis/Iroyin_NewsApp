import 'package:hooks_riverpod/all.dart';

import './services/navigation_service/navigation_services.dart';
import './ui/model_repo.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'app/locator/locator.dart';
import 'app/routes/route_generator.gr.dart' as routes;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ModelRepo().hiveInit();
  await DotEnv().load('myApiKey.env');
  setupLocator();
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
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
        navigatorKey: locator<NavigationService>().navigatorKey,
        initialRoute: routes.Routes.myHomePage,
        onGenerateRoute: routes.Router().onGenerateRoute,
      ),
    );
  }
}
