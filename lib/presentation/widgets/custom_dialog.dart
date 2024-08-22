import 'package:appsians/presentation/screens/dashboard.dart';
import 'package:flutter/material.dart';

class MyDialog extends StatelessWidget {
  const MyDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: InkWell(
        onTap: (){
          Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => DashBoard()),
);

        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45.0, vertical: 60),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0XFFD6B5FF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  Icons.check,
                  size: 40,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
        
              const SizedBox(height: 12),
        
              const Text(
                'Password changed successfully',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0XFF0F1427),
                ),
                textAlign: TextAlign.center,
              ),
        
              const SizedBox(height: 8),
        
              const Text(
                'We recommend that you write down so you don\'t forget, okay?',
                style: TextStyle(color: Color(0XFF0F1427)),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
