import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DateProvider extends ChangeNotifier {
  bool isLoading = true;
  String errorMessage = '';
  List<Map<String, dynamic>> tickets = [];

  Future<void> fetchTickets({required String url}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
print("date me token");
print(token);
    final headers = {
      'Authorization': 'Bearer ' + token.toString(),
    };

    try {
      // Check internet connectivity
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        throw Exception('No internet connection');
      }

      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        // Check if response contains success and data
        if (jsonResponse['success'] == true && jsonResponse['data'] != null) {
          tickets = List<Map<String, dynamic>>.from(jsonResponse['data']);
         print(tickets.length);
        } else {
          throw Exception('Invalid response data');
        }
      } else {
        throw Exception('Failed to load tickets');
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void fetchTicketsForHeading(String heading) {
    DateTime now = DateTime.now();
    DateTime startDate;
    DateTime endDate = now;
    String url;

    switch (heading) {
      case '24H':
        startDate = now.subtract(Duration(days: 1));
        url = 'https://www.jarvey.ai/api/tickets?start_date=${DateFormat('yyyy-MM-dd').format(startDate)}&end_date=${DateFormat('yyyy-MM-dd').format(endDate)}';
        break;
      case '7D':
        startDate = now.subtract(Duration(days: 7));
        url = 'https://www.jarvey.ai/api/tickets?start_date=${DateFormat('yyyy-MM-dd').format(startDate)}&end_date=${DateFormat('yyyy-MM-dd').format(endDate)}';
        break;
      case '30D':
        startDate = now.subtract(Duration(days: 30));
        url = 'https://www.jarvey.ai/api/tickets?start_date=${DateFormat('yyyy-MM-dd').format(startDate)}&end_date=${DateFormat('yyyy-MM-dd').format(endDate)}';
        break;
      case '1Y':
        startDate = now.subtract(Duration(days: 365));
        url = 'https://www.jarvey.ai/api/tickets?start_date=${DateFormat('yyyy-MM-dd').format(startDate)}&end_date=${DateFormat('yyyy-MM-dd').format(endDate)}';
        break;
      case 'ALL':
      default:
        url = 'https://www.jarvey.ai/api/tickets'; // No date parameters for "ALL"
        break;
    }

    fetchTickets(url: url);
  }
}
