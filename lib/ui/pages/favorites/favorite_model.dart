import 'package:hive/hive.dart';
part 'favorite_model.g.dart';

@HiveType(typeId: 0)
class Favorite {
  @HiveField(0)
  final String favoriteTitle;
  @HiveField(1)
  final String favoriteDescription;
  @HiveField(2)
  final String favoriteUrl;
  @HiveField(3)
  final String favoriteUrlToImage;
  @HiveField(4)
  final String favoriteAuthor;
  @HiveField(5)
  final String favoritePublishedAT;
  @HiveField(6)
  final String favoriteContent;

  Favorite({
    this.favoriteTitle,
    this.favoriteDescription,
    this.favoriteUrl,
    this.favoriteUrlToImage,
    this.favoriteAuthor,
    this.favoritePublishedAT,
    this.favoriteContent,
  });
}
