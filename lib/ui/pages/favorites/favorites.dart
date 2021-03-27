import 'package:NewsApp_Chingu/ui/custom/hook/favorite_box_hook.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../app/enums/enums.dart';
import '../../../ui/pages/favorites/favorite_model.dart';
import '../../../ui/custom/widgets/list_view_tile.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoritesPage extends HookWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var favoriteBox = useFavoriteBox(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        title: Text("Favorites"),
        actions: [
          FlatButton(
            onPressed: () {
              favoriteBox.clear().then(
                    (value) => _scaffoldKey.currentState!.showSnackBar(
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
              List<int> keys = box.keys.cast<int>().toList().reversed.toList();
              return ListView.builder(
                  itemCount: keys.length,
                  itemBuilder: (context, index) {
                    final Favorite? fav = box.get(keys[index]);
                    return Dismissible(
                      key: Key(fav!.favoriteTitle!),
                      background: Container(
                        color: Theme.of(context).primaryColor,
                      ),
                      direction: DismissDirection.startToEnd,
                      onDismissed: (DismissDirection dismissDirection) {
                        if (dismissDirection == DismissDirection.startToEnd) {
                          box.delete(keys[index]).then((value) {
                            keys.reversed.toList().removeAt(index);
                            if (favoriteBox.isEmpty) {
                              favoriteBox.clear();
                            }
                            _scaffoldKey.currentState!.showSnackBar(SnackBar(
                                content: Text(
                                    "${fav.favoriteTitle} removed from favorites")));
                          });
                        }
                      },
                      child: ListViewTile(
                        tag: index,
                        title: fav.favoriteTitle,
                        imageUrl: fav.favoriteUrlToImage,
                        timePublished: fav.favoritePublishedAT,
                        source: fav.favoriteAuthor,
                        detailsPageArgsFor:
                            DetailsPageArgsFor.detailsPageFavorites,
                        fav: fav,
                      ),
                    );
                  });
            }),
      ),
    );
  }
}
