import 'dart:convert';

import 'package:NewsApp_Chingu/models/news_model_structure.dart';
import 'package:NewsApp_Chingu/models/search.dart';
import 'package:dio/dio.dart';

abstract class WebServiceApi {
  Future<List<Article>> getNewsFromApi();
  Future<List<Search>> getSearchedList();
}

class Functions extends WebServiceApi {
  static const String apiKey = "a8afde170c67487fb748e3409714cf36";

  String dateTimeAsString = DateTime.now().toString().substring(0, 10);

  @override
  Future<List<Article>> getNewsFromApi() async {
    List<Article> articles = [];

    try {
      Response<String> response = await Dio().get(
          "https://newsapi.org/v2/everything?q=politics&from=$dateTimeAsString&to=2020-08-19&sortBy=popularity&pageSize=100&apiKey=$apiKey");
      if (response.statusCode == 200) {
        Map<String, dynamic> responseDecode = json.decode(response.data);
        responseDecode['articles'].forEach((element) {
          Article article = Article(
            articleTitle: element['title'],
            articleDescription: element['description'],
            articleUrl: element['url'],
            articleUrlToImage: element['urlToImage'],
            articlePublishedAT: element['publishedAt'],
            articleAuthor: element['author'],
            articleContent: element['content'],
          );
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
            final Search articleReceived = Search(
                resultAuthor: article['author'],
                resultTitle: article['title'],
                resultDescription: article['description'],
                resultContent: article['content'],
                resultUrl: article['url'],
                resultPublishedAT: article['publishedAt'],
                resultUrlToImage: article['urlToImage']);
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
