//http://localhost:5000/api/auth

import 'dart:convert';

import 'package:http/http.dart' as http;

Future<void> login(String email, String password) async {
  const String url =
      'http://localhost:5000/api/auth/login'; // Replace with your actual backend URL

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      print('Login successful: $responseData');
    } else {
      print('Login failed: ${response.body}');
    }
  } catch (e) {
    print('Error: $e');
  }
}
