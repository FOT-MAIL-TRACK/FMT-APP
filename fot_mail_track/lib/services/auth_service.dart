//http://localhost:5000/api/auth

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String baseUrl = 'http://192.168.100.170:5000/api/auth';

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
      throw Exception('Failed to login');
    }
  }
  //Letter show Path

  Future<void> fetchLetters(String registrationNumber) async {
    try {
      final response = await http.post(Uri.parse('$baseUrl/tracking'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"registrationNumber": registrationNumber}));

      // ignore: avoid_print
      print("Responce is $response");

      if (response.statusCode == 200) {
        // setState(() {
        //   letters = List<Map<String, dynamic>>.from(json.decode(response.body));
        //   // ignore: avoid_print
        //   print("Inside if, Responce is $response");
        // });
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
