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
  static customListParams(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    if (deviceHeight <= 600) {
      customListItemResponsiveDeviceHeight = deviceHeight * .101;
      customListResponsiveDeviceWidth = deviceWidth - 200;
      customListFontSize = 10.0;
    } else if (deviceHeight > 600 && deviceHeight < 800) {
      customListItemResponsiveDeviceHeight = deviceHeight * .110;
      customListResponsiveDeviceWidth = deviceWidth - 231;
      customListFontSize = 12;
    } else {
      customListFontSize = 13.0;
      customListResponsiveDeviceWidth = deviceWidth - 231;
      customListItemResponsiveDeviceHeight = deviceHeight * .110;
    }
  }

  static articleOfTheDayParams(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;

    if (deviceHeight <= 600) {
      articleOfTheDayTitlePlateHeight = 35;
      articleOfTheDayMainCardHeight = deviceHeight * .34;
      articleOfTheDayArticleAuthorFontSize = 14;
      articleOfTheDayArticleTitleFontSize = 11;
    } else {
      articleOfTheDayTitlePlateHeight = 50;
      articleOfTheDayMainCardHeight = deviceHeight * .36;
      articleOfTheDayArticleAuthorFontSize = 18;
      articleOfTheDayArticleTitleFontSize = 14;
    }
  }
}
