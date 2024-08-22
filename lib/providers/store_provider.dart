import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreProvider extends ChangeNotifier {
  bool isLoading = true;
  String errorMessage = '';
  Map<String, double> dataMap = {};
  List<Color> colorList = [];
  double totalCount = 0.0;

  StoreProvider() {
    fetchStores();
  }

  Future<void> fetchStores() async {
    final url = 'http://www.jarvey.ai/api/tickets/count/category';
      SharedPreferences prefs = await SharedPreferences.getInstance();
       var token = prefs.getString("token");
   print("token check karo");
   print(token);
    final headers = {
      'Authorization': 'Bearer '+token.toString()};


    try {
      // Check internet connectivity
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        throw Exception('No internet connection');
      }

      final response = await http.post(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        // Check if response contains success and data
        if (jsonResponse['success'] == true && jsonResponse['data'] != null) {
          print("have data");
          final List<dynamic> data = jsonResponse['data'];
          dataMap = {
            for (var item in data) item['name']: item['count'].toDouble()
          };
          colorList = [
            for (var i = 0; i < data.length; i++) getRandomColor()
          ];
          calculateTotalCount(data);
        } else {
          throw Exception('Invalid response data');
        }
      } else {
        throw Exception('Failed to load stores');
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void calculateTotalCount(List<dynamic> data) {
    totalCount = data.fold(0, (sum, item) => sum + item['count']);
  }

  Color getRandomColor() {
    return Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  }
}
