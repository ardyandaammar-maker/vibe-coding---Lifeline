import 'package:flutter/material.dart';
import 'color_tokens.dart';
import 'typography_tokens.dart';

export 'color_tokens.dart';
export 'typography_tokens.dart';
export 'spacing_tokens.dart';
export 'radius_tokens.dart';
export 'container_tokens.dart';

class LifelineTheme {
  static TextTheme _buildTextTheme(Color defaultTextColor) {
    return TextTheme(
      displayLarge: LifelineTypography.display1.copyWith(color: defaultTextColor),
      displayMedium: LifelineTypography.display2.copyWith(color: defaultTextColor),
      displaySmall: LifelineTypography.display3.copyWith(color: defaultTextColor),
      headlineLarge: LifelineTypography.h1.copyWith(color: defaultTextColor),
      headlineMedium: LifelineTypography.h2.copyWith(color: defaultTextColor),
      headlineSmall: LifelineTypography.h3.copyWith(color: defaultTextColor),
      titleLarge: LifelineTypography.h4.copyWith(color: defaultTextColor),
      titleMedium: LifelineTypography.p1.copyWith(color: defaultTextColor, fontWeight: FontWeight.w600),
      titleSmall: LifelineTypography.p2.copyWith(color: defaultTextColor, fontWeight: FontWeight.w600),
      bodyLarge: LifelineTypography.text1.copyWith(color: defaultTextColor),
      bodyMedium: LifelineTypography.text2.copyWith(color: defaultTextColor),
      bodySmall: LifelineTypography.caption.copyWith(color: defaultTextColor),
      labelLarge: LifelineTypography.text2.copyWith(color: defaultTextColor, fontWeight: FontWeight.w600),
      labelMedium: LifelineTypography.label1.copyWith(color: defaultTextColor),
      labelSmall: LifelineTypography.label2.copyWith(color: defaultTextColor),
    );
  }

  static ThemeData get lightTheme {
    const tokens = LifelineColors.light;
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: tokens.bgPrimary,
      primaryColor: tokens.bgBrandSolid,
      colorScheme: ColorScheme.light(
        primary: tokens.bgBrandSolid,
        secondary: tokens.textBrandPrimary,
        surface: tokens.bgPrimary,
        onSurface: tokens.textPrimary,
      ),
      extensions: const [tokens],
      fontFamily: LifelineTypography.fontFamilyText,
      textTheme: _buildTextTheme(tokens.textPrimary),
      appBarTheme: AppBarTheme(
        backgroundColor: tokens.bgPrimary,
        elevation: 0,
        iconTheme: IconThemeData(color: tokens.fgPrimary),
        titleTextStyle: LifelineTypography.h4.copyWith(color: tokens.textPrimary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: tokens.buttonPrimaryBg,
          foregroundColor: tokens.buttonPrimaryFg,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          textStyle: LifelineTypography.text1.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: tokens.buttonSecondaryBg,
          foregroundColor: tokens.buttonSecondaryFg,
          minimumSize: const Size(double.infinity, 52),
          side: BorderSide(color: tokens.buttonSecondaryBorder, width: 1.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: LifelineTypography.text1.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: tokens.inputBg,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        hintStyle: LifelineTypography.text2.copyWith(color: tokens.textPlaceholder),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: tokens.borderPrimary, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: tokens.borderPrimary, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: tokens.bgBrandSolid, width: 1.5),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    const tokens = LifelineColors.dark;
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: tokens.bgPrimary,
      primaryColor: tokens.bgBrandSolid,
      colorScheme: ColorScheme.dark(
        primary: tokens.bgBrandSolid,
        secondary: tokens.textBrandPrimary,
        surface: tokens.bgPrimary,
        onSurface: tokens.textPrimary,
      ),
      extensions: const [tokens],
      fontFamily: LifelineTypography.fontFamilyText,
      textTheme: _buildTextTheme(tokens.textPrimary),
      appBarTheme: AppBarTheme(
        backgroundColor: tokens.bgPrimary,
        elevation: 0,
        iconTheme: IconThemeData(color: tokens.fgPrimary),
        titleTextStyle: LifelineTypography.h4.copyWith(color: tokens.textPrimary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: tokens.buttonPrimaryBg,
          foregroundColor: tokens.buttonPrimaryFg,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          textStyle: LifelineTypography.text1.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: tokens.buttonSecondaryBg,
          foregroundColor: tokens.buttonSecondaryFg,
          minimumSize: const Size(double.infinity, 52),
          side: BorderSide(color: tokens.buttonSecondaryBorder, width: 1.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: LifelineTypography.text1.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: tokens.inputBg,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        hintStyle: LifelineTypography.text2.copyWith(color: tokens.textPlaceholder),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: tokens.borderPrimary, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: tokens.borderPrimary, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: tokens.bgBrandSolid, width: 1.5),
        ),
      ),
    );
  }
}
