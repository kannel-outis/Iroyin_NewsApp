import 'package:NewsApp_Chingu/services/functions.dart';
import 'package:NewsApp_Chingu/ui/pages/search/search.dart';
import 'package:stacked/stacked.dart';

class AdvancedSearchViewModel extends FutureViewModel<List<Search>> {
  bool _isSearching = false;
  String _sortBy;
  String _selectedLanguage;
  String _range;
  String _range2;
  bool get isSearching => _isSearching;

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

  set isSearching(bool progress) {
    _isSearching = false;
    notifyListeners();
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

  String get sortBy => _sortBy;
  String get selectedLanguage => _selectedLanguage;
  String get range => _range;
  String get range2 => _range2;

  @override
  Future<List<Search>> futureToRun() => getAdvancedSearchedList();
}
