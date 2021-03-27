import 'package:NewsApp_Chingu/services/news_services/handlers.dart';
import 'package:flutter/cupertino.dart';

import '../../../app/enums/enums.dart';
import '../../../app/locator/locator.dart';
import '../../../app/routes/route_generator.gr.dart';
import '../../../services/prefs/hive_prefs.dart';
import '../../../services/navigation_service/navigation_services.dart';
import '../../../ui/pages/favorites/favorite_model.dart';
import '../../../ui/pages/home/news_model_structure.dart';
import '../../../ui/pages/search/search.dart';
import 'package:hive/hive.dart';

class HomeViewModel extends ChangeNotifier {
  final _navigationService = locator<NavigationService>();
  final _handlers = locator<Handlers>();
  List<Article>? _articles;
  bool _isSearching = false;
  late Box<Favorite> _favoriteBox;

  Future<List<Article>> articleList() async {
    var list = await _handlers.getNewsFromApi();
    if (list == null) return _articles!;
    _articles = list;
    notifyListeners();
    return _articles ?? [];
  }

  set isSearchingToFalse(bool isSearchingTofalse) {
    _isSearching = isSearchingTofalse;
  }

  Future<List<Search>> getsearchedList(String query) async {
    _isSearching = true;
    notifyListeners();
    var list = await _handlers.getSearchedList(query: query);
    notifyListeners();
    return list;
  }

  Box<Favorite> favOp() {
    notifyListeners();

    return _favoriteBox = Hive.box<Favorite>(HiveInit.favoriteBoxName);
  }

  ///navigation
  Future<void> navigate(String routeName,
      {DetailsPageArgsFor? detailsPageArgsFor,
      int? index,
      Favorite? fav,
      bool? isSearch,
      String? query,
      Function? snack,
      List<Search>? searchedlist,
      List<Article>? articles,
      bool allArticlesPage = false,
      Function()? call}) async {
    dynamic arguments;

    if (isSearch == true) {
      _isSearching = true;
      getsearchedList(
        query ?? "", //Controller.text
      ).then(
        (value) {
          if (value.length != 0) {
            _navigationService.navigateTo(
              routeName,
              arguments: SearchResultPageArguments(
                searchedquery: query,
                searchedlist: value,
              ),
            );
            _isSearching = false;
            call ?? print("null");
          } else {
            _isSearching = false;
            call ?? print("null");
            snack!();
          }
        },
      );
    } else if (isSearch == false) {
      switch (detailsPageArgsFor) {
        case DetailsPageArgsFor.detailsPageHomepage:
          arguments = DetailsPageArguments(
            index: index,
            articleAuthor: _articles![index!].articleAuthor,
            articleContent: _articles![index].articleContent,
            articleDescription: _articles![index].articleDescription,
            articlePublishedAT: _articles![index].articlePublishedAT,
            articleTitle: _articles![index].articleTitle,
            articleUrl: _articles![index].articleUrl,
            articleUrlToImage: _articles![index].articleUrlToImage,
          );
          break;
        case DetailsPageArgsFor.detailsPageFavorites:
          arguments = DetailsPageArguments(
            articleAuthor: fav!.favoriteAuthor,
            articleContent: fav.favoriteContent,
            articleDescription: fav.favoriteDescription,
            articlePublishedAT: fav.favoritePublishedAT,
            articleTitle: fav.favoriteTitle,
            articleUrl: fav.favoriteUrl,
            articleUrlToImage: fav.favoriteUrlToImage,
            index: index,
          );
          break;
        case DetailsPageArgsFor.detailsPageSearchResults:
          arguments = DetailsPageArguments(
            articleAuthor: searchedlist![index!].resultAuthor,
            articleContent: searchedlist[index].resultContent,
            articleDescription: searchedlist[index].resultDescription,
            articlePublishedAT: searchedlist[index].resultPublishedAT,
            articleTitle: searchedlist[index].resultTitle,
            articleUrl: searchedlist[index].resultUrl,
            articleUrlToImage: searchedlist[index].resultUrlToImage,
            index: index,
          );
          break;
        case DetailsPageArgsFor.detailsPageAllArticles:
          arguments = allArticlesPage
              ? AllArticlesPageArguments(articles: _articles)
              : DetailsPageArguments(
                  index: index,
                  articleAuthor: articles![index!].articleAuthor,
                  articleContent: articles[index].articleContent,
                  articleDescription: articles[index].articleDescription,
                  articlePublishedAT: articles[index].articlePublishedAT,
                  articleTitle: articles[index].articleTitle,
                  articleUrl: articles[index].articleUrl,
                  articleUrlToImage: articles[index].articleUrlToImage,
                );
          break;
        default:
          return arguments;
      }
      _navigationService.navigateTo(routeName, arguments: arguments);
    } else {
      _navigationService.navigateTo(routeName);
    }
  }

  //add to favorite
  ///articles replaced wuth _articles
  void addtoFav(int index, Box<Favorite> favoriteBox, function()) {
    Favorite favorite = Favorite(
        favoriteAuthor: _articles![index].articleAuthor,
        favoriteContent: _articles![index].articleContent,
        favoriteDescription: _articles![index].articleDescription,
        favoriteTitle: _articles![index].articleTitle,
        favoritePublishedAT: _articles![index].articlePublishedAT,
        favoriteUrl: _articles![index].articleUrl,
        favoriteUrlToImage: _articles![index].articleUrlToImage);
    favoriteBox.add(favorite).then((value) {
      function();
    });
  }

  List<Article>? get articles => _articles;
  Box<Favorite>? get favoriteBox => _favoriteBox;
  bool get isSearching => _isSearching;

  // @override
  // Future<List<Article>> futureToRun() => articleList();
}
