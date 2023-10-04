import 'package:google_fonts/google_fonts.dart';
import 'package:tucamion/views/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight semibold = FontWeight.w400;
  static const FontWeight regular = FontWeight.w400;
  static const FontStyle italic = FontStyle.italic;
  static const FontStyle normal = FontStyle.normal;

  static TextStyle headline({Color textColor = black}) {
    return GoogleFonts.montserrat(
      color: textColor,
      fontSize: 24.0,
      fontWeight: semibold,
    );
  }

  static TextStyle subheading({Color textColor = black}) {
    return GoogleFonts.montserrat(
      color: textColor,
      fontSize: 18.0,
      fontWeight: semibold,
    );
  }

  static TextStyle body({Color textColor = black}) {
    return GoogleFonts.montserrat(
      color: textColor,
      fontSize: 14.0,
      fontWeight: regular,
    );
  }

  static TextStyle button({Color textColor = black}) {
    return GoogleFonts.montserrat(
      color: textColor,
      fontSize: 14.0,
      fontWeight: bold,
    );
  }

  static TextStyle caption({Color textColor = black}) {
    return GoogleFonts.montserrat(
      color: textColor,
      fontSize: 12.0,
      fontWeight: regular,
    );
  }

  static TextStyle custom({
    Color textColor = black,
    double fontSize = 12.0,
    FontWeight fontWeight = regular,
    FontStyle fontStyle = normal,
  }) {
    return GoogleFonts.montserrat(
      color: textColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
    );
  }
}
