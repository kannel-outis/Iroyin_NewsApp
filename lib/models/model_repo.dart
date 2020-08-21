import 'package:NewsApp_Chingu/methods/functions.dart';
import 'package:NewsApp_Chingu/models/news_model_structure.dart';
import 'package:NewsApp_Chingu/models/search.dart';
import 'package:flutter/foundation.dart';

class ModelRepository with ChangeNotifier {
  bool _isSearching = false;

  String _sortBy;
  String _selectedLanguage;
  String _range;
  String _range2;
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

  Future<List<Search>> getAdvancedSearchedList(
      {String query,
      String from,
      String to,
      String sortBy,
      String lang}) async {
    _isSearching = true;
    notifyListeners();
    var list = await Functions().getAdvanceSearchedList(
      query: query,
      from: from,
      to: to,
      sortBy: sortBy,
      lang: lang,
    );
    notifyListeners();
    return list;
  }

  set isSearchingToFalse(bool isSearchingTofalse) {
    _isSearching = isSearchingTofalse;
  }

  void setPicker(DateTime dateTime) {
    if (dateTime != null) {
      _range = dateTime.toString().substring(0, 10);
      notifyListeners();
    }
  }

  void setPicker2(DateTime dateTime) {
    if (dateTime != null) {
      _range2 = dateTime.toString().substring(0, 10);
      notifyListeners();
    }
  }

  void selectLanguage(String option) {
    _selectedLanguage = option;

    notifyListeners();
  }

  void selectSortBy(String option) {
    _sortBy = option;
    notifyListeners();
  }

  bool get isSearching => _isSearching;
  String get sortBy => _sortBy;
  String get selectedLanguage => _selectedLanguage;
  String get range => _range;
  String get range2 => _range2;
}
