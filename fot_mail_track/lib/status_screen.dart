import 'package:flutter/material.dart';
import 'package:fot_mail_track/services/auth_service.dart';
import 'package:fot_mail_track/tracking_log.dart';
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
    final String? userRegNo = prefs.getString('user_Regno');
    return userRegNo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Letter Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.15),
        child: Column(
          children: [
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
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TrackingLog(),
                                  ),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                    horizontal:
                                        16.0), // Spacing between list tiles
                                decoration: BoxDecoration(
                                  color: Colors.white, // Background color
                                  borderRadius: BorderRadius.circular(
                                      12.0), // Rounded corners
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey
                                          .withOpacity(0.5), // Shadow color
                                      spreadRadius:
                                          2, // How much the shadow spreads
                                      blurRadius:
                                          5, // The blur effect of the shadow
                                      offset:
                                          const Offset(0, 3), // Shadow position
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                      16.0), // Padding inside the container
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Letter ID : ${pData[index]['uniqueID']}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Senders Name: ${pData[index]['sender']['name']}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        "Receiver Name: ${pData[index]['receiver']['name']}",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}
