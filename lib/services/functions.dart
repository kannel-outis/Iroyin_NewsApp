import 'dart:convert';

import 'package:NewsApp_Chingu/ui/pages/home/news_model_structure.dart';
import 'package:NewsApp_Chingu/ui/pages/search/search.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class WebServiceApi {
  Future<List<Article>> getNewsFromApi();
  Future<List<Search>> getSearchedList();
  Future<List<Search>> getAdvanceSearchedList();
}

class Functions extends WebServiceApi {
  // final DotEnv dotEnv = DotEnv();
  static final String apiKey = DotEnv().env['apiKey'];

  String dateTimeAsString = DateTime.now().toString().substring(0, 10);

  @override
  Future<List<Article>> getNewsFromApi() async {
    List<Article> articles = [];

    try {
      Response<String> response = await Dio().get(
          "https://newsapi.org/v2/everything?q=politics&from=$dateTimeAsString&to=2020-08-19&sortBy=publishedAt&pageSize=100&apiKey=$apiKey");
      if (response.statusCode == 200) {
        Map<String, dynamic> responseDecode = json.decode(response.data);
        responseDecode['articles'].forEach((element) {
          Article article = Article.fromJson(element);
          articles.add(article);
        });
      } else {
        print(response.data);
      }
    } catch (e) {
      print(e.toString());
    }

    return articles;
  }

  @override
  Future<List<Search>> getSearchedList({String query}) async {
    List<Search> searchedList = [];
    try {
      await Dio()
          .get<String>(
              "https://newsapi.org/v2/everything?qInTitle=$query&from=$dateTimeAsString&to=2020-08-19&sortBy=popularity&pageSize=100&apiKey=$apiKey")
          .then((response) {
        if (response.statusCode == 200) {
          var jsonDecode = json.decode(response.data);
          List jsonList = jsonDecode['articles'];
          for (var article in jsonList) {
            final Search articleReceived = Search.fromJson(article);
            searchedList.add(articleReceived);
          }
        } else {
          print(response.data);
        }
      });
    } catch (e) {
      print(e.toString);
    }
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
      await Dio()
          .get<String>(
              "https://newsapi.org/v2/everything?qInTitle=$query&from=$from&to=$to&sortBy=$sortBy&pageSize=100&language=$lang&apiKey=$apiKey")
          .then((response) {
        if (response.statusCode == 200) {
          var jsonDecode = json.decode(response.data);
          List jsonList = jsonDecode['articles'];
          for (var article in jsonList) {
            final Search articleReceived = Search.fromJson(article);
            searchedList.add(articleReceived);
          }
        } else {
          print(response.data);
        }
      });
    } catch (e) {
      print(e.toString);
    }
    return searchedList;
  }
}
