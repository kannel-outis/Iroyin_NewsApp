import 'package:NewsApp_Chingu/app/style/style.dart';
import 'package:NewsApp_Chingu/ui/pages/home/home_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../app/enums/enums.dart';
import '../../../app/routes/route_generator.gr.dart';
import '../../../ui/const/color.dart';
import '../../../models/favorite_model.dart';
import '../../../ui/pages/home/Home_viewModel.dart';
import '../../../models/news_model_structure.dart';
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
  Widget build(BuildContext context, WidgetRef ref) {
    var model = ref.watch(homeViewModel);
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
                  child: (articles.length > 0)
                      ? AODBox(
                          index: index,
                          article: articles[index],
                          context: context,
                          favoriteBox: favoriteBox,
                          deviceHeight: deviceHeight,
                          model: model,
                        )
                      : Center(
                          child: Text("Loading..."),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AODBox extends StatelessWidget {
  const AODBox({
    Key? key,
    required this.index,
    required this.article,
    required this.context,
    required this.favoriteBox,
    required this.deviceHeight,
    required this.model,
  }) : super(key: key);

  final int index;
  final Article article;
  final BuildContext context;
  final Box<Favorite> favoriteBox;
  final double deviceHeight;
  final HomeViewModel model;

  @override
  Widget build(BuildContext context) {
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
                    imageErrorBuilder: (context, stack, obj) {
                      return Image.asset("assets/placeHolderImage.png");
                    },
                    placeholder: AssetImage("assets/placeHolderImage.png"),
                    image: CachedNetworkImageProvider(
                      "${article.articleUrlToImage}",
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
                        "${article.articleTitle}",
                        style: AppStyle.appStyle?.text.body.copyWith(
                          color: Colors.white,
                          height: 1.5,
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
              SizedBox(width: 10),
              Flexible(
                child: Text(
                  "${article.articleTitle}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyle.appStyle?.text.h3.copyWith(
                    color: Colors.white,
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
                      Share.share("${article.articleUrl}");
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
}
