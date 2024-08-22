import 'package:appsians/utils/drop_down.dart';
import 'package:flutter/material.dart';
class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  String? _selectedOption;

  final List<String> _options = ['Option 1', 'Option 2', 'Option 3'];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:  CustomDropdown(options: _options, value: "444", onChanged: (value){})
      ),
    );
  }
}
