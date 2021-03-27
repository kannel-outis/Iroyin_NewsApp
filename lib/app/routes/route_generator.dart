import 'package:NewsApp_Chingu/ui/pages/advanced_search/advanced_search.dart';
import 'package:NewsApp_Chingu/ui/pages/all_articles/all_articles_page.dart';
import 'package:NewsApp_Chingu/ui/pages/details/details_news_page.dart';
import 'package:NewsApp_Chingu/ui/pages/error/error_page.dart';
import 'package:NewsApp_Chingu/ui/pages/favorites/favorites.dart';
import 'package:NewsApp_Chingu/ui/pages/home/home_page.dart';
import 'package:NewsApp_Chingu/ui/pages/search/search_result_page.dart';
import 'package:auto_route/annotations.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    // initial route is named "/"
    CupertinoRoute(page: MyHomePage, initial: true),
    CupertinoRoute(page: AdvancedSearchPage, path: "/Advance_Search"),
    CupertinoRoute(page: AllArticlesPage, path: "/All_Articles"),
    CupertinoRoute(page: DetailsPage, path: "/Details_Page"),
    CupertinoRoute(page: FavoritesPage, path: "/Favorite_Page"),
    CupertinoRoute(page: SearchResultPage, path: "/Search_Result_Page"),
    CupertinoRoute(page: ErrorPage, path: "/error_page"),
  ],
)
class $Router {}
