import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:appsians/presentation/widgets/custom_checkbox.dart';
import 'package:appsians/presentation/widgets/custom_text_field.dart';

import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  bool _rememberMe = false;
  bool _agreeTerms = false;

  void _printCredentials() {
    if (_formKey.currentState!.validate()) {
      print('Email: ${_emailController.text}');
      print('Password: ${_passwordController.text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0),
        child: Form(
          key: _formKey,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 70),
                  CircleAvatar(
                    radius: MediaQuery.of(context).size.width / 8,
                    backgroundImage: AssetImage('assets/images/logo/tigerLogo.png'),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Sign up',
                    style: GoogleFonts.roboto(
                      fontSize: 26, // increased by 2
                      fontWeight: FontWeight.bold,
                      color: Color(0XFF0F1427),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sign up now to unlock exclusive benefits, personalized profiles, and seamless service scheduling',
                    style: GoogleFonts.roboto(
                      fontSize: 12, // increased by 2
                      fontWeight: FontWeight.w400,
                      color: Color(0XFF0F1427),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width / 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: MyTextField(
                          label: 'First name',
                          controller: _firstNameController,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: MyTextField(
                          label: 'Last name',
                          controller: _lastNameController,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                    label: 'Email',
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: _passwordController,
                    label: 'Password',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    isPassword: true,
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: _confirmPassController,
                    label: 'Confirm Password',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      return null;
                    },
                    isPassword: true,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 20,
                        height: MediaQuery.of(context).size.height / 40,
                        color: Colors.grey.withOpacity(0.1),
                        child: Checkbox(
                          value: _rememberMe,
                          onChanged: (value) {
                            setState(() {
                              _rememberMe = value!;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Remember me",
                        style: GoogleFonts.roboto(
                          fontSize: 12, // increased by 2
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF0F1427),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 20,
                        height: MediaQuery.of(context).size.height / 40,
                        color: Colors.grey.withOpacity(0.1),
                        child: Checkbox(
                          value: _agreeTerms,
                          onChanged: (value) {
                            setState(() {
                              _agreeTerms = value!;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text.rich(
                        TextSpan(
                          text: 'I agree to all the ',
                          style: GoogleFonts.roboto(
                            fontSize: 12, // increased by 2
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF0F1427),
                          ),
                          children: [
                            TextSpan(
                              text: 'Terms ',
                              style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            TextSpan(
                              text: 'and ',
                              style: GoogleFonts.roboto(
                                fontSize: 12, // increased by 2
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF0F1427),
                              ),
                            ),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _printCredentials,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF9945FF),
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                      foregroundColor: Colors.white,
                      textStyle: GoogleFonts.roboto(
                        fontSize: 14, // increased by 2
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    child: Text(
                      'Next',
                      style: GoogleFonts.roboto(
                        fontSize: 16, // increased by 2
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Or sign up with social account',
                    style: GoogleFonts.roboto(
                      fontSize: 12, // increased by 2
                      fontWeight: FontWeight.w400,
                      color: Color(0XFF0F1427),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Image.asset(
                    "assets/images/Group 17956.png",
                    scale: 1.5,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.roboto(
                          fontSize: 12, // increased by 2
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                        children: [
                          const TextSpan(
                            text: 'Already have an account? ',
                          ),
                          TextSpan(
                            text: 'Sign in',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
