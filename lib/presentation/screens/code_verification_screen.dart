import 'package:appsians/presentation/screens/login_screen.dart';
import 'package:appsians/presentation/themes/widget_themes.dart/pinput_theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pinput/pinput.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class CodeVerificationScreen extends StatefulWidget {
  const CodeVerificationScreen({super.key});

  @override
  _CodeVerificationScreenState createState() => _CodeVerificationScreenState();
}

class _CodeVerificationScreenState extends State<CodeVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
 
  final TextEditingController _codeController = TextEditingController();

  Future<void> _verifyCode() async {
    if (_formKey.currentState!.validate()) {
      
      final String code = _codeController.text.trim();

      final url = Uri.parse('https://www.jarvey.ai/admin/password/reset/validate');
      final headers = {'Content-Type': 'application/json'};
SharedPreferences prefs = await SharedPreferences.getInstance();
var email = prefs.getString("email");
      final body = jsonEncode({"email": email, "code": code});
print(email);
    
        final response = await http.post(url, headers: headers, body: body);
        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          // Handle successful response
          print('Success: $responseData');
          // Navigate to another screen if needed
        } else {
          final responseData = jsonDecode(response.body);
          // Handle error response
          print('Error: ${responseData['message']}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${responseData['message']}')),
          );
        }
      
    }
  }

  @override
  Widget build(BuildContext context) {
    // Define the custom PinTheme
    final pinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
        fontSize: 22,
        color: Colors.black, // Set the desired text color here
      ),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
    );

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
                  const SizedBox(height: 90),
                  const Text(
                    'Enter the code',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0XFF0F1427),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'We have just sent you a 4-digit code to',
                    style: TextStyle(color: Color(0XFF0F1427)),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'example@gmail.com',
                    style: TextStyle(
                      color: Color(0XFF0F1427),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  Container(
                    width: double.infinity,
                    child: Center(
                      child: Pinput(
                        length: 6,
                        controller: _codeController,
                        defaultPinTheme: pinTheme,
                        onTapOutside: (event) {
                          FocusScope.of(context).unfocus();
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the code';
                          }
                          return null;
                        },
                        onCompleted: (value) {},
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  FilledButton(
                    onPressed: _verifyCode,
                    style: Theme.of(context).filledButtonTheme.style,
                    child: const Text('Next'),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Didn\'t receive?',
                    style: TextStyle(color: Color(0XFF0F1427)),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Resend code',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                      textAlign: TextAlign.center,
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
