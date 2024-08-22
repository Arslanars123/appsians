import 'package:flutter/material.dart';

class CustomFilledButtonTheme {
  static final lightFilledButtonTheme = FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: const Color(0XFF9945FF),
      foregroundColor: const Color(0XFFFFFFFF),
      textStyle: const TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w700,
        fontSize: 14,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(34),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 72, vertical: 8),
    ),
  );
}
