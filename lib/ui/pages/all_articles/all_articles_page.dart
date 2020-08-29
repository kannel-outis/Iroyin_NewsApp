import 'package:NewsApp_Chingu/app/routes/route_generator.gr.dart';
import 'package:NewsApp_Chingu/ui/const/color.dart';
import 'package:NewsApp_Chingu/ui/pages/home/Home_viewModel.dart';
import 'package:NewsApp_Chingu/ui/widgets/list_view_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AllArticlesPage extends StatefulWidget {
  @override
  _AllArticlesPageState createState() => _AllArticlesPageState();
}

class _AllArticlesPageState extends State<AllArticlesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: constColor1,
        title: Text("All Articles"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Container(
          child: ViewModelBuilder<HomeViewModel>.reactive(
            viewModelBuilder: () => HomeViewModel(),
            builder: (context, model, child) {
              return model.isBusy != true
                  ? RefreshIndicator(
                      onRefresh: model.articleList,
                      child: ListView.builder(
                          itemCount: model.articles.length,
                          itemBuilder: (context, index) {
                            return ListViewTile(
                              articles: model.articles,
                              tag: index,
                              title: model.articles[index].articleTitle,
                              timePublished: model
                                  .articles[index].articlePublishedAT
                                  .substring(0, 10),
                              source: model.articles[index].articleAuthor,
                              imageUrl: model.articles[index].articleUrlToImage,
                              arguments: DetailsPageArguments(
                                articleAuthor:
                                    model.articles[index].articleAuthor,
                                articleContent:
                                    model.articles[index].articleContent,
                                articleDescription:
                                    model.articles[index].articleDescription,
                                articlePublishedAT:
                                    model.articles[index].articlePublishedAT,
                                articleTitle:
                                    model.articles[index].articleTitle,
                                articleUrl: model.articles[index].articleUrl,
                                articleUrlToImage:
                                    model.articles[index].articleUrlToImage,
                                index: index,
                              ),
                            );
                          }),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            },
          ),
        ),
      ),
    );
  }
}
