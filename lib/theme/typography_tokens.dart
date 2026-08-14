import 'package:flutter/material.dart';

/// Lifeline Typography Tokens generated from Style.tokens.json
class LifelineTypography {
  static const String fontFamilyDisplay = 'Geist';
  static const String fontFamilyText = 'Geist';

  // Font Weights
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semibold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;

  // Display Styles
  static const TextStyle display1 = TextStyle(
    fontFamily: fontFamilyDisplay,
    fontSize: 64,
    height: 78 / 64,
    fontWeight: bold,
    letterSpacing: -1.0,
  );

  static const TextStyle display2 = TextStyle(
    fontFamily: fontFamilyDisplay,
    fontSize: 56,
    height: 68 / 56,
    fontWeight: bold,
    letterSpacing: -0.8,
  );

  static const TextStyle display3 = TextStyle(
    fontFamily: fontFamilyDisplay,
    fontSize: 48,
    height: 60 / 48,
    fontWeight: bold,
    letterSpacing: -0.6,
  );

  // Headings
  static const TextStyle h1 = TextStyle(
    fontFamily: fontFamilyDisplay,
    fontSize: 40,
    height: 50 / 40,
    fontWeight: bold,
    letterSpacing: -0.5,
  );

  static const TextStyle h2 = TextStyle(
    fontFamily: fontFamilyDisplay,
    fontSize: 32,
    height: 42 / 32,
    fontWeight: bold,
    letterSpacing: -0.4,
  );

  static const TextStyle h3 = TextStyle(
    fontFamily: fontFamilyDisplay,
    fontSize: 28,
    height: 38 / 28,
    fontWeight: bold,
    letterSpacing: -0.3,
  );

  static const TextStyle h4 = TextStyle(
    fontFamily: fontFamilyDisplay,
    fontSize: 24,
    height: 32 / 24,
    fontWeight: semibold,
    letterSpacing: -0.2,
  );

  // Paragraphs
  static const TextStyle p1 = TextStyle(
    fontFamily: fontFamilyText,
    fontSize: 20,
    height: 28 / 20,
    fontWeight: regular,
  );

  static const TextStyle p2 = TextStyle(
    fontFamily: fontFamilyText,
    fontSize: 18,
    height: 26 / 18,
    fontWeight: regular,
  );

  // Body Texts
  static const TextStyle text1 = TextStyle(
    fontFamily: fontFamilyText,
    fontSize: 16,
    height: 24 / 16,
    fontWeight: regular,
  );

  static const TextStyle text2 = TextStyle(
    fontFamily: fontFamilyText,
    fontSize: 14,
    height: 20 / 14,
    fontWeight: regular,
  );

  // Captions & Labels
  static const TextStyle caption = TextStyle(
    fontFamily: fontFamilyText,
    fontSize: 12,
    height: 16 / 12,
    fontWeight: regular,
  );

  static const TextStyle label1 = TextStyle(
    fontFamily: fontFamilyText,
    fontSize: 10,
    height: 13 / 10,
    fontWeight: medium,
  );

  static const TextStyle label2 = TextStyle(
    fontFamily: fontFamilyText,
    fontSize: 8,
    height: 10 / 8,
    fontWeight: medium,
  );
}
