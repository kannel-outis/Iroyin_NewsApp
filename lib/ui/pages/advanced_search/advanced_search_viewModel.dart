import 'package:NewsApp_Chingu/app/locator/locator.dart';
import 'package:NewsApp_Chingu/app/routes/route_generator.gr.dart';
import 'package:NewsApp_Chingu/services/functions.dart';
import 'package:NewsApp_Chingu/services/navigation_service/navigation_services.dart';
import 'package:NewsApp_Chingu/ui/pages/search/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class AdvancedSearchViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  bool _isSearching = false;
  String _sortBy;
  String _selectedLanguage;
  String _range;
  String _range2;

  Future<List<Search>> getAdvancedSearchedList(
      {String query,
      String from,
      String to,
      String sortBy,
      String lang}) async {
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

  set setIsSearching(bool progress) {
    _isSearching = progress;
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

  void navigate({String query, Function snack}) {
    setIsSearching = true;
    getAdvancedSearchedList(
      from: range,
      to: range2,
      lang: selectedLanguage,
      sortBy: sortBy,
      query: query, //Controller.text
    ).then(
      (value) {
        if (value.length != 0) {
          _navigationService.navigateTo(
            Routes.searchResultPage,
            arguments: SearchResultPageArguments(
              searchedquery: query,
              searchedlist: value,
            ),
          );
          setIsSearching = false;
        } else {
          snack();
        }
      },
    );
  }

  String get sortBy => _sortBy;
  String get selectedLanguage => _selectedLanguage;
  bool get isSearching => _isSearching;
  String get range => _range;
  String get range2 => _range2;
}
