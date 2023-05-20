import 'package:flutter/material.dart';
import 'style.dart';

class WrapperRefresher extends StatelessWidget {
  final Widget child;

  const WrapperRefresher({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppStyle.refreshSize(size: MediaQuery.of(context).size);
    return child;
  }
}
