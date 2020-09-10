import 'package:NewsApp_Chingu/ui/const/color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SliverAppBarWidget extends StatelessWidget {
  final String author;
  final String imageUrl;
  final Widget child;
  final Widget iconChild;

  const SliverAppBarWidget(
      {Key key, this.author, this.imageUrl, this.child, this.iconChild})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          floating: true,
          expandedHeight: (MediaQuery.of(context).size.width / 1.5),
          backgroundColor: constColor1,
          actions: [iconChild],
          flexibleSpace: FlexibleSpaceBar(
            title: Text(author),
            background: FadeInImage(
              fit: BoxFit.cover,
              placeholder: AssetImage("assets/placeHolderImage.png"),
              image: CachedNetworkImageProvider(imageUrl),
            ),
          ),
        ),
        SliverFillRemaining(
          child: child,
          hasScrollBody: true,
          fillOverscroll: true,
        ),
      ],
    );
  }
}
