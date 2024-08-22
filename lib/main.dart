import 'dart:convert';

import 'package:appsians/presentation/screens/chart.dart';
import 'package:appsians/presentation/screens/code_verification_screen.dart';
import 'package:appsians/presentation/screens/dashboard.dart';
import 'package:appsians/presentation/screens/login_screen.dart';
import 'package:appsians/presentation/screens/login_screen2.dart';
import 'package:appsians/presentation/screens/new_password_screen.dart';
import 'package:appsians/presentation/screens/reset_password_screen.dart';
import 'package:appsians/presentation/screens/sign_up_screen.dart';
import 'package:appsians/presentation/themes/light_theme.dart';
import 'package:appsians/providers/date_provider.dart';
import 'package:appsians/providers/store_provider.dart';
import 'package:appsians/test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => StoreProvider()),
         ChangeNotifierProvider(create: (context) => DateProvider()),
   // Example of another provider
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: CustomAppTheme.lightTheme,
        home: LoginScreen(), // Set your initial screen here
      ),
    );
  }
}

class EmailButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
      
        sendEmail(
          serviceId: 'service_5azpv6p',
          templateId: 'template_41dl9x2',
          userId: '-muf72VyP1NmueCBj',
          templateParams: {
            'to_name': 'User Name',
            "user_subject":'Hi ap ka shagird cha gaya email ho gai',
            'to_email':"zaidimughees@gmail.com",
            'reply_to':"arslanzaheer5236@gmail.com",
            'from_name': 'Your App Name',
            'message': 'This is a test email from EmailJS!',
            
          },
        );
      },
      child: Text('Send Email'),
    );
  }
}

Future<void> sendEmail({
  required String serviceId,
  required String templateId,
  required String userId,
  required Map<String, dynamic> templateParams,
}) async {
  final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

  final headers = {
    'Content-Type': 'application/json',
    'Origin': 'http://localhost', // Adding the Origin header as localhost
  };

  final body = json.encode({
    'service_id': serviceId,
    'template_id': templateId,
    'user_id': userId,
    'template_params': templateParams,
  });

  final response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 200) {
    print('Email sent successfully');
  } else {
    print('Failed to send email: ${response.body}');
  }
}
