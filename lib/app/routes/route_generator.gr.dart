// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

// import 'package:auto_route/auto_route.dart';
// import 'package:auto_route/legacy.dart';
import 'package:NewsApp_Chingu/models/news_model_structure.dart';
import 'package:NewsApp_Chingu/models/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import '../../ui/pages/advanced_search/advanced_search.dart';
// import '../../ui/pages/all_articles/all_articles_page.dart';
// import '../../ui/pages/details/details_news_page.dart';
// import '../../ui/pages/error/error_page.dart';
// import '../../ui/pages/favorites/favorites.dart';
// import '../../ui/pages/home/home_page.dart';
// import '../../ui/pages/home/news_model_structure.dart';
// import '../../ui/pages/search/search.dart';
// import '../../ui/pages/search/search_result_page.dart';

class Routes {
  static const String myHomePage = '/';
  static const String advancedSearchPage = '/Advance_Search';
  static const String allArticlesPage = '/All_Articles';
  static const String detailsPage = '/Details_Page';
  static const String favoritesPage = '/Favorite_Page';
  static const String searchResultPage = '/Search_Result_Page';
  static const String errorPage = '/error_page';
  static const all = <String>{
    myHomePage,
    advancedSearchPage,
    allArticlesPage,
    detailsPage,
    favoritesPage,
    searchResultPage,
    errorPage,
  };
}

// class Router extends RouterBase {
//   @override
//   List<RouteDef> get routes => _routes;
//   final _routes = <RouteDef>[
//     // RouteDef(Routes.myHomePage, page: MyHomePage),
//     // RouteDef(Routes.advancedSearchPage, page: AdvancedSearchPage),
//     // RouteDef(Routes.allArticlesPage, page: AllArticlesPage),
//     // RouteDef(Routes.detailsPage, page: DetailsPage),
//     // RouteDef(Routes.favoritesPage, page: FavoritesPage),
//     // RouteDef(Routes.searchResultPage, page: SearchResultPage),
//     RouteDef(Routes.errorPage, page: ErrorPage),
//   ];
//   @override
//   Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
//   final _pagesMap = <Type, AutoRouteFactory>{
//     MyHomePage: (data) {
//       return CupertinoPageRoute<dynamic>(
//         builder: (context) => MyHomePage(),
//         settings: data,
//       );
//     },
//     AdvancedSearchPage: (data) {
//       return CupertinoPageRoute<dynamic>(
//         builder: (context) => AdvancedSearchPage(),
//         settings: data,
//       );
//     },
//     AllArticlesPage: (data) {
//       final args = data.getArgs<AllArticlesPageArguments>(
//         orElse: () => AllArticlesPageArguments(),
//       );
//       return CupertinoPageRoute<dynamic>(
//         builder: (context) => AllArticlesPage(
//           key: args.key,
//           articles: args.articles,
//         ),
//         settings: data,
//       );
//     },
//     DetailsPage: (data) {
//       final args = data.getArgs<DetailsPageArguments>(
//         orElse: () => DetailsPageArguments(),
//       );
//       return CupertinoPageRoute<dynamic>(
//         builder: (context) => DetailsPage(
//           articleAuthor: args.articleAuthor,
//           index: args.index,
//           articleContent: args.articleContent,
//           articleDescription: args.articleDescription,
//           articlePublishedAT: args.articlePublishedAT,
//           articleTitle: args.articleTitle,
//           articleUrl: args.articleUrl,
//           articleUrlToImage: args.articleUrlToImage,
//         ),
//         settings: data,
//       );
//     },
//     FavoritesPage: (data) {
//       return CupertinoPageRoute<dynamic>(
//         builder: (context) => FavoritesPage(),
//         settings: data,
//       );
//     },
//     SearchResultPage: (data) {
//       final args = data.getArgs<SearchResultPageArguments>(
//         orElse: () => SearchResultPageArguments(),
//       );
//       return CupertinoPageRoute<dynamic>(
//         builder: (context) => SearchResultPage(
//           key: args.key,
//           searchedlist: args.searchedlist ?? [],
//           searchedquery: args.searchedquery,
//         ),
//         settings: data,
//       );
//     },
//     ErrorPage: (data) {
//       return CupertinoPageRoute<dynamic>(
//         builder: (context) => ErrorPage(),
//         settings: data,
//       );
//     },
//   };
// }

// /// ************************************************************************
// /// Arguments holder classes
// /// *************************************************************************

/// AllArticlesPage arguments holder class
class AllArticlesPageArguments {
  final Key? key;
  final List<Article>? articles;
  AllArticlesPageArguments({this.key, this.articles});
}

/// DetailsPage arguments holder class
class DetailsPageArguments {
  final String? articleAuthor;
  final int? index;
  final String? articleContent;
  final String? articleDescription;
  final String? articlePublishedAT;
  final String? articleTitle;
  final String? articleUrl;
  final String? articleUrlToImage;
  DetailsPageArguments(
      {this.articleAuthor,
      this.index,
      this.articleContent,
      this.articleDescription,
      this.articlePublishedAT,
      this.articleTitle,
      this.articleUrl,
      this.articleUrlToImage});
}

/// SearchResultPage arguments holder class
class SearchResultPageArguments {
  final Key? key;
  final List<Search> searchedlist;
  final String? searchedquery;
  SearchResultPageArguments(
      {this.key, required this.searchedlist, this.searchedquery});
}
