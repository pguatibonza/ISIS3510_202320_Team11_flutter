import 'package:flutter/material.dart';
import 'package:tucamion/views/theme/app_colors.dart';
import 'package:tucamion/views/theme/app_text_styles.dart';

class TuCamionTheme {
  static ThemeData lightTheme() {
    return ThemeData().copyWith(
      useMaterial3: true,
      brightness: Brightness.light,
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

  static ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: darkPrimary,
      backgroundColor: darkBackground,
      scaffoldBackgroundColor: darkBackground,
      errorColor: darkOnError,
      colorScheme: kDarkColorScheme,
      appBarTheme: AppBarTheme().copyWith(
        backgroundColor: darkBackground,
        foregroundColor: darkOnBackground,
      ),
      textTheme: ThemeData.dark()
          .textTheme, // Use Flutter's dark default text themes and customize if needed.
      // Add other theme customization if needed.
    );
  }
}
