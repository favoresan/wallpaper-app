import 'package:flutter/material.dart';

import 'font_manager.dart';

TextStyle _getStyleManager(
    double fontSize, Color color, FontWeight fontWeight, String fontFamily) {
  return TextStyle(
      fontWeight: fontWeight,
      fontSize: fontSize,
      fontFamily: fontFamily,
      color: color);
}

//regular style
TextStyle getRegularStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getStyleManager(
      fontSize, color, FontWeightManager.regular, FontConstants.fontFamily);
}

//light style
TextStyle getLightStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getStyleManager(
      fontSize, color, FontWeightManager.light, FontConstants.fontFamily);
}

//medium style
TextStyle getMediumStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getStyleManager(
      fontSize, color, FontWeightManager.medium, FontConstants.fontFamily);
}

//semiBold style
TextStyle getSemiBoldStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getStyleManager(
      fontSize, color, FontWeightManager.semiBold, FontConstants.fontFamily);
}

//bold style
TextStyle getBoldStyle({double fontSize = FontSize.s12, required Color color}) {
  return _getStyleManager(
      fontSize, color, FontWeightManager.bold, FontConstants.fontFamily);
}
