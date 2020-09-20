import 'package:NewsApp_Chingu/app/routes/route_generator.gr.dart';
import 'package:NewsApp_Chingu/ui/pages/search/search.dart';
import 'package:NewsApp_Chingu/ui/widgets/list_view_tile.dart';
import 'package:flutter/material.dart';

class SearchResultPage extends StatefulWidget {
  final List<Search> searchedlist;
  final String searchedquery;

  const SearchResultPage({Key key, this.searchedlist, this.searchedquery})
      : super(key: key);
  @override
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Results found on ${widget.searchedquery}"),
      ),
      body: Container(
        child: Container(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.searchedlist.length,
              itemBuilder: (context, index) {
                return ListViewTile(
                  title: widget.searchedlist[index].resultTitle,
                  imageUrl: widget.searchedlist[index].resultUrlToImage,
                  timePublished: widget.searchedlist[index].resultPublishedAT,
                  source: widget.searchedlist[index].resultAuthor,
                  articles: widget.searchedlist,
                  tag: index,
                  arguments: DetailsPageArguments(
                    articleAuthor: widget.searchedlist[index].resultAuthor,
                    articleContent: widget.searchedlist[index].resultContent,
                    articleDescription:
                        widget.searchedlist[index].resultDescription,
                    articlePublishedAT:
                        widget.searchedlist[index].resultPublishedAT,
                    articleTitle: widget.searchedlist[index].resultTitle,
                    articleUrl: widget.searchedlist[index].resultUrl,
                    articleUrlToImage:
                        widget.searchedlist[index].resultUrlToImage,
                    index: index,
                  ),
                );
              }),
        ),
      ),
    );
  }
}
