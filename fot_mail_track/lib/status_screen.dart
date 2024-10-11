import 'package:flutter/material.dart';
import 'package:fot_mail_track/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({super.key});

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  final AuthService _authService = AuthService();
  List<dynamic> pData = [];
  String? userRegNo;

  @override
  void initState() {
    super.initState();
    _loadUserId(); // Load the userId when the screen is initialized
  }

  Future<void> _loadUserId() async {
    userRegNo = await getUserInfo();
    setState(() {}); // Update the UI after loading userId
  }

  Future<String?> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    // final String? userId = prefs.getString('user_id');
    final String? userRegNo = prefs.getString('user_Regno');
    // final String? userRole = prefs.getString('user_role');
    print("Reg No is " + userRegNo.toString());
    return userRegNo;
  }

  void _onTrackingBtnPressed() async {
    try {
      await _authService
          .fetchLetters(userRegNo.toString()); // Use the AuthService instance

      // If login is successful, Print Success
      // ignore: avoid_print

      print("Success  ${pData[0]['_id']}");
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
              child: const Text("Show status on terminal")),
          FutureBuilder(
              future: _authService.fetchLetters(userRegNo.toString()),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  pData = snapshot.data;

                  return Expanded(
                    child: ListView.builder(
                        itemCount: pData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text("${pData[index]['_id']}"),
                          );
                        }),
                  );
                }
              })
        ],
      ),
    );
  }
}
