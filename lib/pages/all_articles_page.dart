import 'package:NewsApp_Chingu/const/color.dart';
import 'package:NewsApp_Chingu/methods/functions.dart';
import 'package:NewsApp_Chingu/models/news_model_structure.dart';
import 'package:NewsApp_Chingu/pages/details_news_page.dart';
import 'package:NewsApp_Chingu/widgets/list_view_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllArticlesPage extends StatefulWidget {
  @override
  _AllArticlesPageState createState() => _AllArticlesPageState();
}

class _AllArticlesPageState extends State<AllArticlesPage> {
  final Functions functions = Functions();
  Future<Null> refreshIndi() async {
    await functions.getNewsFromApi();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final articles = Provider.of<List<Article>>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: constColor1,
        title: Text("All Articles"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Container(
          child: RefreshIndicator(
            onRefresh: refreshIndi,
            child: ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  return ListViewTile(
                    articles: articles,
                    tag: index,
                    title: articles[index].articleTitle,
                    timePublished:
                        articles[index].articlePublishedAT.substring(0, 10),
                    source: articles[index].articleAuthor,
                    imageUrl: articles[index].articleUrlToImage,
                    route: DetailsPage(
                      articleAuthor: articles[index].articleAuthor,
                      articleContent: articles[index].articleContent,
                      articleDescription: articles[index].articleDescription,
                      articlePublishedAT: articles[index].articlePublishedAT,
                      articleTitle: articles[index].articleTitle,
                      articleUrl: articles[index].articleUrl,
                      articleUrlToImage: articles[index].articleUrlToImage,
                      index: index,
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
