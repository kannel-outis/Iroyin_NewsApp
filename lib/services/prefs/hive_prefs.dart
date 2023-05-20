import '../../models/favorite_model.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveInit {
  static const String favoriteBoxName = "favorites";
  Future hiveInit() async {
    final documentDir =
        await getApplicationDocumentsDirectory(); //app memory path
    Hive.init(documentDir.path);
    Hive.registerAdapter(FavoriteAdapter());
    await Hive.openBox<Favorite>(favoriteBoxName);
  }
}
