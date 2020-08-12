import 'dart:convert';

import 'package:NewsApp_Chingu/models/news_model_structure.dart';
import 'package:http/http.dart' as http;

class Functions {
  static const String apiKey = "a8afde170c67487fb748e3409714cf36";
  List<Article> articles = [];
  List list;
  Future<List<Article>> getNewsFromApi() async {
    try {
      http.Response response = await http.get(
          "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=$apiKey");
      if (response.statusCode == 200) {
        Map<String, dynamic> responseDecode = json.decode(response.body);

        list = responseDecode['articles'].forEach((element) {
          Article article = Article(
              articleTitle: element['title'],
              articleDescription: element['description'],
              articleUrl: element['url'],
              articleUrlToImage: element['urlToImage'],
              articlePublishedAT: element['publishedAt']);
          articles.add(article);
        });
      } else {
        print(response.body);
      }
    } catch (e) {
      print(e.toString());
    }

    return articles;
  }
}

// for (var l in list) {
//   // print(l['title']);
//   Article article = Article(
//       articleTitle: l['title'],
//       articleDescription: l['description'],
//       articleUrl: l['url'],
//       articleUrlToImage: l['urlToImage'],
//       articlePublishedAT: l['publishedAt']);
//   // print(article.articleUrl);
//   articles.add(article);
// }

// final Article article =
//     Article(articleTitle: responseDecode[' articles'][3]['title']);
// print(article.articleTitle);
// print(articles[0].articleTitle);
