import 'package:flutter/material.dart';

class ResponsiveConditions {
  static late double customListItemResponsiveDeviceHeight;
  static late double customListResponsiveDeviceWidth;
  static late double customListFontSize;

  //////
  ///
  ///
  ///
  //Article of the day params
  static late double articleOfTheDayTitlePlateHeight;
  static late double articleOfTheDayMainCardHeight;
  static late double articleOfTheDayArticleAuthorFontSize;
  static late double articleOfTheDayArticleTitleFontSize;
  //////
  ///
  ///
  ///
  ///
  //All articles Page Params
  static late double allArticlesListViewTileTitleFontSize;
  static late double allArticlesListViewTileSourceAndTimeFontSize;
  static late double allArticlesListViewTileImageSize;

  static customListParams(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.shortestSide;
    if (deviceHeight <= 600) {
      customListItemResponsiveDeviceHeight = deviceHeight * .101;
      customListResponsiveDeviceWidth = deviceWidth - 200;
      customListFontSize = 10.0;
    } else if (deviceHeight > 600 && deviceHeight < 800) {
      customListItemResponsiveDeviceHeight = deviceHeight * .110;
      customListResponsiveDeviceWidth = deviceWidth - 210;
      customListFontSize = 12;
    } else if (deviceWidth >= 600 && deviceWidth < 750) {
      customListItemResponsiveDeviceHeight = deviceHeight * .101;
      customListResponsiveDeviceWidth = deviceWidth - 300;
      customListFontSize = 15.0;
    } else if (deviceWidth >= 760) {
      customListResponsiveDeviceWidth = deviceWidth - 400;
      customListFontSize = 18.0;
      customListItemResponsiveDeviceHeight = deviceHeight * .110;
    } else {
      customListFontSize = 13.0;
      customListResponsiveDeviceWidth = deviceWidth - 231;
      customListItemResponsiveDeviceHeight = deviceHeight * .110;
    }
  }

  static articleOfTheDayParams(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.shortestSide;
    if (deviceHeight <= 600) {
      articleOfTheDayTitlePlateHeight = 35;
      articleOfTheDayMainCardHeight = deviceHeight * .34;
      articleOfTheDayArticleAuthorFontSize = 14;
      articleOfTheDayArticleTitleFontSize = 11;
    } else if (deviceWidth >= 600) {
      articleOfTheDayArticleAuthorFontSize = 22;
      articleOfTheDayArticleTitleFontSize = 18;
      articleOfTheDayTitlePlateHeight = 70;
      articleOfTheDayMainCardHeight = deviceHeight * .34;
    } else {
      articleOfTheDayTitlePlateHeight = 50;
      articleOfTheDayMainCardHeight = deviceHeight * .36;
      articleOfTheDayArticleAuthorFontSize = 18;
      articleOfTheDayArticleTitleFontSize = 14;
    }
  }

  static allArticlesPageParams(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.shortestSide;
    if (deviceHeight <= 600) {
      allArticlesListViewTileTitleFontSize = 13;
      allArticlesListViewTileSourceAndTimeFontSize = 10;
      allArticlesListViewTileImageSize = 60;
    } else if (deviceHeight > 600 && deviceHeight < 800) {
      allArticlesListViewTileTitleFontSize = 13;
      allArticlesListViewTileSourceAndTimeFontSize = 10;
      allArticlesListViewTileImageSize = 60;
    } else if (deviceWidth >= 600) {
      allArticlesListViewTileImageSize = 80;
      allArticlesListViewTileTitleFontSize = 20;
      allArticlesListViewTileSourceAndTimeFontSize = 18;
    } else {
      allArticlesListViewTileTitleFontSize = 15;
      allArticlesListViewTileSourceAndTimeFontSize = 15;
      allArticlesListViewTileImageSize = 60;
    }
  }
}
