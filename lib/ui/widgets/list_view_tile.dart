import 'package:NewsApp_Chingu/app/routes/route_generator.gr.dart';
import 'package:NewsApp_Chingu/ui/const/cutter.dart';
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

  // String get titleTitle {
  //   if (title == null) {
  //     return "Unknown";
  //   }
  //   return title;
  // }

  String get sourceSource {
    if (source == null) {
      return "Unknown";
    }
    return source;
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
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
                    height: 60,
                    width: 60,
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
                  flex: deviceHeight <= 600 ? 2 : 1,
                  child: Container(
                    width: 180,
                    child: Text(
                      allArticleTitleCutter(tag, title, context),
                      style: TextStyle(fontSize: deviceHeight <= 600 ? 13 : 15),
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
                          fontSize: 10,
                        ),
                      )),
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Container(
                          // color: Colors.blue,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                allArticleSourceCutter(tag, source, context),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 10),
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
