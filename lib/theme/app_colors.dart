import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF2E85FF);
const Color secondary = Color(0xFF2FAAFF);
const Color black = Color(0xFF232323);
const Color error = Color(0xFFB73731);
const Color info = Color(0xFFEDBD11);

var kColorScheme = ColorScheme.fromSeed(
  seedColor: primaryColor,
);

const MaterialColor materialColor =
    MaterialColor(_primaryPrimaryValue, <int, Color>{
  50: Color(0xFFE6F0FF),
  100: Color(0xFFC0DAFF),
  200: Color(0xFF97C2FF),
  300: Color(0xFF6DAAFF),
  400: Color(0xFF4D97FF),
  500: Color(_primaryPrimaryValue),
  600: Color(0xFF297DFF),
  700: Color(0xFF2372FF),
  800: Color(0xFF1D68FF),
  900: Color(0xFF1255FF),
});

const int _primaryPrimaryValue = 0xFF2E85FF;

const MaterialColor primaryAccent =
    MaterialColor(_primaryAccentValue, <int, Color>{
  100: Color(0xFFFFFFFF),
  200: Color(_primaryAccentValue),
  400: Color(0xFFC6D4FF),
  700: Color(0xFFADC1FF),
});
const int _primaryAccentValue = 0xFFF9FBFF;
