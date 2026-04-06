import 'package:flutter/material.dart';

import 'constants/color_manger.dart';
import 'constants/font_manager.dart';
import 'constants/style_manager.dart';
import 'constants/values_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    useMaterial3: false, // set true if using Material 3
    // ===== Main colors =====
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.primaryLight,
    primaryColorDark: ColorManager.primaryDark,
    disabledColor: ColorManager.textSecondary,
    splashColor: ColorManager.primaryDark,
    scaffoldBackgroundColor: ColorManager.whiteColor,

    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: ColorManager.primaryDark,
      error: ColorManager.errorColor,
    ),

    // ===== Card Theme =====
    cardTheme: CardThemeData(
      color: ColorManager.whiteColor,
      shadowColor: ColorManager.subtitleText,
      elevation: AppSize.s4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
    ),

    // ===== AppBar Theme =====
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: ColorManager.primary,
      elevation: AppSize.s4,
      iconTheme: IconThemeData(color: ColorManager.whiteColor),
      titleTextStyle: getSemiBoldStyle(
        color: ColorManager.whiteColor,
        fontSize: FontSize.s16,
      ),
    ),

    // ===== Button Theme =====
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManager.textSecondary,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.primaryDark,
    ),

    // ===== Elevated Button Theme =====
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorManager.primary,
        foregroundColor: ColorManager.whiteColor,
        textStyle: getRegularStyle(
          color: ColorManager.whiteColor,
          fontSize: FontSize.s16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s8),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p16,
          vertical: AppPadding.p12,
        ),
      ),
    ),

    // ===== Text Theme =====
    textTheme: TextTheme(
      headlineLarge: getSemiBoldStyle(
        color: ColorManager.blackColor,
        fontSize: FontSize.s20,
      ),
      titleMedium: getMediunStyle(
        color: ColorManager.blackColor,
        fontSize: FontSize.s16,
      ),
      bodyMedium: getRegularStyle(
        color: ColorManager.blackColor,
        fontSize: FontSize.s14,
      ),
      bodySmall: getRegularStyle(
        color: ColorManager.subtitleText,
        fontSize: FontSize.s12,
      ),
      labelLarge: getSemiBoldStyle(
        color: ColorManager.primary,
        fontSize: FontSize.s14,
      ),
    ),

    // ===== Cursor & Selection Colors =====
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: ColorManager.primary,
      selectionColor: ColorManager.primary.withValues(alpha: 0.1),
      selectionHandleColor: ColorManager.primary,
    ),

    // ===== Input Field Theme =====
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorManager.whiteColor,
      hintStyle: getRegularStyle(color: ColorManager.textSecondary),
      labelStyle: getMediunStyle(color: ColorManager.blackColor),
      helperStyle: getRegularStyle(color: ColorManager.blackColor),
      errorStyle: getRegularStyle(color: ColorManager.errorColor),
      contentPadding: const EdgeInsets.all(AppPadding.p12),

      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.borderColor,
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.borderColor1,
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.errorColor,
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.errorColor,
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
    ),

    // ===== Icon Theme =====
    iconTheme: IconThemeData(color: ColorManager.primary, size: AppSize.s24),
  );
}
