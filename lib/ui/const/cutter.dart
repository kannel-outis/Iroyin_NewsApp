import 'package:NewsApp_Chingu/ui/pages/home/news_model_structure.dart';
import 'package:flutter/cupertino.dart';

String articleAuthor(int index, List<Article> articles, BuildContext context) {
  if (articles[index].articleAuthor == null) {
    return "Unknown Source";
  } else if (MediaQuery.of(context).size.shortestSide >= 600 &&
      MediaQuery.of(context).size.shortestSide <= 800) {
    return articles[index].articleAuthor;
  }

  return articles[index].articleAuthor.length > 15
      ? articles[index]
          .articleAuthor
          .replaceRange(16, articles[index].articleAuthor.length, "...")
      : articles[index].articleAuthor;
}

String articleTitle(int index, List<Article> articles, BuildContext context) {
  if (articles[index].articleTitle == null) {
    return "Unknown Source";
  }
  if (MediaQuery.of(context).size.height <= 600) {
    return articles[index].articleTitle.length > 15
        ? articles[index]
            .articleTitle
            .replaceRange(16, articles[index].articleTitle.length, "...")
        : articles[index].articleTitle;
  } else if (MediaQuery.of(context).size.height > 600 &&
      MediaQuery.of(context).size.height < 800) {
    return articles[index].articleTitle.length > 40
        ? articles[index]
            .articleTitle
            .replaceRange(41, articles[index].articleTitle.length, "...")
        : articles[index].articleTitle;
  } else if (MediaQuery.of(context).size.shortestSide >= 600 &&
      MediaQuery.of(context).size.shortestSide <= 800) {
    return articles[index].articleTitle.length > 90
        ? articles[index]
            .articleTitle
            .replaceRange(91, articles[index].articleTitle.length, "...")
        : articles[index].articleTitle;
  }
  return articles[index].articleTitle.length > 50
      ? articles[index]
          .articleTitle
          .replaceRange(51, articles[index].articleTitle.length, "...")
      : articles[index].articleTitle;
}

/////////////////////////////////
///allArticleCutter
String allArticleTitleCutter(int index, String article, BuildContext context) {
  if (article == null) {
    return "Unknown";
  }
  if (MediaQuery.of(context).size.height <= 600) {
    return article.length > 40
        ? article.replaceRange(41, article.length, "...")
        : article;
  } else if (MediaQuery.of(context).size.height > 600) {
    return article;
  }
  return article.length > 65
      ? article.replaceRange(66, article.length, "...")
      : article;
}

String allArticleSourceCutter(int index, String source, BuildContext context) {
  if (source == null) {
    return "Unknown";
  }
  if (MediaQuery.of(context).size.height <= 600) {
    return source.length > 10
        ? source.replaceRange(7, source.length, "...")
        : source;
  }
  return source.length > 15
      ? source.replaceRange(10, source.length, "...")
      : source;
}
