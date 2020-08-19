import 'package:NewsApp_Chingu/methods/functions.dart';
import 'package:NewsApp_Chingu/models/news_model_structure.dart';
import 'package:NewsApp_Chingu/models/search.dart';
import 'package:flutter/foundation.dart';

class ModelRepository with ChangeNotifier {
  bool _isSearching = false;
  Future<List<Article>> articleList() async {
    var list = await Functions().getNewsFromApi();
    notifyListeners();
    return list;
  }

  Future<List<Search>> getsearchedList(String query) async {
    _isSearching = true;
    notifyListeners();
    var list = await Functions().getSearchedList(query: query);
    notifyListeners();
    return list;
  }

  set isSearchingToFalse(bool isSearchingTofalse) {
    _isSearching = isSearchingTofalse;
  }

  bool get isSearching => _isSearching;
}
