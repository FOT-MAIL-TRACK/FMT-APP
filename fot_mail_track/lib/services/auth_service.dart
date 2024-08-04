import 'dart:convert';

import 'package:fot_mail_track/utils/auth_utils.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = 'http://localhost:5000/api/auth/login/api/auth';

  Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token'];
      await saveToken(token); // Save the token here
    } else {
      throw Exception('Failed to login');
    }
  }
}
