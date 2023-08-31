
import 'package:flutter/material.dart';

import 'fonts_manager.dart';

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color){
  return  TextStyle(
    fontSize: fontSize,
    fontFamily: FontsConstants.fontFamily,
    fontWeight: fontWeight,
    color: color,
  );
}

TextStyle getRegularStyle({double fontSize= FontSize.s12, required Color color}){
  return _getTextStyle(fontSize, FontWeightManager.regular,color);
}

TextStyle getMediumStyle({double fontSize= FontSize.s12, required Color color}){
  return _getTextStyle(fontSize, FontWeightManager.medium,color);
}

TextStyle getLightStyle({double fontSize= FontSize.s12, required Color color}){
  return _getTextStyle(fontSize, FontWeightManager.light,color);
}

TextStyle getBoldStyle({double fontSize= FontSize.s12, required Color color}){
  return _getTextStyle(fontSize, FontWeightManager.bold,color);
}

TextStyle getSemiBoldStyle({double fontSize= FontSize.s12, required Color color}){
  return _getTextStyle(fontSize, FontWeightManager.semiBold,color);
}