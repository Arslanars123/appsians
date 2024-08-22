import 'package:flutter/material.dart';

class CustomTextFieldTheme {
  static InputDecoration lightTextFieldTheme(
      {Widget? prefixIcon, Widget? suffixIcon}) {
    return InputDecoration(
      //
      filled: true,

      fillColor: Colors.white,

      // contentPadding: const EdgeInsets.symmetric(horizontal: 22.5),

      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          width: 1.5,
          color: Color(0XFF9E9E9E),
        ),
        borderRadius: BorderRadius.circular(34.0),
      ),

      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          width: 1.5,
          color: Color(0XFF0F1427),
        ),
        borderRadius: BorderRadius.circular(34.0),
      ),

      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          width: 1.5,
          color: Color(0XFFF65B4E),
        ),
        borderRadius: BorderRadius.circular(34.0),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          width: 1.5,
          color: Color(0XFFF65B4E),
        ),
        borderRadius: BorderRadius.circular(34.0),
      ),

      floatingLabelBehavior: FloatingLabelBehavior.never,

      errorStyle: const TextStyle(fontWeight: FontWeight.w600),

      prefixIcon: prefixIcon,

      suffixIcon: suffixIcon,
    );
  }
}
