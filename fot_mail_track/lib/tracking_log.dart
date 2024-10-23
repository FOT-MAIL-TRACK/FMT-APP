import 'package:flutter/material.dart';
import 'package:fot_mail_track/services/auth_service.dart';
import 'package:intl/intl.dart'; // For formatting the date

class TrackingLog extends StatefulWidget {
  final String LetterID;
  const TrackingLog({super.key, required this.LetterID});

  @override
  State<TrackingLog> createState() => _TrackingLogState();
}

class _TrackingLogState extends State<TrackingLog> {
  final AuthService _authService = AuthService();
  Map<String, dynamic>? letterData;

  @override
  void initState() {
    super.initState();
    _fetchLetterData();
  }

  Future<void> _fetchLetterData() async {
    final data = await _authService.fetchOneLetter(widget.LetterID);
    setState(() {
      letterData = data;
    });
  }

  String formatDate(String dateStr) {
    DateTime dateTime = DateTime.parse(dateStr);
    return DateFormat.yMMMd().add_jm().format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Letter Tracker"),
      ),
      body: letterData == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Letter basic information at the top
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Letter ID: ${letterData!['uniqueID']}",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Sender: ${letterData!['sender']['name']}",
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Receiver: ${letterData!['receiver']['name']}",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Tracking Logs
                  const Text(
                    "Tracking Log",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  // Check if trackingLog is empty
                  Expanded(
                    child: letterData!['trackingLog'].isEmpty
                        ? const Center(
                            child: Text(
                              "There's nothing in the tracking log",
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        : ListView.builder(
                            itemCount: letterData!['trackingLog'].length,
                            itemBuilder: (context, index) {
                              final log = letterData!['trackingLog'][index];
                              return Card(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Received By: ${log['name']}",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        "User ID: ${log['user']}",
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        "Updated at: ${formatDate(log['updatedAt'])}",
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
    );
  }
}
