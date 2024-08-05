//http://localhost:5000/api/auth

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String baseUrl = 'http://localhost:5000/api/auth';

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
}
