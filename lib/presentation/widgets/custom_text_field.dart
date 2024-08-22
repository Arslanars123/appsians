import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:appsians/presentation/themes/widget_themes.dart/text_field_theme.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final Icon? prefixIcon;
  final bool isPassword;

  const MyTextField({
    Key? key,
    required this.controller,
    required this.label,
    this.validator,
    this.prefixIcon,
    this.isPassword = false,
  }) : super(key: key);

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            widget.label,
            style: GoogleFonts.roboto(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: Color(0XFF0F1427),
            ),
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          obscureText: widget.isPassword ? _obscureText : false,
          decoration: CustomTextFieldTheme.lightTextFieldTheme().copyWith(
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.isPassword
                ? IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
                color: const Color(0XFFD1D1D1),
              ),
              onPressed: () {
                setState(() => _obscureText = !_obscureText);
              },
            )
                : null,
          ),
          style: GoogleFonts.roboto(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color(0XFF0F1427),
          ),
        ),
      ],
    );
  }
}
