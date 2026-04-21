import 'package:flutter/material.dart';

/// Centralized color palette for the app.
/// Defines both light and dark theme colors.
class ColorManager {
  ColorManager._();

  // ===== Primary Colors =====
  static const Color primary = Color(0xFFF0EBE3);
  static const Color secondary = Color(0xFFF7F3EB);
  static const Color primaryLight = Color(0xFFF7F3EB);
  static const Color primaryDark = Color(0xFF000C48);

  // ===== Background Colors =====
  static const Color background = Color(0xFFF5F5F5);
  static const Color secondaryBackGround = Color(0xFFFBF8F2);
  static const Color bottomNavBackGround = Color(0xFFEDE6DB);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color scaffoldLight = Color(0xFFFFFFFF);
  static const Color scaffoldDark = Color(0xFF1E1E1E);

  // ===== Text Colors =====
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color titleText = Color(0xFF2F3131);
  static const Color titleText1 = Color(0xFF535353);
  static const Color subtitleText = Color(0xFFF0EBE3);

  ///
  static const Color subtitleText1 = Color(0xFF60655C);
  static const Color mediumText = Color(0xFF363A33);

  // ===== Button & Label Colors =====
  static const Color buttonText = Color(0xFF334289);
  static const Color hintText = Color(0xFF5B5F5F);

  // ===== Neutral Colors =====
  static const Color blackColor = Color(0xFF000000);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color transparentColor = Colors.transparent;

  // ===== Border Colors =====
  static const Color borderColor = Color(0xFFFBF8F2);
  static const Color borderColor1 = Color(0xFFE0D9D1);
  static const Color borderColor2 = Color(0xFFDFE1E7);
  static const Color borderColor3 = Color(0xFFC4A06A);

  // ===== Container & Fill Colors =====
  static const Color containerColor = Color(0xFFEFEFEF);
  static const Color containerColor1 = Color(0xFFD9DDE2);
  static const Color fillColor = Color(0xFFFEF5F3);

  // ===== Feedback Colors =====
  static const Color errorColor = Color(0xFFE25839);
  static const Color successColor = Color(0xFF388E3C);
  static const Color warningColor = Color(0xFFFFA000);
  static const Color infoColor = Color(0xFF1976D2);

  // ===== Utility Colors =====
  static const Color shadowColor = Color(0x1A000000); // 10% opacity black
  static const Color dividerColor = Color(0xFFE0E0E0);
  static const Color overlayColor = Color(0x33000000); // 20% opacity black

  static const Color primaryButton = Color(0xFF5C473B);
  static const Color customOutlineButtonBorder = Color(0xFFDFE1E7);
  static const Color black400 = Color(0xFF4A4C56);
  static const Color formFieldColor = Color(0xFFFBF8F2);
  static const Color brown = Color(0xFF4A3A2F);
  static const Color brown300 = Color(0xFF867B74);
  static const Color brown400 = Color(0xFF6E6159);
  static const Color brown500 = Color(0xFF4A3A2F);
  static const Color brown200 = Color(0xFFE0D9D1);
  static const Color backButtonColor = Color(0xFFEDE6DB);
  static const Color navicons = Color(0xFF8C7055);
  static const Color gold = Color(0xFFA07848);

  static const Color gold2 = Color(0xFFD5BE90);

  static const Color redColor = Color(0xFFE53935);
  static const Color greyColor = Color(0xFFCFD1D3);

  static const LinearGradient metallicGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF4A3A2F),
      Color(0xFFB08A70),
      Color(0xFF4A3A2F),
      Color(0xFFB08A70),
      Color(0xFF4A3A2F),
      Color(0xFFB08A70),
    ],
  );

  static const LinearGradient linearGradientColor2 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF7C5638), Color(0xFFCA9C79)],
  );

  //
  static const Color cE9D6A5 = Color(0xFFE9D6A5);
  static const Color cEADFC6 = Color(0xFFEADFC6);
  static const Color cF0EBE3 = Color(0xFFF0EBE3);
}
