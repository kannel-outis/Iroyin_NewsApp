import 'package:NewsApp_Chingu/services/functions.dart';
import 'package:NewsApp_Chingu/services/hive_prefs.dart';
import 'package:NewsApp_Chingu/ui/pages/favorites/favorite_model.dart';
import 'package:NewsApp_Chingu/ui/pages/home/news_model_structure.dart';
import 'package:NewsApp_Chingu/ui/pages/search/search.dart';
import 'package:hive/hive.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends FutureViewModel<List<Article>> {
  List<Article> articles;
  bool _isSearching = false;
  bool get isSearching => _isSearching;
  Box<Favorite> _favoriteBox;
  Box<Favorite> get favoriteBox => _favoriteBox;

  Future<List<Article>> articleList() async {
    var list = await Functions().getNewsFromApi();
    articles = list;
    notifyListeners();
    return articles;
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

  @override
  Future<List<Article>> futureToRun() => articleList();
}
