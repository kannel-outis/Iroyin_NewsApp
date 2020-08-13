import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.articleAuthor),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            tag: widget.index.toString(),
                            transitionOnUserGestures: true,
                            child: FadeInImage(
                              placeholder:
                                  AssetImage("assets/placeHolderImage.png"),
                              image: CachedNetworkImageProvider(
                                  widget.articleUrlToImage),
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
                                child: Text("by ${widget.articleAuthor}",
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
                          widget.articleTitle.toUpperCase(),
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
                    child: Text(widget.articleContent),
                  ),
                ],
              ),
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
                  child: Text("Open page"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
