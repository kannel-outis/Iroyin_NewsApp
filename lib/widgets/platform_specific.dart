import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

PageRoute platformSpecificNavigation(BuildContext bContext, {Widget page}) {
  if (Platform.isAndroid) {
    return MaterialPageRoute(builder: (bContext) => page);
  } else if (Platform.isIOS) {
    return CupertinoPageRoute(builder: (bContext) => page);
  }
  return CupertinoPageRoute(builder: (bCcontext) => page);
}
