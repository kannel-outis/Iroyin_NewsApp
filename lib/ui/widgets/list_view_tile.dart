import 'package:NewsApp_Chingu/app/routes/route_generator.gr.dart';
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

  String get titleTitle {
    if (title == null) {
      return "Unknown";
    }
    return title;
  }

  String get sourceSource {
    if (source == null) {
      return "Unknown";
    }
    return source;
  }

  @override
  Widget build(BuildContext context) {
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
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
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Container(
                    width: 180,
                    child: Text(
                      "${titleTitle.length > 65 ? titleTitle.replaceRange(66, titleTitle.length, "...") : titleTitle}",
                      style: TextStyle(),
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
                        style: TextStyle(fontWeight: FontWeight.w500),
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
                                "${sourceSource.length > 15 ? sourceSource.replaceRange(16, sourceSource.length, "...") : sourceSource}",
                                style: TextStyle(fontWeight: FontWeight.bold),
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
