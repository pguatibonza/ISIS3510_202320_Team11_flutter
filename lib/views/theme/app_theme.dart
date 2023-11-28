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
        backgroundColor: Colors.white,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData()
          .copyWith(backgroundColor: Colors.white),
      textTheme: ThemeData().textTheme.copyWith(
            titleLarge:
                AppTextStyles.headline().copyWith(color: Color(0xff424242)),
            titleMedium:
                AppTextStyles.headline().copyWith(color: Color(0xff424242)),
            titleSmall:
                AppTextStyles.headline().copyWith(color: Color(0xff424242)),
            headlineLarge:
                AppTextStyles.subheading().copyWith(color: Color(0xff424242)),
            headlineMedium:
                AppTextStyles.subheading().copyWith(color: Color(0xff424242)),
            headlineSmall:
                AppTextStyles.subheading().copyWith(color: Color(0xff424242)),
            bodyLarge: AppTextStyles.body().copyWith(color: Color(0xff424242)),
            bodyMedium: AppTextStyles.body().copyWith(color: Color(0xff424242)),
            bodySmall: AppTextStyles.body().copyWith(color: Color(0xff424242)),
            labelLarge:
                AppTextStyles.button().copyWith(color: Color(0xff424242)),
            labelMedium:
                AppTextStyles.button().copyWith(color: Color(0xff424242)),
            labelSmall:
                AppTextStyles.button().copyWith(color: Color(0xff424242)),
            displayLarge:
                AppTextStyles.caption().copyWith(color: Color(0xff424242)),
            displayMedium:
                AppTextStyles.caption().copyWith(color: Color(0xff424242)),
            displaySmall:
                AppTextStyles.caption().copyWith(color: Color(0xff424242)),
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
      textTheme: ThemeData.dark().textTheme.copyWith(
            titleLarge: AppTextStyles.headline().copyWith(color: Colors.white),
            titleMedium: AppTextStyles.headline().copyWith(color: Colors.white),
            titleSmall: AppTextStyles.headline().copyWith(color: Colors.white),
            headlineLarge:
                AppTextStyles.subheading().copyWith(color: Colors.white),
            headlineMedium:
                AppTextStyles.subheading().copyWith(color: Colors.white),
            headlineSmall:
                AppTextStyles.subheading().copyWith(color: Colors.white),
            bodyLarge: AppTextStyles.body().copyWith(color: Colors.white),
            bodyMedium: AppTextStyles.body().copyWith(color: Colors.white),
            bodySmall: AppTextStyles.body().copyWith(color: Colors.white),
            labelLarge: AppTextStyles.button().copyWith(color: Colors.white),
            labelMedium: AppTextStyles.button().copyWith(color: Colors.white),
            labelSmall: AppTextStyles.button().copyWith(color: Colors.white),
            displayLarge: AppTextStyles.caption().copyWith(color: Colors.white),
            displayMedium:
                AppTextStyles.caption().copyWith(color: Colors.white),
            displaySmall: AppTextStyles.caption().copyWith(color: Colors.white),
          ),
    );
  }
}
