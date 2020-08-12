class Article {
  final String articleTitle;
  final String articleDescription;
  final String articleUrl;
  final String articleUrlToImage;
  final String articlePublishedAT;

  Article(
      {this.articleTitle,
      this.articleDescription,
      this.articleUrl,
      this.articleUrlToImage,
      this.articlePublishedAT});

  // Article.fromjson(Map<String, dynamic> fromJson)
  //     : articleTitle = fromJson['articles'][0]['title'],
  //       articleDescription = fromJson['articles'][0]['description'],
  //       articleUrl = fromJson['articles'][0]['url'],
  //       articleUrlToImage = fromJson['articles'][0]['urlToImage'],
  //       articlePublishedAT = fromJson['articles'][0]['publishedAt'];
}
