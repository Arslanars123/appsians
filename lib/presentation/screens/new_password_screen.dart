import 'package:appsians/presentation/screens/login_screen.dart';
import 'package:appsians/presentation/widgets/custom_dialog.dart';
import 'package:appsians/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NewPassScreen extends StatefulWidget {
  const NewPassScreen({super.key});

  @override
  _NewPassScreenState createState() => _NewPassScreenState();
}

class _NewPassScreenState extends State<NewPassScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  void _printCredentials() {
    if (_formKey.currentState!.validate()) {
      print('Email: ${_emailController.text}');
    }
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (context) => const MyDialog(),
    );
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
                    'Create a new password',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0XFF0F1427),
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Your new password must be different from previous used passwords',
                    style: TextStyle(color: Color(0XFF0F1427)),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 40),

                  MyTextField(
                    label: 'Password',
                    controller: _emailController,
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
                    label: 'Confirm Password',
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    isPassword: true,
                  ),

                  const SizedBox(height: 40),

                  FilledButton(
                    onPressed: _showDialog,
                    style: Theme.of(context).filledButtonTheme.style,
                    child: const Text('Next'),
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
