import 'package:NewsApp_Chingu/ui/const/color.dart';
import 'package:NewsApp_Chingu/ui/const/cutter.dart';
import 'package:NewsApp_Chingu/ui/pages/home/news_model_structure.dart';
import 'package:NewsApp_Chingu/ui/responsive_conditions/responsive_conditions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomListItems extends StatelessWidget {
  final List<Article> articles;
  final int index;

  const CustomListItems({Key key, this.articles, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ResponsiveConditions.customListParams(context);
    return Container(
      margin: EdgeInsets.only(right: 20),
      width: ResponsiveConditions.customListResponsiveDeviceWidth,
      height: MediaQuery.of(context).size.height * .26,
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .149,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10), topLeft: Radius.circular(10)),
            ),
            child: Hero(
              tag: index.toString(),
              transitionOnUserGestures: true,
              child: FadeInImage(
                alignment: Alignment.topCenter,
                fit: BoxFit.fill,
                placeholder: AssetImage("assets/placeHolderImage.png"),
                image: CachedNetworkImageProvider(
                    "${articles[index].articleUrlToImage}"),
              ),
            ),
          ),
          Container(
            height: ResponsiveConditions.customListItemResponsiveDeviceHeight,
            color: constColor2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7),
                  child: Text("${articleTitle(index, articles, context)}",
                      style: TextStyle(
                          fontSize: ResponsiveConditions.customListFontSize,
                          color: Colors.white)),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      "${articleAuthor(index, articles, context)}",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: ResponsiveConditions.customListFontSize),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
