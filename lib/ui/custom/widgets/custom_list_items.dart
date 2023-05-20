import 'package:NewsApp_Chingu/app/style/style.dart';

import '../../../ui/const/color.dart';
import '../../../models/news_model_structure.dart';
import '../../../ui/responsive_conditions/responsive_conditions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomListItems extends StatelessWidget {
  final List<Article>? articles;
  final int? index;

  const CustomListItems({Key? key, this.articles, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ResponsiveConditions.customListParams(context);
    return Container(
      margin: EdgeInsets.only(right: 20),
      width: ResponsiveConditions.customListResponsiveDeviceWidth,
      height: MediaQuery.of(context).size.height * .26,
      constraints: BoxConstraints(
        minWidth: 200,
      ),
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
                    "${articles![index!].articleUrlToImage}"),
              ),
            ),
          ),
          Container(
            height: ResponsiveConditions.customListItemResponsiveDeviceHeight,
            color: constColor2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 7),
                    child: Text(
                      "${articles![index!].articleTitle}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyle.appStyle?.text.bodySmall.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      "${articles![index!].articleAuthor}",
                      overflow: TextOverflow.ellipsis,
                      style: AppStyle.appStyle?.text.bodySmallBold.copyWith(
                        color: Colors.white,
                      ),
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
