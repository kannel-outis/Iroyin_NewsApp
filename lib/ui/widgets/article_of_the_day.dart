import 'package:NewsApp_Chingu/app/routes/route_generator.gr.dart';
import 'package:NewsApp_Chingu/ui/const/color.dart';
import 'package:NewsApp_Chingu/ui/const/cutter.dart';
import 'package:NewsApp_Chingu/ui/pages/favorites/favorite_model.dart';
import 'package:NewsApp_Chingu/ui/pages/home/news_model_structure.dart';
import 'package:NewsApp_Chingu/ui/responsive_conditions/responsive_conditions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:hive/hive.dart';
import 'package:share/share.dart';

class ArticleOfTheDay extends StatelessWidget {
  final List<Article> articles;
  final Box<Favorite> favoriteBox;
  final int index;

  const ArticleOfTheDay(this.favoriteBox, this.index, this.articles, {Key key})
      : super(key: key);

  Widget checkIfNull(List<Article> articles, BuildContext context,
      Box<Favorite> favoriteBox, double deviceHeight) {
    if (articles != null) {
      return Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(Routes.detailsPage,
                    arguments: DetailsPageArguments(
                      articleAuthor: articles[index].articleAuthor,
                      articleContent: articles[index].articleContent,
                      articleDescription: articles[index].articleDescription,
                      articlePublishedAT: articles[index].articlePublishedAT,
                      articleTitle: articles[index].articleTitle,
                      articleUrl: articles[index].articleUrl,
                      articleUrlToImage: articles[index].articleUrlToImage,
                      index: index,
                    ));
              },
              child: Stack(
                children: [
                  Container(
                    width: deviceHeight / 2,
                    child: Hero(
                      tag: index,
                      child: FadeInImage(
                        fit: BoxFit.cover,
                        placeholder: AssetImage("assets/placeHolderImage.png"),
                        image: CachedNetworkImageProvider(
                            "${articles[index].articleUrlToImage}"),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: ResponsiveConditions
                          .articleOfTheDayTitlePlateHeight, //plate height
                      width: double.infinity,
                      color: Colors.black.withOpacity(0.5),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${articles[index].articleTitle}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: ResponsiveConditions
                                .articleOfTheDayArticleTitleFontSize,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 70,
            color: constColor2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  "${articleAuthor(index, articles)}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ResponsiveConditions
                        .articleOfTheDayArticleAuthorFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 20,
                      ),
                      disabledColor: Colors.grey,
                      onPressed: () {
                        ///articleOfTheDay viewModel
                        Favorite favorite = Favorite(
                            favoriteAuthor: articles[index].articleAuthor,
                            favoriteContent: articles[index].articleContent,
                            favoriteDescription:
                                articles[index].articleDescription,
                            favoriteTitle: articles[index].articleTitle,
                            favoritePublishedAT:
                                articles[index].articlePublishedAT,
                            favoriteUrl: articles[index].articleUrl,
                            favoriteUrlToImage:
                                articles[index].articleUrlToImage);
                        favoriteBox.add(favorite).then((value) {
                          Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text("added to favorites")));
                        });
                      },
                    ),
                    // IconButton(
                    //   icon: Icon(
                    //     Icons.bookmark,
                    //     color: Colors.white,
                    //     size: 20,
                    //   ),
                    //   onPressed: () {},
                    // ),
                    IconButton(
                      icon: Icon(
                        FontAwesome5.share,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () {
                        Share.share("${articles[index].articleUrl}");
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    }
    return Center(
        child: Text(
      "loading...",
      style: TextStyle(color: Colors.black45),
    ));
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    ResponsiveConditions.articleOfTheDayParams(context);
    return Container(
      ///36
      height: ResponsiveConditions.articleOfTheDayMainCardHeight,
      child: Container(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 10,
              child: Container(
                height: MediaQuery.of(context).size.height * .31,
                width: MediaQuery.of(context).size.width - 70,
                decoration: BoxDecoration(
                  color: constColor4,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            Positioned(
              top: 20,
              child: Container(
                height: MediaQuery.of(context).size.height * .31,
                width: MediaQuery.of(context).size.width - 60,
                decoration: BoxDecoration(
                  color: constColor3,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            Positioned(
              top: 30,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                    height: MediaQuery.of(context).size.height * .32,
                    width: MediaQuery.of(context).size.width - 50,
                    decoration: BoxDecoration(
                      color: constColor2,
                    ),
                    child: checkIfNull(
                        articles, context, favoriteBox, deviceHeight)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// height: MediaQuery.of(context).size.height - 550,
