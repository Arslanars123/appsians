import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SimpleScreen extends StatefulWidget {
  @override
  _SimpleScreenState createState() => _SimpleScreenState();
}

class _SimpleScreenState extends State<SimpleScreen> {
  bool isLoading = false;

  Future<void> makeApiCall() async {
    setState(() {
      isLoading = true;
    });

    final url = 'https://jarvey.ai/api/tickets';
    final headers = {
       'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiM2UzODYwZDkwMGRiNjcwZjcxMWQzNmMzMTY2MjIzZmQ1ZDI2YWZkY2ZkZjlmY2E4MTc1ZjM3Mzk0YjEyZTEzMzJkMjkxOTFiZmQ2ZGUwNzYiLCJpYXQiOjE3MjIyMTEyNzcuOTYzMzM3LCJuYmYiOjE3MjIyMTEyNzcuOTYzMzQyLCJleHAiOjE3NTM3NDcyNzcuOTUzNDQ2LCJzdWIiOiI0NiIsInNjb3BlcyI6W119.o2l-3s2LuqkIo8EZRYIlhs_xluhR95mT2Mh2yZEo8EpmDgKDQ99fKkeOpZ2vdEEr9pGWO3eMP42_yUwxhcIS1mW0UZT8qLawvseRcgkG6uR17k9UcqVTvLBO_95ES-40BYQLfj7xQhEtemFBn8YZVThiy-ahRtVLGqhk0C3jgcsDRogypjR0Pz4hh7fCgmejoBXKfbIF6NhwrnM-NFGk50fyFXkaC5LtA1Nw7vN5t9c35bBOBa66fhmbDFwcB31dl3W9VN1oGu6tB2uBBDKU3Z3gMvTj0BGCY41ZzPkmFvHZQIItszpOqPn_qY6arPIcfuzaYgiXgorTsiG02xFNzyFENPH6NFwQ0pMbqGQJnT6NAANurivd2TCqjD_MxRbX0MIlj8rVZgRBgCyfBFb2Pr6rHrOBUx_v0-N9414SSLPdT6r2BUjzdLfpQRvnpbAt0JvcRnddzXvYXBujF8eJ4teMmiY3hNm0yJYm4sEfGxEaK87_nV7E_LdLqM_LQqsfHcZJTgVhlLXElBZxKTFwBYWWmhGAEjz96JcjjTxCdvWi2qUJX4gPYwYXps6_s5JnT1muppe9NbMkp4SJe7XZDBkwOf0KOqGTRWOw_rNpAwHp1xE9g0NlUMg0z3wD6vMLWy5aqQKmlmzbUP5RV6-0TegsRnrepgaK-IsbOIKkSZM',
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['success'] == true && jsonResponse['data'] != null) {
          final data = jsonResponse['data'];
          _showResponseDialog(data.toString());
        } else {
          _showResponseDialog('Invalid response data');
        }
      } else {
        _showResponseDialog('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      _showResponseDialog('Error: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showResponseDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('API Response'),
          content: Text(message),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple API Call'),
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : ElevatedButton(
                onPressed: makeApiCall,
                child: Text('Make API Call'),
              ),
      ),
    );
  }
}
