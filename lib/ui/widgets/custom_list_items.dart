import 'package:NewsApp_Chingu/ui/const/color.dart';
import 'package:NewsApp_Chingu/ui/const/cutter.dart';
import 'package:NewsApp_Chingu/ui/pages/home/news_model_structure.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomListItems extends StatelessWidget {
  final List<Article> articles;
  final int index;

  const CustomListItems({Key key, this.articles, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      //TODO: make width media
      width: MediaQuery.of(context).size.width - 231,
      height: MediaQuery.of(context).size.height * .26,
      child: Column(
        children: [
          Container(
            //TODO: qmake height media rebuilding
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
            height: MediaQuery.of(context).size.height * .101,
            color: constColor2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: AutoSizeText("${articleTitle(index, articles)}",
                      maxLines: 2,
                      maxFontSize: 13,
                      style: TextStyle(fontSize: 13, color: Colors.white)),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      "${articleAuthor(index, articles)}",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
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

Widget customListItems(List<Article> articles, int index) {}
