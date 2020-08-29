import 'package:NewsApp_Chingu/ui/pages/advanced_search/advanced_search.dart';
import 'package:NewsApp_Chingu/ui/pages/all_articles/all_articles_page.dart';
import 'package:NewsApp_Chingu/ui/pages/details/details_news_page.dart';
import 'package:NewsApp_Chingu/ui/pages/favorites/favorites.dart';
import 'package:NewsApp_Chingu/ui/pages/home/home_page.dart';
import 'package:NewsApp_Chingu/ui/pages/search/search_result_page.dart';
import 'package:auto_route/auto_route_annotations.dart';

// class RoutesGenerator {
//   static Route<dynamic> onGenerate(RouteSettings settings) {
//     List<String> args = settings.arguments;
//   }
// }

@MaterialAutoRouter(
  routes: <AutoRoute>[
    // initial route is named "/"
    MaterialRoute(page: MyHomePage, initial: true),
    MaterialRoute(page: AdvancedSearchPage, path: "/Advance_Search"),
    MaterialRoute(page: AllArticlesPage, path: "/All_Articles"),
    MaterialRoute(page: DetailsPage, path: "/Details_Page"),
    MaterialRoute(page: FavoritesPage, path: "/Favorite_Page"),
    MaterialRoute(page: SearchResultPage, path: "/Search_Result_Page"),
  ],
)
class $Router {}
