import 'dart:convert';
import 'dart:io';

import '../../ui/pages/home/news_model_structure.dart';
import '../../ui/pages/search/search.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class WebServiceApi {
  Future<List<Article>> getNewsFromApi();
  Future<List<Search>> getSearchedList();
  Future<List<Search>> getAdvanceSearchedList();
}

class Functions extends WebServiceApi {
  final String apiKey = DotEnv().env['apiKey'];

  String dateTimeAsString = DateTime.now().toString().substring(0, 10);

  @override
  Future<List<Article>> getNewsFromApi() async {
    List<Article> articles = [];

    try {
      http.Response response = await http.get(
          "https://newsapi.org/v2/everything?q=politics&from=$dateTimeAsString&to=2020-08-19&sortBy=publishedAt&pageSize=100&apiKey=$apiKey");
      if (response.statusCode == 200) {
        Map<String, dynamic> responseDecode = json.decode(response.body);
        responseDecode['articles'].forEach((element) {
          Article article = Article.fromJson(element);
          articles.add(article);
        });
      } else {}
    } on SocketException {}

    return articles;
  }

  @override
  Future<List<Search>> getSearchedList({String query}) async {
    List<Search> searchedList = [];
    try {
      await http
          .get(
              "https://newsapi.org/v2/everything?qInTitle=$query&from=$dateTimeAsString&to=2020-08-19&sortBy=popularity&pageSize=100&apiKey=$apiKey")
          .then((response) {
        if (response.statusCode == 200) {
          var jsonDecode = json.decode(response.body);
          List jsonList = jsonDecode['articles'];
          for (var article in jsonList) {
            final Search articleReceived = Search.fromJson(article);
            searchedList.add(articleReceived);
          }
        } else {}
      });
    } catch (e) {}
    return searchedList;
  }

  @override
  Future<List<Search>> getAdvanceSearchedList(
      {String query,
      String from,
      String to,
      String sortBy,
      String lang}) async {
    List<Search> searchedList = [];
    try {
      await http
          .get(
              "https://newsapi.org/v2/everything?qInTitle=$query&from=$from&to=$to&sortBy=$sortBy&pageSize=100&language=$lang&apiKey=$apiKey")
          .then((response) {
        if (response.statusCode == 200) {
          var jsonDecode = json.decode(response.body);
          List jsonList = jsonDecode['articles'];
          for (var article in jsonList) {
            final Search articleReceived = Search.fromJson(article);
            searchedList.add(articleReceived);
          }
        } else {}
      });
    } catch (e) {}
    return searchedList;
  }
}
