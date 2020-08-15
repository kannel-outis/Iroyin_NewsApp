import 'package:NewsApp_Chingu/methods/functions.dart';
import 'package:NewsApp_Chingu/models/news_model_structure.dart';
import 'package:NewsApp_Chingu/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

final Functions _functions = Functions();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider<List<Article>>(
            create: (_) => _functions.getNewsFromApi()),
        FutureProvider(create: (_) => _functions.allArticles()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: FirstPageRoute(),
      ),
    );
  }
}

class FirstPageRoute extends StatefulWidget {
  @override
  _FirstPageRouteState createState() => _FirstPageRouteState();
}

class _FirstPageRouteState extends State<FirstPageRoute> {
  @override
  Widget build(BuildContext context) {
    return MyHomePage();
  }
}
