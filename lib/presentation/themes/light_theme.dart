import 'package:appsians/presentation/themes/widget_themes.dart/filled_button_theme.dart';
import 'package:flutter/material.dart';

// https://m3.material.io/styles/color/roles

class CustomAppTheme {
  static ThemeData lightTheme = ThemeData(
    //
    useMaterial3: true,

    colorScheme: const ColorScheme(
      onBackground: Colors.transparent,
      //
      brightness: Brightness.light,

      primary: Color(0XFF9945FF),
      onPrimary: Color(0XFFFFFFFF),

      // change
      secondary: Color(0XFFFFFFFF),
      onSecondary: Color(0XFFFFFFFF),

      error: Colors.red,
      onError: Color(0XFFFFFFFF),

      // change
      surface: Colors.black,
      onSurface: Color(0XFFFFFFFF), background: Colors.transparent,
    ),

    scaffoldBackgroundColor: const Color(0XFFFFFFFF),

    filledButtonTheme: CustomFilledButtonTheme.lightFilledButtonTheme,
  );
}
