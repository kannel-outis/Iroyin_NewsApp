import 'package:NewsApp_Chingu/app/style/wrapper_refresher.dart';
import 'package:NewsApp_Chingu/ui/custom/hook/favorite_box_hook.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../app/enums/enums.dart';
import '../../../models/favorite_model.dart';
import '../../../ui/custom/widgets/list_view_tile.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoritesPage extends HookWidget {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    var favoriteBox = useFavoriteBox(context);
    return WrapperRefresher(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          title: Text("Favorites"),
          actions: [
            TextButton(
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
                        resizeDuration: const Duration(milliseconds: 100),
                        onDismissed: (DismissDirection dismissDirection) {
                          if (dismissDirection == DismissDirection.startToEnd) {
                            keys.reversed.toList().removeAt(index);
                            Future.delayed(const Duration(milliseconds: 100))
                                .then(
                              (value) => box.delete(keys[index]).then(
                                (value) {
                                  if (favoriteBox.isEmpty) {
                                    favoriteBox.clear();
                                  }
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: Text(
                                          "${fav.favoriteTitle} removed from favorites")));
                                },
                              ),
                            );
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
      ),
    );
  }
}
