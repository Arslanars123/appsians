import 'dart:convert';
import 'package:appsians/presentation/screens/dashboard.dart';
import 'package:appsians/presentation/screens/reset_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:appsians/presentation/screens/sign_up_screen.dart';
import 'package:appsians/presentation/themes/light_theme.dart';
import 'package:appsians/presentation/themes/widget_themes.dart/text_field_theme.dart';
import 'package:appsians/presentation/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
    
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult[0] == ConnectivityResult.none) {
        print(connectivityResult.first);
        Fluttertoast.showToast(msg: 'No internet connection.');
        setState(() {
          _isLoading = false;
        });
        return;
      }
print("check data");
      // try {
        final response = await http.post(
          Uri.parse('http://www.jarvey.ai/api/admin/login'),
          body: {
            'username': _emailController.text,
            'password': _passwordController.text,
          },
        );

        if (response.statusCode == 200) {
          print("arslan");
          final data = json.decode(response.body);
          print(data);
          if (data['error'] == false) {
               SharedPreferences prefs = await SharedPreferences.getInstance();
            
         
            await prefs.setString('token', data['token']);
            Fluttertoast.showToast(msg: data['message']);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DashBoard()),
            );
          } else {
            Fluttertoast.showToast(msg: data['message']);
          }
        } else {
          Fluttertoast.showToast(msg: 'Server error. Please try again later.');
        }
      // } catch (e) {
      //   Fluttertoast.showToast(msg: 'No internet connection or server error.');
      // } finally {
      //   setState(() {
      //     _isLoading = false;
      //   });
      // }
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
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 70),
                  SizedBox(
                    height: 133,
                    width: 133,
                    child: Image.asset('assets/images/logo/tigerLogo.png'),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Sign in',
                    style: GoogleFonts.roboto(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0XFF0F1427),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Let\'s get started',
                    style: GoogleFonts.roboto(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0XFF0F1427),
                    ),
                  ),
                  const SizedBox(height: 40),
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
                  const SizedBox(height: 20),
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
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResetPassScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Forgot password?',
                        style: TextStyle(color: Colors.purple),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _isLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: _login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF9945FF),
                            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                            foregroundColor: Colors.white,
                            textStyle: GoogleFonts.roboto(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                          child: Text(
                            'Next',
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                  const SizedBox(height: 32),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Or sign up with social account',
                      style: GoogleFonts.roboto(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0XFF0F1427),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
