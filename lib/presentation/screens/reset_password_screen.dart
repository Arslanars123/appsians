import 'dart:convert';
import 'package:appsians/presentation/screens/code_verification_screen.dart';
import 'package:appsians/presentation/screens/dashboard.dart';
import 'package:appsians/presentation/screens/new_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:appsians/presentation/screens/login_screen.dart';
import 'package:appsians/presentation/widgets/custom_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResetPassScreen extends StatefulWidget {
  const ResetPassScreen({Key? key}) : super(key: key);

  @override
  _ResetPassScreenState createState() => _ResetPassScreenState();
}

class _ResetPassScreenState extends State<ResetPassScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

 Future<void> _resetPassword() async {
  if (_formKey.currentState!.validate()) {
    var email = _emailController.text;
    // Regular expression for basic email validation
    RegExp emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(email)) {
      Fluttertoast.showToast(msg: "Email is not valid");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(msg: "No internet connection");
      setState(() {
        _isLoading = false;
      });
      return;
    }
   SharedPreferences prefs = await SharedPreferences.getInstance();
   
    try {
      var response = await http.post(
        Uri.parse('https://www.jarvey.ai/api/admin/password/reset/request'),
        body: {'email': _emailController.text},
      );

      if (response.statusCode == 200) {
   
        var data = json.decode(response.body);
        print(data);
       
        if (data['message'] == "Reset code sent successfully") {
               var emailuser = prefs.getString("email");
   emailuser != null ?prefs.remove("email"):null;
           prefs.setString("email", email);
          Fluttertoast.showToast(msg: "Reset link sent to your email");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CodeVerificationScreen()),
          );
          
        } else {
          Fluttertoast.showToast(msg: data['message']);
        }
      } else {
        Fluttertoast.showToast(msg: "Error: ${response.statusCode}");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "An error occurred");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
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
                    'Reset Your Password',
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0XFF0F1427),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Enter your email and we\'ll send you a link to reset your password',
                    style: GoogleFonts.roboto(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Color(0XFF0F1427),
                    ),
                    textAlign: TextAlign.center,
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

                  const SizedBox(height: 40),

                  _isLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: _resetPassword,
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

                  const SizedBox(height: 20),

                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.roboto(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                        children: const [
                          TextSpan(
                            text: 'Back to ',
                          ),
                          TextSpan(
                            text: 'Sign in',
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
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
