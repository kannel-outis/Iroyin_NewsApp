import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

PageRoute platformSpecificNavigation({Widget page}) {
  if (Platform.isAndroid) {
    return MaterialPageRoute(builder: (context) => page);
  } else if (Platform.isIOS) {
    return CupertinoPageRoute(builder: (context) => page);
  }
  return CupertinoPageRoute(builder: (context) => page);
}
