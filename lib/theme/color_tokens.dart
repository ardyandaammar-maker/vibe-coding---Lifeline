import 'package:flutter/material.dart';

/// Semantic Color Tokens for Lifeline App
/// Automatically mapped from 1. Color Mode/light.tokens.json & dark.tokens.json
class LifelineColors extends ThemeExtension<LifelineColors> {
  final Color textDisplay;
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color textQuartinary;
  final Color textPlaceholder;
  final Color textBrandPrimary;

  final Color bgPrimary;
  final Color bgSecondary;
  final Color bgTertiary;
  final Color bgQuaternary;
  final Color bgBrandSolid;
  final Color bgBrandSolidHover;

  final Color borderPrimary;
  final Color borderSecondary;
  final Color borderTertiary;

  final Color fgPrimary;
  final Color fgSecondary;
  final Color fgTertiary;
  final Color fgBrandPrimary;

  final Color buttonPrimaryBg;
  final Color buttonPrimaryFg;
  final Color buttonSecondaryBg;
  final Color buttonSecondaryFg;
  final Color buttonSecondaryBorder;

  final Color segmentedBg;
  final Color segmentedActiveBg;
  final Color iconBadgeBg;
  final Color inputBg;

  const LifelineColors({
    required this.textDisplay,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.textQuartinary,
    required this.textPlaceholder,
    required this.textBrandPrimary,
    required this.bgPrimary,
    required this.bgSecondary,
    required this.bgTertiary,
    required this.bgQuaternary,
    required this.bgBrandSolid,
    required this.bgBrandSolidHover,
    required this.borderPrimary,
    required this.borderSecondary,
    required this.borderTertiary,
    required this.fgPrimary,
    required this.fgSecondary,
    required this.fgTertiary,
    required this.fgBrandPrimary,
    required this.buttonPrimaryBg,
    required this.buttonPrimaryFg,
    required this.buttonSecondaryBg,
    required this.buttonSecondaryFg,
    required this.buttonSecondaryBorder,
    required this.segmentedBg,
    required this.segmentedActiveBg,
    required this.iconBadgeBg,
    required this.inputBg,
  });

  /// Light Mode Color Token Definitions
  static const light = LifelineColors(
    textDisplay: Color(0xFF0B0D12),
    textPrimary: Color(0xFF181D27),
    textSecondary: Color(0xFF414651),
    textTertiary: Color(0xFF717680),
    textQuartinary: Color(0xFFA3A7AE),
    textPlaceholder: Color(0xFF84888E),
    textBrandPrimary: Color(0xFFE53935),

    bgPrimary: Color(0xFFFFFFFF),
    bgSecondary: Color(0xFFFAFAFA),
    bgTertiary: Color(0xFFF5F5F5),
    bgQuaternary: Color(0xFFE9EAEB),
    bgBrandSolid: Color(0xFFE53935),
    bgBrandSolidHover: Color(0xFFA12623),

    borderPrimary: Color(0xFFE9EAEB),
    borderSecondary: Color(0xFFD5D7DA),
    borderTertiary: Color(0xFFF5F5F5),

    fgPrimary: Color(0xFF181D27),
    fgSecondary: Color(0xFF414651),
    fgTertiary: Color(0xFF535862),
    fgBrandPrimary: Color(0xFFE53935),

    buttonPrimaryBg: Color(0xFFE53935),
    buttonPrimaryFg: Color(0xFFFFFFFF),
    buttonSecondaryBg: Color(0xFFFFFFFF),
    buttonSecondaryFg: Color(0xFF181D27),
    buttonSecondaryBorder: Color(0xFFD5D7DA),

    segmentedBg: Color(0xFFF2F4F7),
    segmentedActiveBg: Color(0xFFFFFFFF),
    iconBadgeBg: Color(0xFF181D27),
    inputBg: Color(0xFFF8F9FA),
  );

  /// Dark Mode Color Token Definitions
  static const dark = LifelineColors(
    textDisplay: Color(0xFFFFFFFF),
    textPrimary: Color(0xFFFAFAFA),
    textSecondary: Color(0xFFCECFD2),
    textTertiary: Color(0xFF95979D),
    textQuartinary: Color(0xFF95979D),
    textPlaceholder: Color(0xFF84888E),
    textBrandPrimary: Color(0xFFEA5E5B),

    bgPrimary: Color(0xFF0C0E12),
    bgSecondary: Color(0xFF14161B),
    bgTertiary: Color(0xFF22262F),
    bgQuaternary: Color(0xFF383A41),
    bgBrandSolid: Color(0xFFEA5E5B),
    bgBrandSolidHover: Color(0xFFE53935),

    borderPrimary: Color(0xFF252B37),
    borderSecondary: Color(0xFF383A41),
    borderTertiary: Color(0xFF22262F),

    fgPrimary: Color(0xFFFFFFFF),
    fgSecondary: Color(0xFFCECFD2),
    fgTertiary: Color(0xFF95979D),
    fgBrandPrimary: Color(0xFFEA5E5B),

    buttonPrimaryBg: Color(0xFFE53935),
    buttonPrimaryFg: Color(0xFFFFFFFF),
    buttonSecondaryBg: Color(0xFF14161B),
    buttonSecondaryFg: Color(0xFFFAFAFA),
    buttonSecondaryBorder: Color(0xFF414651),

    segmentedBg: Color(0xFF1D212B),
    segmentedActiveBg: Color(0xFF2B303C),
    iconBadgeBg: Color(0xFF22262F),
    inputBg: Color(0xFF14161B),
  );

  @override
  LifelineColors copyWith({
    Color? textDisplay,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? textQuartinary,
    Color? textPlaceholder,
    Color? textBrandPrimary,
    Color? bgPrimary,
    Color? bgSecondary,
    Color? bgTertiary,
    Color? bgQuaternary,
    Color? bgBrandSolid,
    Color? bgBrandSolidHover,
    Color? borderPrimary,
    Color? borderSecondary,
    Color? borderTertiary,
    Color? fgPrimary,
    Color? fgSecondary,
    Color? fgTertiary,
    Color? fgBrandPrimary,
    Color? buttonPrimaryBg,
    Color? buttonPrimaryFg,
    Color? buttonSecondaryBg,
    Color? buttonSecondaryFg,
    Color? buttonSecondaryBorder,
    Color? segmentedBg,
    Color? segmentedActiveBg,
    Color? iconBadgeBg,
    Color? inputBg,
  }) {
    return LifelineColors(
      textDisplay: textDisplay ?? this.textDisplay,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      textQuartinary: textQuartinary ?? this.textQuartinary,
      textPlaceholder: textPlaceholder ?? this.textPlaceholder,
      textBrandPrimary: textBrandPrimary ?? this.textBrandPrimary,
      bgPrimary: bgPrimary ?? this.bgPrimary,
      bgSecondary: bgSecondary ?? this.bgSecondary,
      bgTertiary: bgTertiary ?? this.bgTertiary,
      bgQuaternary: bgQuaternary ?? this.bgQuaternary,
      bgBrandSolid: bgBrandSolid ?? this.bgBrandSolid,
      bgBrandSolidHover: bgBrandSolidHover ?? this.bgBrandSolidHover,
      borderPrimary: borderPrimary ?? this.borderPrimary,
      borderSecondary: borderSecondary ?? this.borderSecondary,
      borderTertiary: borderTertiary ?? this.borderTertiary,
      fgPrimary: fgPrimary ?? this.fgPrimary,
      fgSecondary: fgSecondary ?? this.fgSecondary,
      fgTertiary: fgTertiary ?? this.fgTertiary,
      fgBrandPrimary: fgBrandPrimary ?? this.fgBrandPrimary,
      buttonPrimaryBg: buttonPrimaryBg ?? this.buttonPrimaryBg,
      buttonPrimaryFg: buttonPrimaryFg ?? this.buttonPrimaryFg,
      buttonSecondaryBg: buttonSecondaryBg ?? this.buttonSecondaryBg,
      buttonSecondaryFg: buttonSecondaryFg ?? this.buttonSecondaryFg,
      buttonSecondaryBorder: buttonSecondaryBorder ?? this.buttonSecondaryBorder,
      segmentedBg: segmentedBg ?? this.segmentedBg,
      segmentedActiveBg: segmentedActiveBg ?? this.segmentedActiveBg,
      iconBadgeBg: iconBadgeBg ?? this.iconBadgeBg,
      inputBg: inputBg ?? this.inputBg,
    );
  }

  @override
  LifelineColors lerp(ThemeExtension<LifelineColors>? other, double t) {
    if (other is! LifelineColors) return this;
    return LifelineColors(
      textDisplay: Color.lerp(textDisplay, other.textDisplay, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      textQuartinary: Color.lerp(textQuartinary, other.textQuartinary, t)!,
      textPlaceholder: Color.lerp(textPlaceholder, other.textPlaceholder, t)!,
      textBrandPrimary: Color.lerp(textBrandPrimary, other.textBrandPrimary, t)!,
      bgPrimary: Color.lerp(bgPrimary, other.bgPrimary, t)!,
      bgSecondary: Color.lerp(bgSecondary, other.bgSecondary, t)!,
      bgTertiary: Color.lerp(bgTertiary, other.bgTertiary, t)!,
      bgQuaternary: Color.lerp(bgQuaternary, other.bgQuaternary, t)!,
      bgBrandSolid: Color.lerp(bgBrandSolid, other.bgBrandSolid, t)!,
      bgBrandSolidHover: Color.lerp(bgBrandSolidHover, other.bgBrandSolidHover, t)!,
      borderPrimary: Color.lerp(borderPrimary, other.borderPrimary, t)!,
      borderSecondary: Color.lerp(borderSecondary, other.borderSecondary, t)!,
      borderTertiary: Color.lerp(borderTertiary, other.borderTertiary, t)!,
      fgPrimary: Color.lerp(fgPrimary, other.fgPrimary, t)!,
      fgSecondary: Color.lerp(fgSecondary, other.fgSecondary, t)!,
      fgTertiary: Color.lerp(fgTertiary, other.fgTertiary, t)!,
      fgBrandPrimary: Color.lerp(fgBrandPrimary, other.fgBrandPrimary, t)!,
      buttonPrimaryBg: Color.lerp(buttonPrimaryBg, other.buttonPrimaryBg, t)!,
      buttonPrimaryFg: Color.lerp(buttonPrimaryFg, other.buttonPrimaryFg, t)!,
      buttonSecondaryBg: Color.lerp(buttonSecondaryBg, other.buttonSecondaryBg, t)!,
      buttonSecondaryFg: Color.lerp(buttonSecondaryFg, other.buttonSecondaryFg, t)!,
      buttonSecondaryBorder: Color.lerp(buttonSecondaryBorder, other.buttonSecondaryBorder, t)!,
      segmentedBg: Color.lerp(segmentedBg, other.segmentedBg, t)!,
      segmentedActiveBg: Color.lerp(segmentedActiveBg, other.segmentedActiveBg, t)!,
      iconBadgeBg: Color.lerp(iconBadgeBg, other.iconBadgeBg, t)!,
      inputBg: Color.lerp(inputBg, other.inputBg, t)!,
    );
  }
}
