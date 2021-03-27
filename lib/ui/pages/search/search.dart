class Search {
  final String? resultTitle;
  final String? resultDescription;
  final String? resultUrl;
  final String? resultUrlToImage;
  final String? resultAuthor;
  final String? resultPublishedAT;
  final String? resultContent;

  Search(
      {this.resultTitle,
      this.resultDescription,
      this.resultUrl,
      this.resultUrlToImage,
      this.resultAuthor,
      this.resultPublishedAT,
      this.resultContent});

  Search.fromJson(Map<String, dynamic> article)
      : resultAuthor = article['author'],
        resultTitle = article['title'],
        resultDescription = article['description'],
        resultContent = article['content'],
        resultUrl = article['url'],
        resultPublishedAT = article['publishedAt'],
        resultUrlToImage = article['urlToImage'];
}
