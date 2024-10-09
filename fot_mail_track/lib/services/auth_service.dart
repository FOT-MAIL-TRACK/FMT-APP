//http://localhost:5000/api/auth

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String baseUrl = 'http://192.168.3.218:5000/api/auth';

  // Declare the _letters list to store fetched letter data
  List<Map<String, dynamic>> _letters = [];

  // Getter to access the letters outside of this class
  List<Map<String, dynamic>> get letters => _letters;

  Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('auth_token', jsonDecode(response.body)['token']);
    } else {
      throw Exception('Failed to login $Exception');
    }
  }
  //Letter show Path

  Future<void> fetchLetters(String registrationNumber) async {
    try {
      final response = await http.post(Uri.parse('$baseUrl/tracking'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"registrationNumber": registrationNumber}));

      // ignore: avoid_print
      print("Responce is ${response.body} ");

      if (response.statusCode == 200) {
        final List<dynamic> parsedData = jsonDecode(response.body);
        _letters = parsedData
            .map((letter) => Map<String, dynamic>.from(letter))
            .toList();
      } else {
        // ignore: avoid_print
        print("Failed to fetch letters: ${response.body}");
      }
    } catch (err) {
      // ignore: avoid_print
      print("ERROR IS $err");
    }
  }
}
