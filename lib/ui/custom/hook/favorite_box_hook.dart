import 'package:NewsApp_Chingu/models/favorite_model.dart';
import 'package:NewsApp_Chingu/ui/pages/home/Home_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive/hive.dart';

Box<Favorite> useFavoriteBox(BuildContext context) {
  return use(const _BoxHook());
}

class _BoxHook extends Hook<Box<Favorite>> {
  const _BoxHook();
  @override
  _BoxHookState createState() => _BoxHookState();
}

class _BoxHookState extends HookState<Box<Favorite>, _BoxHook> {
  late final Box<Favorite> favoriteBox;

  @override
  void initHook() {
    setState(() {
      favoriteBox = HomeViewModel().favOp();
    });
    super.initHook();
  }

  @override
  Box<Favorite> build(BuildContext context) {
    return favoriteBox;
  }
}
