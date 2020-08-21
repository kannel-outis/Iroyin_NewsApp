import 'package:NewsApp_Chingu/models/news_model_structure.dart';
import 'package:flutter/cupertino.dart';

String articleAuthor(int index, List<Article> articles) {
  if (articles[index].articleAuthor == null) {
    return "No Source";
  }
  return articles[index].articleAuthor.length > 18
      ? articles[index]
          .articleAuthor
          .replaceRange(19, articles[index].articleAuthor.length, "...")
      : articles[index].articleAuthor;
}

String articleTitle(int index, List<Article> articles) {
  if (articles[index].articleTitle == null) {
    return "No Source";
  }
  return articles[index].articleTitle.length > 50
      ? articles[index]
          .articleTitle
          .replaceRange(51, articles[index].articleTitle.length, "...")
      : articles[index].articleTitle;
}
