import 'package:NewsApp_Chingu/app/style/style.dart';

import '../../../app/enums/enums.dart';
import '../../../app/routes/route_generator.gr.dart';
import '../../../models/favorite_model.dart';
import '../../../ui/pages/home/Home_viewModel.dart';
import '../../../models/news_model_structure.dart';
import '../../../models/search.dart';
import '../../../ui/responsive_conditions/responsive_conditions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ListViewTile extends StatelessWidget {
  final String? title;
  final String? imageUrl;
  final String? timePublished;
  final String? source;
  final int? tag;
  final List<Article>? articles;
  final List<Search>? searchedList;
  final DetailsPageArgsFor? detailsPageArgsFor;
  final Favorite? fav;

  const ListViewTile(
      {this.tag,
      Key? key,
      @required this.detailsPageArgsFor,
      @required this.title,
      @required this.imageUrl,
      @required this.timePublished,
      @required this.source,
      this.searchedList,
      this.fav,
      this.articles})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ResponsiveConditions.allArticlesPageParams(context);
    HomeViewModel model = HomeViewModel();
    return Container(
        height: MediaQuery.of(context).size.height * .137,
        child: GestureDetector(
          onTap: () {
            model.navigate(
              Routes.detailsPage,
              detailsPageArgsFor: detailsPageArgsFor,
              fav: fav,
              searchedlist: searchedList,
              articles: articles,
              index: tag,
              isSearch: false,
            );
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
                  tag: tag!,
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
                      title ?? "Unknown",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyle.appStyle?.text.body,
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
                          style: AppStyle.appStyle?.text.bodyBold,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Flexible(
                                child: Text(
                                  source ?? "Unknown",
                                  overflow: TextOverflow.ellipsis,
                                  style: AppStyle.appStyle?.text.bodyBold,
                                ),
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