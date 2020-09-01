import 'package:NewsApp_Chingu/ui/const/color.dart';
import 'package:NewsApp_Chingu/ui/pages/favorites/favorite_model.dart';
import 'package:NewsApp_Chingu/ui/pages/home/Home_viewModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:hive/hive.dart';
import 'package:share/share.dart';

class DetailsPage extends StatefulWidget {
  final String articleContent;
  final String articleUrlToImage;
  final String articleUrl;
  final String articleTitle;
  final String articleAuthor;
  final String articleDescription;
  final String articlePublishedAT;
  final int index;
  DetailsPage(
      {this.articleAuthor,
      this.index,
      this.articleContent,
      this.articleDescription,
      this.articlePublishedAT,
      this.articleTitle,
      this.articleUrl,
      this.articleUrlToImage});
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Box<Favorite> favoriteBox;
  @override
  void initState() {
    super.initState();
    favoriteBox = HomeViewModel().favOp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        title: Text("${widget.articleAuthor ?? "Unknown"}"),
        backgroundColor: constColor1,
        actions: [
          IconButton(
              icon: Icon(
                Icons.favorite,
                size: 20,
              ),
              onPressed: () {
                Favorite favorite = Favorite(
                    favoriteAuthor: widget.articleAuthor,
                    favoriteContent: widget.articleContent,
                    favoriteDescription: widget.articleDescription,
                    favoriteTitle: widget.articleTitle,
                    favoritePublishedAT: widget.articlePublishedAT,
                    favoriteUrl: widget.articleUrl,
                    favoriteUrlToImage: widget.articleUrlToImage);
                favoriteBox.add(favorite).then((value) {
                  _scaffoldKey.currentState.showSnackBar(
                      SnackBar(content: Text("added to favorites")));
                });
              })
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ListView(
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Material(
                        elevation: 10,
                        child: Container(
                          child: Stack(
                            children: <Widget>[
                              Hero(
                                tag: widget.index,
                                transitionOnUserGestures: true,
                                child: FadeInImage(
                                  placeholder:
                                      AssetImage("assets/placeHolderImage.png"),
                                  image: CachedNetworkImageProvider(
                                      "${widget.articleUrlToImage}"),
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                child: Container(
                                  height: 40,
                                  width: 130,
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.8)),
                                  child: Center(
                                    child: Text(
                                        "by ${widget.articleAuthor ?? "Unknown"}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${widget.articleTitle.toUpperCase()}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 30),
                            ),
                          )
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "${widget.articlePublishedAT.substring(0, 10)}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.articleContent ??
                              "A content Could not be recieved at the Moment. please click on the Open browser button to view the content.",
                          style: TextStyle(
                              color: (widget.articleContent == null)
                                  ? Colors.red
                                  : Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: OutlineButton(
                onPressed: () {
                  FlutterWebBrowser.openWebPage(
                      url: "${widget.articleUrl}",
                      androidToolbarColor: Colors.indigo);
                },
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Open page"),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.launch,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Share.share("${widget.articleUrl}");
        },
        child: Icon(
          Icons.share,
          size: 15,
        ),
      ),
    );
  }
}
