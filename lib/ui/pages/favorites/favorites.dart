import 'package:NewsApp_Chingu/app/routes/route_generator.gr.dart';
import 'package:NewsApp_Chingu/ui/pages/favorites/favorite_model.dart';
import 'package:NewsApp_Chingu/ui/pages/home/Home_viewModel.dart';
import 'package:NewsApp_Chingu/ui/widgets/list_view_tile.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  Box<Favorite> favoriteBox;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
        title: Text("Favorites"),
        actions: [
          FlatButton(
            onPressed: () {
              favoriteBox.clear().then(
                    (value) => _scaffoldKey.currentState.showSnackBar(
                      SnackBar(
                        content: Text("All favorites cleared"),
                      ),
                    ),
                  );
            },
            child: Text(
              "Clear all",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ],
      ),
      body: Container(
        child: ValueListenableBuilder<Box<Favorite>>(
            valueListenable: favoriteBox.listenable(),
            builder: (context, box, child) {
              List<int> keys = box.keys.cast<int>().toList();
              return ListView.builder(
                  itemCount: keys.length,
                  itemBuilder: (context, index) {
                    final Favorite fav = box.get(keys[index]);
                    return Dismissible(
                      key: Key(fav.favoriteTitle),
                      background: Container(
                        color: Theme.of(context).primaryColor,
                      ),
                      direction: DismissDirection.startToEnd,
                      onDismissed: (DismissDirection dismissDirection) {
                        if (dismissDirection == DismissDirection.startToEnd) {
                          keys.removeAt(index);
                          box.deleteAt(index).then((value) {
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text(
                                    "${fav.favoriteTitle} removed from favorites")));
                          });
                        }
                      },
                      child: ListViewTile(
                        arguments: DetailsPageArguments(
                          articleAuthor: fav.favoriteAuthor,
                          articleContent: fav.favoriteContent,
                          articleDescription: fav.favoriteDescription,
                          articlePublishedAT: fav.favoritePublishedAT,
                          articleTitle: fav.favoriteTitle,
                          articleUrl: fav.favoriteUrl,
                          articleUrlToImage: fav.favoriteUrlToImage,
                          index: index,
                        ),
                        tag: index,
                        title: fav.favoriteTitle,
                        imageUrl: fav.favoriteUrlToImage,
                        timePublished: fav.favoritePublishedAT,
                        source: fav.favoriteAuthor,
                      ),
                    );
                  });
            }),
      ),
    );
  }
}
