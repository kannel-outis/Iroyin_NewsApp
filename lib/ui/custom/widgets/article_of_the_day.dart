import 'package:NewsApp_Chingu/ui/pages/home/home_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../app/enums/enums.dart';
import '../../../app/routes/route_generator.gr.dart';
import '../../../ui/const/color.dart';
import '../../../ui/pages/favorites/favorite_model.dart';
import '../../../ui/pages/home/Home_viewModel.dart';
import '../../../ui/pages/home/news_model_structure.dart';
import '../../../ui/responsive_conditions/responsive_conditions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:hive/hive.dart';
import 'package:share/share.dart';

class ArticleOfTheDay extends ConsumerWidget {
  final List<Article> articles;
  final Box<Favorite> favoriteBox;
  final int index;

  const ArticleOfTheDay(this.favoriteBox, this.index, this.articles, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var model = watch(homeViewModel);
    var deviceHeight = MediaQuery.of(context).size.height;
    ResponsiveConditions.articleOfTheDayParams(context);
    return Container(
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
                  child: CheckIfNotNull(
                      index: index,
                      articles: articles,
                      context: context,
                      favoriteBox: favoriteBox,
                      deviceHeight: deviceHeight,
                      model: model),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CheckIfNotNull extends StatelessWidget {
  const CheckIfNotNull({
    Key? key,
    required this.index,
    required this.articles,
    required this.context,
    required this.favoriteBox,
    required this.deviceHeight,
    required this.model,
  }) : super(key: key);

  final int index;
  final List<Article> articles;
  final BuildContext context;
  final Box<Favorite> favoriteBox;
  final double deviceHeight;
  final HomeViewModel model;

  @override
  Widget build(BuildContext context) {
    if (articles.length > 0) {
      return Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                model.navigate(Routes.detailsPage,
                    isSearch: false,
                    index: index,
                    detailsPageArgsFor: DetailsPageArgsFor.detailsPageHomepage);
              },
              child: Stack(
                children: [
                  Container(
                    width: deviceHeight / 2,
                    child: FadeInImage(
                      fit: BoxFit.cover,
                      placeholder: AssetImage("assets/placeHolderImage.png"),
                      image: CachedNetworkImageProvider(
                          "${articles[index].articleUrlToImage}"),
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
                Flexible(
                  child: Text(
                    "${articles[index].articleTitle}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ResponsiveConditions
                          .articleOfTheDayArticleAuthorFontSize,
                      fontWeight: FontWeight.bold,
                    ),
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
                        model.addtoFav(
                            index,
                            favoriteBox,
                            () => ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("added to favorites"))));
                      },
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
}
