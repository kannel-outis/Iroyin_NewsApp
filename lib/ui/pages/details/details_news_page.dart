import '../../../ui/pages/favorites/favorite_model.dart';
import '../../../ui/pages/home/Home_viewModel.dart';
import '../../../ui/widgets/sliver_bar.dart';
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
      body: SliverAppBarWidget(
        author: "${widget.articleAuthor ?? "Unknown"}",
        iconChild: IconButton(
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
            }),
        tag: widget.index,
        imageUrl: "${widget.articleUrlToImage}",
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "${widget.articleTitle ?? "Unknown"}".toUpperCase(),
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: MediaQuery.of(context).size.shortestSide > 700
                          ? 35
                          : 25),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "${widget.articlePublishedAT.substring(0, 10)}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.shortestSide > 700
                        ? 20
                        : 15),
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
                      : Colors.black,
                  fontSize:
                      MediaQuery.of(context).size.shortestSide > 700 ? 25 : 15),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.width * .5),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.width * .12,
              width: MediaQuery.of(context).size.width * .4,
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
                        width: 5,
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
          ),
        ],
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
