class Article {
  final String? articleTitle;
  final String? articleDescription;
  final String? articleUrl;
  final String? articleUrlToImage;
  final String? articleAuthor;
  final String? articlePublishedAT;
  final String? articleContent;

  Article({
    this.articleTitle,
    this.articleAuthor,
    this.articleDescription,
    this.articleUrl,
    this.articleUrlToImage,
    this.articleContent,
    this.articlePublishedAT,
  });

  Article.fromJson(Map<String, dynamic> element)
      : articleTitle = element['title'],
        articleDescription = element['description'],
        articleUrl = element['url'],
        articleUrlToImage = element['urlToImage'],
        articlePublishedAT = element['publishedAt'],
        articleAuthor = element['author'],
        articleContent = element['content'];
}
