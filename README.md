# Iroyin_NewsApp

A mobile news Aplication.

## Overview

This app was created for the chingu Solo Challenge. It's a News app that gets news data from the [NewsApi](https://newsapi.org/).
And it is written with [Flutter](https://flutter.dev/)

## Features
This App has the following Features

- gets News Articles
- search Functionality
- Advanced Search Functionality (specific words, time range, language, SortBy)
- Share Article
- Webview to view article in InApp Browser
- reFresh to Load the most recent Articles
- add Article To favorites


## Running The Project
To Run this project Locally, You must first have the [Flutter Sdk](https://flutter.dev/docs/get-started/install) installed on your Computer.

Then:
1. Clone This Repo
2. Open Terminal and Navigate to the cloned Project Folder using:
```bash
    cd <My_CLONED_FOlDER_PATH>
```
3. Connect a Physical device and Activate "USB Debugging" on the device
4. Run:
```bash
    flutter pub get
```
5. When done, Run The command Line Below To install and Launch App on your Connected Device
```bash
    Flutter run
```
6. Read a lot of News!!!

PS: replace where it says apiKey with your api key. go to [newsApi](https://newsApi.org) to get an apiKey.Also remove the *await DotNet() line from main.dart and the apiKey variable from functions.dart

## Dependencies
-  [cached_network_image](https://pub.dev/packages/cached_network_image)
-  [flutter_web_browser](https://pub.dev/packages/flutter_web_browser)
-  [share](https://pub.dev/packages/share)
-  [fluttericon](https://pub.dev/packages/fluttericon)
-  [modal_progress_hud](https://pub.dev/packages/modal_progress_hud)
-  [hive_flutter](https://pub.dev/packages/hive_flutter)
-  [hive](https://pub.dev/packages/hive)
-  [path_provider](https://pub.dev/packages/path_provider)
-  [http](https://pub.dev/packages/http)
-  [auto_route](https://pub.dev/packages/auto_route)
-  [hooks_riverpod](https://pub.dev/packages/hooks_riverpod)
-  [flutter_hooks](https://pub.dev/packages/flutter_hooks)
-  [connectivity_wrapper](https://pub.dev/packages/connectivity_wrapper)







For help getting started with Flutter, view
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.