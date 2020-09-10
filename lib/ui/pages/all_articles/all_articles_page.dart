import 'package:NewsApp_Chingu/app/routes/route_generator.gr.dart';
import 'package:NewsApp_Chingu/ui/const/color.dart';
import 'package:NewsApp_Chingu/ui/pages/home/Home_viewModel.dart';
import 'package:NewsApp_Chingu/ui/pages/home/news_model_structure.dart';
import 'package:NewsApp_Chingu/ui/widgets/list_view_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AllArticlesPage extends StatefulWidget {
  final List<Article> articles;

  const AllArticlesPage({Key key, this.articles}) : super(key: key);
  @override
  _AllArticlesPageState createState() => _AllArticlesPageState();
}

class _AllArticlesPageState extends State<AllArticlesPage> {
  final HomeViewModel model = HomeViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: constColor1,
          title: Text("All Articles"),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Container(
            child: widget.articles != null
                ? RefreshIndicator(
                    onRefresh: model.articleList,
                    child: ListView.builder(
                        itemCount: widget.articles.length,
                        itemBuilder: (context, index) {
                          return ListViewTile(
                            articles: widget.articles,
                            tag: index,
                            title: widget.articles[index].articleTitle,
                            timePublished: widget
                                .articles[index].articlePublishedAT
                                .substring(0, 10),
                            source: widget.articles[index].articleAuthor,
                            imageUrl: widget.articles[index].articleUrlToImage,
                            arguments: DetailsPageArguments(
                              articleAuthor:
                                  widget.articles[index].articleAuthor,
                              articleContent:
                                  widget.articles[index].articleContent,
                              articleDescription:
                                  widget.articles[index].articleDescription,
                              articlePublishedAT:
                                  widget.articles[index].articlePublishedAT,
                              articleTitle:
                                  widget.articles[index].articleTitle ??
                                      "No Title",
                              articleUrl: widget.articles[index].articleUrl,
                              articleUrlToImage:
                                  widget.articles[index].articleUrlToImage,
                              index: index,
                            ),
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
