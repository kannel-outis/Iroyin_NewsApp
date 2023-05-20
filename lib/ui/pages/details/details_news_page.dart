import 'package:NewsApp_Chingu/app/routes/route_generator.gr.dart';
import 'package:NewsApp_Chingu/app/style/wrapper_refresher.dart';

import '../../../models/favorite_model.dart';
import '../../../ui/pages/home/Home_viewModel.dart';
import '../../../ui/custom/widgets/sliver_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:hive/hive.dart';
import 'package:share/share.dart';

class DetailsPage extends StatefulWidget {
  final DetailsPageArguments detailsPageArguments;
  DetailsPage({required this.detailsPageArguments});
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldMessengerState> _messengerKey =
      GlobalKey<ScaffoldMessengerState>();
  late final Box<Favorite> favoriteBox;
  @override
  void initState() {
    super.initState();
    favoriteBox = HomeViewModel().favOp();
  }

  @override
  Widget build(BuildContext context) {
    return WrapperRefresher(
      child: Scaffold(
        key: _messengerKey,
        body: SliverAppBarWidget(
          author: "${widget.detailsPageArguments.articleAuthor ?? "Unknown"}",
          iconChild: IconButton(
              icon: Icon(
                Icons.favorite,
                size: 20,
              ),
              onPressed: () {
                Favorite favorite = Favorite(
                    favoriteAuthor:
                        widget.detailsPageArguments.articleAuthor ?? "Unknown",
                    favoriteContent:
                        widget.detailsPageArguments.articleContent ?? "Unknown",
                    favoriteDescription:
                        widget.detailsPageArguments.articleDescription ??
                            "Unknown",
                    favoriteTitle:
                        widget.detailsPageArguments.articleTitle ?? "Unknown",
                    favoritePublishedAT:
                        widget.detailsPageArguments.articlePublishedAT ??
                            "Unknown",
                    favoriteUrl:
                        widget.detailsPageArguments.articleUrl ?? "Unknown",
                    favoriteUrlToImage:
                        widget.detailsPageArguments.articleUrlToImage ??
                            "Unknown");
                favoriteBox.add(favorite).then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("added to favorites"),
                    ),
                  );
                });
              }),
          tag: widget.detailsPageArguments.index,
          imageUrl: "${widget.detailsPageArguments.articleUrlToImage}",
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "${widget.detailsPageArguments.articleTitle ?? "Unknown"}"
                        .toUpperCase(),
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
                  "${widget.detailsPageArguments.articlePublishedAT ?? ""}",
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
                widget.detailsPageArguments.articleContent ??
                    "A content Could not be recieved at the Moment. please click on the Open browser button to view the content.",
                style: TextStyle(
                    color: (widget.detailsPageArguments.articleContent == null)
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
                child: TextButton(
                  onPressed: () {
                    FlutterWebBrowser.openWebPage(
                        url: "${widget.detailsPageArguments.articleUrl}");
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
            Share.share("${widget.detailsPageArguments.articleUrl}");
          },
          child: Icon(
            Icons.share,
            size: 15,
          ),
        ),
      ),
    );
  }
}
