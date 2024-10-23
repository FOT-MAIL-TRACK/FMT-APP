//http://localhost:5000/api/auth

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String baseUrl = 'http://192.168.120.218:5000/api/auth';

  // Declare the _letters list to store fetched letter data
  List<Map<String, dynamic>> _letters = [];
  List<Map<String, dynamic>> _letter = [];

  // Getter to access the letters outside of this class
  List<Map<String, dynamic>> get letters => _letters;

  //Login
  Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('auth_token', jsonDecode(response.body)['token']);

      // Parse the response body to extract token, user id, and role
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final String token = responseData['token'];
      final String userId = responseData['user']['id'];
      final String userRole = responseData['user']['role'];
      final String userRegNo = responseData['user']['registrationNumber'];
      final String userName = responseData['user']['username'];
      final String uName = responseData['user']['name'];
      final String userFac = responseData['user']['faculty'];

      // Store token, userId, and userRole in SharedPreferences
      prefs.setString('auth_token', token);
      prefs.setString('user_id', userId);
      prefs.setString('user_role', userRole);
      prefs.setString('user_Regno', userRegNo);
      prefs.setString('user_name', userName);
      prefs.setString('user_faculty', userFac);
      prefs.setString('name', uName);
    } else {
      throw Exception('Failed to login $Exception');
    }
  }

  //Letter show Path

  Future<List<dynamic>> fetchLetters(String? registrationNumber) async {
    try {
      final response = await http.post(Uri.parse('$baseUrl/tracking'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"registrationNumber": registrationNumber}));

      if (response.statusCode == 200) {
        final List<dynamic> parsedData = jsonDecode(response.body);
        _letters = parsedData
            .map((letter) => Map<String, dynamic>.from(letter))
            .toList();

        return _letters;
      } else {
        // ignore: avoid_print
        print("Failed to fetch letters: ${response.body}");
        return [];
      }
    } catch (err) {
      // ignore: avoid_print
      print("ERROR IS $err");
    }
    return [];
  }

//One Letter Show Path

  Future<Map<String, dynamic>?> fetchOneLetter(String? id) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/getLetter'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"id": id}),
      );

      if (response.statusCode == 200) {
        return Map<String, dynamic>.from(jsonDecode(response.body));
      } else {
        print("Failed to fetch letter: ${response.body}");
        return null;
      }
    } catch (err) {
      print("ERROR IS $err");
      return null;
    }
  }

  //Tracking Log Update Path

  Future<void> updateTrackingLog(
      String? uId, String? name, String? _id, String? letterID) async {
    final url = Uri.parse('$baseUrl/updateTracking/$letterID');
    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user': _id, // Pass _id directly
          'name': name,
          'uniqueID': uId,
        }),
      );

      if (response.statusCode == 200) {
        print("Tracking log updated successfully");
      } else {
        print("Failed to update tracking log: ${response.body}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
