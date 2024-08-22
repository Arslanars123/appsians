import 'package:appsians/presentation/screens/sign_up_screen.dart';
import 'package:appsians/presentation/themes/light_theme.dart';
import 'package:appsians/presentation/themes/widget_themes.dart/text_field_theme.dart';
import 'package:appsians/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class LoginScreen2 extends StatefulWidget {
  const LoginScreen2({super.key});

  @override
  _LoginScreen2State createState() => _LoginScreen2State();
}

class _LoginScreen2State extends State<LoginScreen2> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //
                  const SizedBox(height: 70),

                  SizedBox(
                    height: 133,
                    width: 133,
                    child: Image.asset('assets/images/logo/tigerLogo.png'),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'Sign in',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0XFF0F1427),
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Lets get started',
                    style: TextStyle(color: Color(0XFF0F1427)),
                  ),

                  const SizedBox(height: 40),

                  MyTextField(
                    label: 'Email',
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  MyTextField(
                    controller: _passwordController,
                    label: 'Password',
                    validator: (value) {},
                    isPassword: true,
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Forgot password?',
                        style: TextStyle(color: Colors.purple),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  FilledButton(
                    onPressed: _printCredentials,
                    style: Theme.of(context).filledButtonTheme.style,
                    child: const Text('Next'),
                  ),

                  const SizedBox(height: 32),

                  InkWell(
                    child: const Text(
                      'Or sign up with social account',
                      style: TextStyle(
                        color: Color(0XFF0F1427),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
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
