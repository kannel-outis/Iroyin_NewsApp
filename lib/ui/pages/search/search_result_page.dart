import 'package:NewsApp_Chingu/app/routes/route_generator.gr.dart';
import 'package:NewsApp_Chingu/app/style/wrapper_refresher.dart';

import '../../../app/enums/enums.dart';
import '../../../ui/custom/widgets/list_view_tile.dart';
import 'package:flutter/material.dart';

class SearchResultPage extends StatelessWidget {
  final SearchResultPageArguments arguments;

  const SearchResultPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WrapperRefresher(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Results found on ${arguments.searchedquery}"),
        ),
        body: Container(
          child: Container(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: arguments.searchedlist.length,
                itemBuilder: (context, index) {
                  return ListViewTile(
                    title: arguments.searchedlist[index].resultTitle,
                    imageUrl: arguments.searchedlist[index].resultUrlToImage,
                    timePublished: arguments.searchedlist[index].resultPublishedAT,
                    source: arguments.searchedlist[index].resultAuthor,
                    searchedList: arguments.searchedlist,
                    tag: index,
                    detailsPageArgsFor:
                        DetailsPageArgsFor.detailsPageSearchResults,
                  );
                }),
          ),
        ),
      ),
    );
  }
}
