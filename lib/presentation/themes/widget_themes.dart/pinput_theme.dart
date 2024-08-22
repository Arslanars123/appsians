import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class PinputTheme {
  static PinTheme pinTheme = PinTheme(
    width: 45,
    height: 45,
    textStyle: const TextStyle(
      fontFamily: 'ManropeRegular',
      fontWeight: FontWeight.w500,
      fontSize: 16,
    ),
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(12),
    ),
  );
}
