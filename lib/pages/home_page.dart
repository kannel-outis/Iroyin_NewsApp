import 'package:NewsApp_Chingu/const/color.dart';
import 'package:NewsApp_Chingu/methods/functions.dart';
import 'package:NewsApp_Chingu/models/news_model_structure.dart';
import 'package:NewsApp_Chingu/pages/details_news_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io' show Platform;

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

  PageRoute platformSpecificNavigation({Widget page}) {
    if (Platform.isAndroid) {
      return MaterialPageRoute(builder: (context) => page);
    } else if (Platform.isIOS) {
      return CupertinoPageRoute(builder: (context) => page);
    }
    return CupertinoPageRoute(builder: (context) => page);
  }

  @override
  Widget build(BuildContext context) {
    final articles = Provider.of<List<Article>>(context);
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
        padding: EdgeInsets.symmetric(horizontal: 35),
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
                height: 25,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Articles",
                      style: TextStyle(fontSize: 17),
                    ),
                    Text(
                      "All Articles",
                      style: TextStyle(color: Color(0xFF3e9feb), fontSize: 17),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                  height: 258,
                  child: articles != null
                      ? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: articles.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .push(platformSpecificNavigation(
                                        page: DetailsPage(
                                  index: index,
                                  articleAuthor: articles[index].articleAuthor,
                                  articleContent:
                                      articles[index].articleContent,
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
                              child: Container(
                                margin: EdgeInsets.only(right: 20),
                                width: 200,
                                child: Card(
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 150,
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
                                            placeholder: AssetImage(
                                                "assets/placeHolderImage.png"),
                                            image: CachedNetworkImageProvider(
                                                "${articles[index].articleUrlToImage}"),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          color: constColor2,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Text(
                                                    "${articles[index].articleTitle}",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.white)),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8.0),
                                                  child: Text(
                                                    "${articles[index].articleAuthor}",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
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
                              ),
                            );
                          },
                        )
                      : Center(child: CircularProgressIndicator())),
            ],
          ),
        ),
      ),
    );
  }
}
