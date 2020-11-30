import 'package:NewsApp_Chingu/ui/pages/home/home_page.dart';
import 'package:hooks_riverpod/all.dart';

import '../../../app/enums/enums.dart';
import '../../../ui/const/color.dart';
import '../../../ui/pages/home/Home_viewModel.dart';
import '../../../ui/pages/home/news_model_structure.dart';
import '../../../ui/widgets/list_view_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AllArticlesPage extends ConsumerWidget {
  final List<Article> articles;

  const AllArticlesPage({Key key, this.articles}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final HomeViewModel model = watch(homeViewModel);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: constColor1,
          title: Text("All Articles"),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Container(
            child: articles != null
                ? RefreshIndicator(
                    onRefresh: model.articleList,
                    child: ListView.builder(
                        itemCount: articles.length,
                        itemBuilder: (context, index) {
                          return ListViewTile(
                            articles: articles,
                            detailsPageArgsFor:
                                DetailsPageArgsFor.detailsPageAllArticles,
                            // index: index,
                            tag: index,
                            title: articles[index].articleTitle,
                            timePublished: articles[index]
                                .articlePublishedAT
                                .substring(0, 10),
                            source: articles[index].articleAuthor,
                            imageUrl: articles[index].articleUrlToImage,
                          );
                        }),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        ));
  }
}
