import 'package:NewsApp_Chingu/app/locator/locator.dart';
import 'package:NewsApp_Chingu/ui/pages/home/news_model_structure.dart';
import 'package:NewsApp_Chingu/ui/pages/search/search.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'helpers.dart';

abstract class ApiHandlers {
  Future<List<Article>?> getNewsFromApi();
  Future<List<Search>> getSearchedList();
  Future<List<Search>> getAdvanceSearchedList();
}

class Handlers extends ApiHandlers {
  var _helpers = locator<Helpers>();
  final String? apiKey = env['apiKey'];

  String dateTimeAsString = DateTime.now().toString().substring(0, 10);

  @override
  Future<List<Search>> getAdvanceSearchedList(
      {String? query,
      String? from,
      String? to,
      String? sortBy,
      String? lang}) async {
    String url =
        "https://newsapi.org/v2/everything?qInTitle=$query&from=$from&to=$to&sortBy=$sortBy&pageSize=100&language=$lang&apiKey=$apiKey";
    return await _helpers.getAdvanceSearchedList(url: url);
  }

  @override
  Future<List<Article>?> getNewsFromApi() async {
    String url =
        "https://newsapi.org/v2/everything?q=politics&from=$dateTimeAsString&to=2020-08-19&sortBy=publishedAt&pageSize=100&apiKey=$apiKey";
    return await _helpers.getNewsFromApi(url: url);
  }

  @override
  Future<List<Search>> getSearchedList({String? query}) async {
    String url =
        "https://newsapi.org/v2/everything?qInTitle=$query&from=$dateTimeAsString&to=2020-08-19&sortBy=popularity&pageSize=100&apiKey=$apiKey";
    return await _helpers.getSearchedList(url: url);
  }
}
