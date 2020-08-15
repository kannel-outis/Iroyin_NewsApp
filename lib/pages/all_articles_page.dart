import 'package:NewsApp_Chingu/const/color.dart';
import 'package:NewsApp_Chingu/methods/functions.dart';
import 'package:NewsApp_Chingu/models/news_model_structure.dart';
import 'package:NewsApp_Chingu/pages/details_news_page.dart';
import 'package:NewsApp_Chingu/widgets/platform_specific.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DetailsPage(
                            articleAuthor: articles[index].articleAuthor,
                            articleContent: articles[index].articleContent,
                            articleDescription:
                                articles[index].articleDescription,
                            articlePublishedAT:
                                articles[index].articlePublishedAT,
                            articleTitle: articles[index].articleTitle,
                            articleUrl: articles[index].articleUrl,
                            articleUrlToImage:
                                articles[index].articleUrlToImage,
                            index: index,
                          ),
                        ),
                      );
                    },
                    child: ListViewTile(
                      tag: index,
                      title: articles[index].articleTitle,
                      timePublished:
                          articles[index].articlePublishedAT.substring(0, 10),
                      source: articles[index].articleAuthor,
                      imageUrl: articles[index].articleUrlToImage,
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}

class ListViewTile extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String timePublished;
  final String source;
  final int tag;

  const ListViewTile({
    this.tag,
    Key key,
    @required this.title,
    @required this.imageUrl,
    @required this.timePublished,
    @required this.source,
  }) : super(key: key);

  String get titleTitle {
    if (title == null) {
      return "no title";
    }
    return title;
  }

  String get sourceSource {
    if (source == null) {
      return "No Source";
    }
    return source;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .137,
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
    );
  }
}
