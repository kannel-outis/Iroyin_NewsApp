import 'package:NewsApp_Chingu/services/news_services/handlers.dart';
import 'package:NewsApp_Chingu/services/news_services/helpers.dart';
import 'package:http/http.dart';

import '../../services/navigation_service/navigation_services.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => Helpers(client: Client()));
  locator.registerLazySingleton(() => Handlers());
}
