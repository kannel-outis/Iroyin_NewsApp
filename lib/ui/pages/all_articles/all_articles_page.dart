import 'package:NewsApp_Chingu/app/style/wrapper_refresher.dart';
import 'package:NewsApp_Chingu/ui/pages/home/home_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../app/enums/enums.dart';
import '../../../app/routes/route_generator.gr.dart';
import '../../../ui/const/color.dart';
import '../../../ui/pages/home/Home_viewModel.dart';
import '../../../ui/custom/widgets/list_view_tile.dart';
import 'package:flutter/material.dart';

class AllArticlesPage extends ConsumerWidget {
  final AllArticlesPageArguments article;
  const AllArticlesPage({Key? key, required this.article}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef watch) {
    final HomeViewModel model = watch.watch(homeViewModel);
    return WrapperRefresher(
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: constColor1,
            title: Text("All Articles"),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              child: article.articles != null
                  ? RefreshIndicator(
                      onRefresh: model.articleList,
                      child: ListView.builder(
                          itemCount: article.articles!.length,
                          itemBuilder: (context, index) {
                            return ListViewTile(
                              articles: article.articles,
                              detailsPageArgsFor:
                                  DetailsPageArgsFor.detailsPageAllArticles,
                              tag: index,
                              title: article.articles![index].articleTitle,
                              timePublished: article
                                  .articles![index].articlePublishedAT!
                                  .substring(0, 10),
                              source: article.articles![index].articleAuthor,
                              imageUrl:
                                  article.articles![index].articleUrlToImage,
                            );
                          }),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          )),
    );
  }
}
