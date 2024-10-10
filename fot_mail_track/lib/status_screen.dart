import 'package:flutter/material.dart';
import 'package:fot_mail_track/services/auth_service.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({super.key});

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  final AuthService _authService = AuthService();
  List<dynamic> pData = [];
  void _onTrackingBtnPressed() async {
    String regnumber = "E-2";

    try {
      await _authService
          .fetchLetters(regnumber); // Use the AuthService instance

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
              future: _authService.fetchLetters("E-2"),
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
