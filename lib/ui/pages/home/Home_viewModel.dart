import '../../../app/enums/enums.dart';
import '../../../app/locator/locator.dart';
import '../../../app/routes/route_generator.gr.dart';
import '../../../services/news_services/functions.dart';
import '../../../services/prefs/hive_prefs.dart';
import '../../../services/navigation_service/navigation_services.dart';
import '../../../ui/pages/favorites/favorite_model.dart';
import '../../../ui/pages/home/news_model_structure.dart';
import '../../../ui/pages/search/search.dart';
import 'package:hive/hive.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends FutureViewModel<List<Article>> {
  final NavigationService _navigationService = locator<NavigationService>();
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

  ///navigation
  void navigate(String routeName,
      {DetailsPageArgsFor detailsPageArgsFor,
      int index,
      Favorite fav,
      bool isSearch,
      String query,
      Function snack,
      List<Search> searchedlist,
      List<Article> articles,
      bool allArticlesPage = false}) {
    dynamic arguments;

    if (isSearch == true) {
      _isSearching = true;
      getsearchedList(
        query, //Controller.text
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
          } else {
            _isSearching = false;
            snack();
          }
        },
      );
    } else if (isSearch == false) {
      switch (detailsPageArgsFor) {
        case DetailsPageArgsFor.detailsPageHomepage:
          arguments = DetailsPageArguments(
            index: index,
            articleAuthor: _articles[index].articleAuthor,
            articleContent: _articles[index].articleContent,
            articleDescription: _articles[index].articleDescription,
            articlePublishedAT: _articles[index].articlePublishedAT,
            articleTitle: _articles[index].articleTitle,
            articleUrl: _articles[index].articleUrl,
            articleUrlToImage: _articles[index].articleUrlToImage,
          );
          break;
        case DetailsPageArgsFor.detailsPageFavorites:
          arguments = DetailsPageArguments(
            articleAuthor: fav.favoriteAuthor,
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
            articleAuthor: searchedlist[index].resultAuthor,
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
                  articleAuthor: articles[index].articleAuthor,
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
  void addtoFav(int index, Box<Favorite> favoriteBox, function()) {
    Favorite favorite = Favorite(
        favoriteAuthor: articles[index].articleAuthor,
        favoriteContent: articles[index].articleContent,
        favoriteDescription: articles[index].articleDescription,
        favoriteTitle: articles[index].articleTitle,
        favoritePublishedAT: articles[index].articlePublishedAT,
        favoriteUrl: articles[index].articleUrl,
        favoriteUrlToImage: articles[index].articleUrlToImage);
    favoriteBox.add(favorite).then((value) {
      function();
    });
  }

  List<Article> get articles => _articles;
  Box<Favorite> get favoriteBox => _favoriteBox;
  bool get isSearching => _isSearching;

  @override
  Future<List<Article>> futureToRun() => articleList();
}
