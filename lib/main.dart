import 'package:NewsApp_Chingu/ui/pages/advanced_search/advanced_search.dart';
import 'package:NewsApp_Chingu/ui/pages/all_articles/all_articles_page.dart';
import 'package:NewsApp_Chingu/ui/pages/details/details_news_page.dart';
import 'package:NewsApp_Chingu/ui/pages/error/error_page.dart';
import 'package:NewsApp_Chingu/ui/pages/favorites/favorites.dart';
import 'package:NewsApp_Chingu/ui/pages/home/home_page.dart';
import 'package:NewsApp_Chingu/ui/pages/search/search_result_page.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import './services/navigation_service/navigation_services.dart';
import './ui/model_repo.dart';
// import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'app/locator/locator.dart';
import 'app/routes/route_generator.gr.dart' as routes;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ModelRepo().hiveInit();
  // await DotEnv().load(fileName: 'myApiKey.env');
  setupLocator();
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'IROYIN',
      theme: ThemeData(
        // useMaterial3: true,
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      routeInformationProvider: _router.routeInformationProvider,
    );
  }

  final _router = GoRouter(
    navigatorKey: NavigationService.instance.navigatorKey,
    // debugLogDiagnostics: true,
    initialLocation: routes.Routes.myHomePage,
    routes: [
      GoRoute(
        path: routes.Routes.myHomePage,
        builder: (context, state) => MyHomePage(),
      ),
      GoRoute(
        path: routes.Routes.advancedSearchPage,
        builder: (context, state) => AdvancedSearchPage(),
      ),
      GoRoute(
        path: routes.Routes.allArticlesPage,
        builder: (context, state) => AllArticlesPage(
          article: state.extra as routes.AllArticlesPageArguments,
        ),
      ),
      GoRoute(
        path: routes.Routes.detailsPage,
        builder: (context, state) => DetailsPage(
          detailsPageArguments: state.extra as routes.DetailsPageArguments,
        ),
      ),
      GoRoute(
        path: routes.Routes.favoritesPage,
        builder: (context, state) => FavoritesPage(),
      ),
      GoRoute(
        path: routes.Routes.searchResultPage,
        builder: (context, state) => SearchResultPage(
          arguments: state.extra as routes.SearchResultPageArguments,
        ),
      ),
      GoRoute(
        path: routes.Routes.errorPage,
        builder: (context, state) => ErrorPage(),
      ),
    ],
  );
}
