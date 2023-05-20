import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationService {
  NavigationService._();
  static NavigationService? _instance;

  static NavigationService get instance {
    if (_instance == null) {
      _instance = NavigationService._();
      return _instance!;
    }
    return _instance!;
  }

  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo<T>(String routeName, {T? arguments}) {
    return navigatorKey.currentContext!.push(routeName, extra: arguments);
  }

  void goBack() {
    return navigatorKey.currentState!.pop();
  }
}
