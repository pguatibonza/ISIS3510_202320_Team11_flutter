import 'package:flutter/material.dart';
import 'package:tucamion/theme/app_colors.dart';
import 'package:tucamion/theme/app_text_styles.dart';

class TuCamionTheme {
  static ThemeData lightTheme() {
    return ThemeData().copyWith(
      useMaterial3: true,
      colorScheme: kColorScheme,
      appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: kColorScheme.onPrimaryContainer,
        foregroundColor: kColorScheme.primaryContainer,
      ),
      textTheme: ThemeData().textTheme.copyWith(
            titleLarge: AppTextStyles.headline(),
            titleMedium: AppTextStyles.headline(),
            titleSmall: AppTextStyles.headline(),
            headlineLarge: AppTextStyles.subheading(),
            headlineSmall: AppTextStyles.subheading(),
            headlineMedium: AppTextStyles.subheading(),
            bodyLarge: AppTextStyles.body(),
            bodyMedium: AppTextStyles.body(),
            bodySmall: AppTextStyles.body(),
            labelLarge: AppTextStyles.button(),
            labelMedium: AppTextStyles.button(),
            labelSmall: AppTextStyles.button(),
            displayLarge: AppTextStyles.caption(),
            displayMedium: AppTextStyles.caption(),
            displaySmall: AppTextStyles.caption(),
          ),
    );
  }
}
