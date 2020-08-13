class Article {
  final String articleTitle;
  final String articleDescription;
  final String articleUrl;
  final String articleUrlToImage;
  final String articleAuthor;
  final String articlePublishedAT;
  final String articleContent;

  Article({
    this.articleTitle,
    this.articleAuthor,
    this.articleDescription,
    this.articleUrl,
    this.articleUrlToImage,
    this.articleContent,
    this.articlePublishedAT,
  });

  // Article.fromjson(Map<String, dynamic> fromJson)
  //     : articleTitle = fromJson['articles'][0]['title'],
  //       articleDescription = fromJson['articles'][0]['description'],
  //       articleUrl = fromJson['articles'][0]['url'],
  //       articleUrlToImage = fromJson['articles'][0]['urlToImage'],
  //       articlePublishedAT = fromJson['articles'][0]['publishedAt'];
}
