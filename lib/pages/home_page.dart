import 'package:NewsApp_Chingu/const/color.dart';
import 'package:NewsApp_Chingu/methods/functions.dart';
import 'package:NewsApp_Chingu/models/news_model_structure.dart';
import 'package:NewsApp_Chingu/pages/all_articles_page.dart';
import 'package:NewsApp_Chingu/pages/details_news_page.dart';
import 'package:NewsApp_Chingu/widgets/platform_specific.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Functions functions = Functions();
  @override
  void initState() {
    super.initState();
  }

  String articleAuthor(int index, List<Article> articles) {
    if (articles[index].articleAuthor == null) {
      return "No Source";
    }
    return articles[index].articleAuthor.length > 18
        ? articles[index]
            .articleAuthor
            .replaceRange(19, articles[index].articleAuthor.length, "...")
        : articles[index].articleAuthor;
  }

  String articleTitle(int index, List<Article> articles) {
    if (articles[index].articleTitle == null) {
      return "No Source";
    }
    return articles[index].articleTitle.length > 50
        ? articles[index]
            .articleTitle
            .replaceRange(51, articles[index].articleTitle.length, "...")
        : articles[index].articleTitle;
  }

  Widget customListItems(List<Article> articles, int index) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      width: 170,
      child: Card(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .149,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10)),
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
            Expanded(
              child: Container(
                color: constColor2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("${articleTitle(index, articles)}",
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
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final articles = Provider.of<List<Article>>(context);
    print(articles[4].articleTitle.length);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: constColor1,
        title: Text(
          "Dashboard",
        ),
      ),
      drawer: Drawer(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.search,
                      size: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 130,
                      child: TextFormField(
                        cursorColor: fieldcolor,
                        style: TextStyle(fontSize: 23),
                        decoration: InputDecoration(
                          hintText: "Search",
                          hintStyle: TextStyle(
                            color: Color(0xFFbababa),
                          ),
                          contentPadding: EdgeInsets.only(bottom: -15, left: 5),
                          focusColor: fieldcolor,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: fieldcolor, style: BorderStyle.solid),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Articles",
                      style: TextStyle(fontSize: 17),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(platformSpecificNavigation(
                            page: AllArticlesPage()));
                      },
                      child: Text(
                        "All Articles",
                        style:
                            TextStyle(color: Color(0xFF3e9feb), fontSize: 17),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: MediaQuery.of(context).size.height * .25,
                child: articles != null
                    ? ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .push(platformSpecificNavigation(
                                      page: DetailsPage(
                                index: index,
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
                              )));
                            },
                            child: customListItems(articles, index),
                          );
                        },
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
              SizedBox(height: 40),
              Row(
                children: <Widget>[
                  Text(
                    "Article of the day",
                    style: TextStyle(
                      fontSize: 23,
                    ),
                  ),
                ],
              ),
              ArticleOfTheDay(),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ArticleOfTheDay extends StatelessWidget {
  String articleAuthor(int index, List<Article> articles) {
    if (articles[index].articleAuthor == null) {
      return "No Source";
    }
    return articles[index].articleAuthor.length > 13
        ? articles[index]
            .articleAuthor
            .replaceRange(14, articles[index].articleAuthor.length, "...")
        : articles[index].articleAuthor;
  }

  math.Random random = math.Random();
  @override
  Widget build(BuildContext context) {
    final articles = Provider.of<List<Article>>(context);
    int index = random.nextInt(articles.length);
    print(index);
    return Container(
      height: MediaQuery.of(context).size.height - 520,
      // color: Colors.green,
      child: Container(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 10,
              child: Container(
                height: MediaQuery.of(context).size.height - 600,
                width: MediaQuery.of(context).size.width - 70,
                decoration: BoxDecoration(
                  color: constColor4,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            Positioned(
              top: 20,
              child: Container(
                height: MediaQuery.of(context).size.height - 600,
                width: MediaQuery.of(context).size.width - 60,
                decoration: BoxDecoration(
                  color: constColor3,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            Positioned(
              top: 30,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  height: MediaQuery.of(context).size.height - 550,
                  width: MediaQuery.of(context).size.width - 50,
                  decoration: BoxDecoration(
                    color: constColor2,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(platformSpecificNavigation(
                                    page: DetailsPage(
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
                            )));
                          },
                          child: Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Hero(
                                  tag: index.toString(),
                                  child: FadeInImage(
                                    fit: BoxFit.cover,
                                    placeholder: AssetImage(
                                        "assets/placeHolderImage.png"),
                                    image: CachedNetworkImageProvider(
                                        "${articles[index].articleUrlToImage}"),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: 50,
                                  width: double.infinity,
                                  color: Colors.black.withOpacity(0.5),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "${articles[index].articleTitle}",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 70,
                        color: constColor2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              "${articleAuthor(index, articles)}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(
                                    Icons.favorite,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.bookmark,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.reply,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
