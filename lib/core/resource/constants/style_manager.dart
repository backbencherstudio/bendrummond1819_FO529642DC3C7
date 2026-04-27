import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'font_manager.dart';

TextStyle _getTextStyle(
  double fontSize,
  String fontFamily,
  FontWeight fontWeight,
  Color color,
) {
  return TextStyle(
    fontSize: fontSize.sp,
    fontFamily: fontFamily,
    fontWeight: fontWeight,
    color: color,
  );
}

// ===== Light Style =====
TextStyle getLightStyle8_500({
  double fontSize = FontSize.s8,
  FontWeight fontWeight = FontWeightManager.medium500,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontConstants.fontFamily, fontWeight, color);
}

TextStyle getLightStyle12_400({
  double fontSize = FontSize.s12,
  FontWeight fontWeight = FontWeightManager.regular400,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontConstants.fontFamily, fontWeight, color);
}

TextStyle getLightStyle14_400({
  double fontSize = FontSize.s14,
  FontWeight fontWeight = FontWeightManager.regular400,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontConstants.fontFamily, fontWeight, color);
}

TextStyle getLightStyle14_500({
  double fontSize = FontSize.s14,
  FontWeight fontWeight = FontWeightManager.medium500,

  required Color color,
}) {
  return _getTextStyle(fontSize, FontConstants.fontFamily, fontWeight, color);
}

TextStyle getLight300Style16({
  double fontSize = FontSize.s16,
  FontWeight fontWeight = FontWeightManager.light300,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontConstants.fontFamily, fontWeight, color);
}

// ===== Regular Style =====
TextStyle getRegularStyle16_400({
  double fontSize = FontSize.s16,
  FontWeight fontWeight = FontWeightManager.regular400,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontConstants.fontFamily, fontWeight, color);
}

TextStyle getRegularStyle14_400({
  double fontSize = FontSize.s14,
  FontWeight fontWeight = FontWeightManager.regular400,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontConstants.fontFamily, fontWeight, color);
}
TextStyle getRegularStyle18_400({
  double fontSize = FontSize.s18,
  FontWeight fontWeight = FontWeightManager.regular400,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontConstants.fontFamily, fontWeight, color);
}
TextStyle getRegularStyle16_500({
  double fontSize = FontSize.s16,
  FontWeight fontWeight = FontWeightManager.medium500,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontConstants.fontFamily, fontWeight, color);
}

TextStyle getRegularStyle16_600({
  double fontSize = FontSize.s16,
  FontWeight fontWeight = FontWeightManager.semiBold600,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontConstants.fontFamily, fontWeight, color);
}

TextStyle getRegularStyle20_500({
  double fontSize = FontSize.s20,
  FontWeight fontWeight = FontWeightManager.medium500,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontConstants.fontFamily, fontWeight, color);
}

// ===== Medium Style =====
TextStyle getMediumStyle18({
  double fontSize = FontSize.s18,
  FontWeight fontWeight = FontWeightManager.medium500,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontConstants.fontFamily, fontWeight, color);
}

// ===== SemiBold Style =====
TextStyle getSemiBoldStyle22({
  double fontSize = FontSize.s22,
  FontWeight fontWeight = FontWeightManager.semiBold600,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontConstants.fontFamily, fontWeight, color);
}

// ===== Bold Style =====
TextStyle getBoldStyle24({
  double fontSize = FontSize.s24,
  FontWeight fontWeight = FontWeightManager.bold700,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontConstants.fontFamily, fontWeight, color);
}

TextStyle getBoldStyle32({
  double fontSize = FontSize.s32,
  FontWeight fontWeight = FontWeightManager.semiBold600,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontConstants.fontFamily, fontWeight, color);
}
TextStyle getRegularStyle20_600({
  double fontSize = FontSize.s20,
  FontWeight fontWeight = FontWeightManager.semiBold600,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontConstants.fontFamily, fontWeight, color);
}
