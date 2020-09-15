import 'package:flutter/material.dart';

class ResponsiveConditions {
  static double customListItemResponsiveDeviceHeight;
  static double customListResponsiveDeviceWidth;
  static double customListFontSize;

  //////
  ///
  ///
  ///
  //Article of the day params
  static double articleOfTheDayTitlePlateHeight;
  static double articleOfTheDayMainCardHeight;
  static double articleOfTheDayArticleAuthorFontSize;
  static double articleOfTheDayArticleTitleFontSize;
  //////
  ///
  ///
  ///
  ///
  //All articles Page Params
  static double allArticlesListViewTileTitleFontSize;
  static double allArticlesListViewTileSourceAndTimeFontSize;
  static double allArticlesListViewTileImageSize;

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
    } else if (deviceHeight > 600 && deviceHeight < 800) {
      allArticlesListViewTileTitleFontSize = 13;
      allArticlesListViewTileSourceAndTimeFontSize = 10;
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
