import 'package:NewsApp_Chingu/methods/functions.dart';
import 'package:NewsApp_Chingu/models/favorite_model.dart';
import 'package:NewsApp_Chingu/models/model_repo.dart';
import 'package:NewsApp_Chingu/models/news_model_structure.dart';
import 'package:NewsApp_Chingu/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

const String favoriteBoxName = "favorites";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final documentDir = await getApplicationDocumentsDirectory();
  Hive.init(documentDir.path);
  Hive.registerAdapter(FavoriteAdapter());
  await Hive.openBox<Favorite>(favoriteBoxName);
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
        ChangeNotifierProvider<ModelRepository>(
            create: (_) => ModelRepository())
        // FutureProvider(create: (context) => ModelRepository().getsearchedList())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(),
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
