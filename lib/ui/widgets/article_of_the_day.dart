import 'package:NewsApp_Chingu/app/routes/route_generator.gr.dart';
import 'package:NewsApp_Chingu/ui/const/color.dart';
import 'package:NewsApp_Chingu/ui/const/cutter.dart';
import 'package:NewsApp_Chingu/ui/pages/favorites/favorite_model.dart';
import 'package:NewsApp_Chingu/ui/pages/home/Home_viewModel.dart';
import 'package:NewsApp_Chingu/ui/pages/home/news_model_structure.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:hive/hive.dart';
import 'package:share/share.dart';
import 'package:stacked/stacked.dart';

class ArticleOfTheDay extends StatelessWidget {
  final Box<Favorite> favoriteBox;
  final int index;

  ArticleOfTheDay(this.favoriteBox, this.index, {Key key}) : super(key: key);

  Widget checkIfNull(
      List<Article> articles, BuildContext context, Box<Favorite> favoriteBox) {
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
                    width: 401,
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
                      height: 50,
                      width: double.infinity,
                      color: Colors.black.withOpacity(0.5),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${articles[index].articleTitle}",
                          style: TextStyle(color: Colors.white),
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
                    fontSize: 18,
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
                    IconButton(
                      icon: Icon(
                        Icons.bookmark,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () {},
                    ),
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
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) {
        return Container(
          height: 802.0 - 520,
          child: Container(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  top: 10,
                  child: Container(
                    height: 802.0 - 600,
                    width: 401.0 - 70,
                    decoration: BoxDecoration(
                      color: constColor4,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  child: Container(
                    height: 802.0 - 600,
                    width: 401.0 - 60,
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
                        height: 802.0 - 550,
                        width: 401.0 - 50,
                        decoration: BoxDecoration(
                          color: constColor2,
                        ),
                        child:
                            checkIfNull(model.articles, context, favoriteBox)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
