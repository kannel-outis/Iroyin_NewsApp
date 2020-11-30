import 'dart:convert';
import 'dart:io';

import '../../ui/pages/home/news_model_structure.dart';
import '../../ui/pages/search/search.dart';
import 'package:http/http.dart' as http;

abstract class WebServiceApi {
  Future<List<Article>> getNewsFromApi();
  Future<List<Search>> getSearchedList();
  Future<List<Search>> getAdvanceSearchedList();
}

class Helpers extends WebServiceApi {
  @override
  Future<List<Article>> getNewsFromApi({String url}) async {
    List<Article> articles = [];

    try {
      http.Response response = await http.get(url);
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
  Future<List<Search>> getSearchedList({String url}) async {
    List<Search> searchedList = [];
    try {
      await http.get(url).then((response) {
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
  Future<List<Search>> getAdvanceSearchedList({String url}) async {
    List<Search> searchedList = [];
    try {
      await http.get(url).then((response) {
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
