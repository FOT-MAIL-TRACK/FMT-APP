import 'package:flutter/material.dart';
import 'package:fot_mail_track/services/auth_service.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({super.key});

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  final AuthService _authService = AuthService();
  void _onTrackingBtnPressed() async {
    String regnumber = "E-2";

    try {
      await _authService
          .fetchLetters(regnumber); // Use the AuthService instance

      // If login is successful, Print Success
      // ignore: avoid_print

      print("Success  ${_authService.letters[0]['_id']}");
    } catch (e) {
      // ignore: avoid_print
      print('Letter Error : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("StatusScreen"),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: _onTrackingBtnPressed,
              child: const Text("Show status on terminal"))
        ],
      ),
    );
  }
}
