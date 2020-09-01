import 'package:NewsApp_Chingu/services/functions.dart';
import 'package:NewsApp_Chingu/services/hive_prefs.dart';
import 'package:NewsApp_Chingu/ui/pages/favorites/favorite_model.dart';
import 'package:NewsApp_Chingu/ui/pages/home/news_model_structure.dart';
import 'package:NewsApp_Chingu/ui/pages/search/search.dart';
import 'package:hive/hive.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends FutureViewModel<List<Article>> {
  List<Article> _articles;
  bool _isSearching = false;
  Box<Favorite> _favoriteBox;

  Future<List<Article>> articleList() async {
    var list = await Functions().getNewsFromApi();
    _articles = list;
    notifyListeners();
    return _articles;
  }

  set isSearchingToFalse(bool isSearchingTofalse) {
    _isSearching = isSearchingTofalse;
  }

  Future<List<Search>> getsearchedList(String query) async {
    _isSearching = true;
    notifyListeners();
    var list = await Functions().getSearchedList(query: query);
    notifyListeners();
    return list;
  }

  Box<Favorite> favOp() {
    notifyListeners();

    return _favoriteBox = Hive.box<Favorite>(HiveInit.favoriteBoxName);
  }

  List<Article> get articles => _articles;
  Box<Favorite> get favoriteBox => _favoriteBox;
  bool get isSearching => _isSearching;

  @override
  Future<List<Article>> futureToRun() => articleList();
}
