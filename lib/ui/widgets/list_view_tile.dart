import 'package:NewsApp_Chingu/app/routes/route_generator.gr.dart';
import 'package:NewsApp_Chingu/ui/const/cutter.dart';
import 'package:NewsApp_Chingu/ui/responsive_conditions/responsive_conditions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ListViewTile extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String timePublished;
  final String source;
  final int tag;
  final List articles;
  final Object arguments;

  const ListViewTile(
      {this.tag,
      Key key,
      @required this.arguments,
      @required this.title,
      @required this.imageUrl,
      @required this.timePublished,
      @required this.source,
      this.articles})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ResponsiveConditions.allArticlesPageParams(context);
    return Container(
        height: MediaQuery.of(context).size.height * .137,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(Routes.detailsPage, arguments: arguments);
          },
          child: Card(
            elevation: 5,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Hero(
                  tag: tag,
                  child: Container(
                    height:
                        ResponsiveConditions.allArticlesListViewTileImageSize,
                    width:
                        ResponsiveConditions.allArticlesListViewTileImageSize,
                    child: FadeInImage(
                      fit: BoxFit.fill,
                      placeholder: AssetImage("assets/placeHolderImage.png"),
                      image: CachedNetworkImageProvider("$imageUrl"),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    width: 180,
                    child: Text(
                      allArticleTitleCutter(tag, title, context),
                      style: TextStyle(
                          fontSize: ResponsiveConditions
                              .allArticlesListViewTileTitleFontSize),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Center(
                          child: Text(
                        "$timePublished",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: ResponsiveConditions
                              .allArticlesListViewTileSourceAndTimeFontSize,
                        ),
                      )),
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                allArticleSourceCutter(tag, source, context),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: ResponsiveConditions
                                        .allArticlesListViewTileSourceAndTimeFontSize),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
