import '../../../app/enums/enums.dart';
import '../../../ui/pages/search/search.dart';
import '../../../ui/custom/widgets/list_view_tile.dart';
import 'package:flutter/material.dart';

class SearchResultPage extends StatelessWidget {
  final List<Search> searchedlist;
  final String searchedquery;

  const SearchResultPage({Key key, this.searchedlist, this.searchedquery})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Results found on $searchedquery"),
      ),
      body: Container(
        child: Container(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: searchedlist.length,
              itemBuilder: (context, index) {
                return ListViewTile(
                  title: searchedlist[index].resultTitle,
                  imageUrl: searchedlist[index].resultUrlToImage,
                  timePublished: searchedlist[index].resultPublishedAT,
                  source: searchedlist[index].resultAuthor,
                  searchedList: searchedlist,
                  tag: index,
                  detailsPageArgsFor:
                      DetailsPageArgsFor.detailsPageSearchResults,
                );
              }),
        ),
      ),
    );
  }
}
