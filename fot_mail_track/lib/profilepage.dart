import 'package:flutter/material.dart';
import 'package:fot_mail_track/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  //Create AuthServices Instant
  final AuthService _authService = AuthService();

  //Create initState to load data (active methods with start)

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  //Create Assign Details Method
  Future<void> _assignDetails() async {
    setState(() {});
  }

  //Method For getting user info
  Future<String?> getUserName() async {
    final shInstant = await SharedPreferences.getInstance();
    final String? userName = shInstant.getString('username');
  }

  Future<String?> getUserID() async {}

  Future<String?> getUserRole() async {}

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
