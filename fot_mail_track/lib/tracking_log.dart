// import 'package:flutter/material.dart';
// import 'package:fot_mail_track/services/auth_service.dart';
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart'; // For formatting the date

// class TrackingLog extends StatefulWidget {
//   final String LetterID;
//   final String uniqueID;
//   const TrackingLog(
//       {super.key, required this.LetterID, required this.uniqueID});

//   @override
//   State<TrackingLog> createState() => _TrackingLogState();
// }

// class _TrackingLogState extends State<TrackingLog> {
//   final AuthService _authService = AuthService();
//   Map<String, dynamic>? letterData;
//   String? userId;
//   String? uName;
//   String? userRegNo;

//   @override
//   void initState() {
//     super.initState();
//     _fetchLetterData();
//     _loadUserId();
//   }

//   Future<void> _loadUserId() async {
//     userRegNo = await getUserRegNo();
//     userId = await getUserId();
//     uName = await getName();
//     setState(() {}); // Update the UI after loading userId
//   }

//   Future<String?> getName() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString('name');
//   }

//   Future<String?> getUserRegNo() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString('user_Regno');
//   }

//   Future<String?> getUserId() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString('user_id');
//   }

// //update tracking log
//   Future<void> _updateTrackingLog() async {
//     bool lState = false;
//     for (int i = 0; i < letterData!['trackingLog'].length; i++) {
//       final trackingLog = letterData!['trackingLog'][i];
//       if (trackingLog['user'].toString() == userRegNo.toString()) {
//         lState = true;
//       }
//     }

//     String SenderID = letterData!['sender']['registrationNumber'];
//     SenderID = SenderID.trim();
//     String userID = userRegNo.toString();
//     userID = userID.trim();
//     print("Sender Id is " + SenderID);
//     print("User's Registration Number is " + userRegNo.toString());

//     if (lState == false && userID != SenderID) {
//       await _authService.updateTrackingLog(
//           userId, uName, userRegNo, widget.uniqueID);
//     }

//     setState(() {
//       _fetchLetterData();
//     });
//   }

//   Future<void> _fetchLetterData() async {
//     final data = await _authService.fetchOneLetter(widget.LetterID);
//     setState(() {
//       letterData = data;
//     });
//   }

//   String formatDate(String dateStr) {
//     DateTime dateTime = DateTime.parse(dateStr);
//     return DateFormat.yMMMd().add_jm().format(dateTime);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Letter Tracker"),
//       ),
//       body: letterData == null
//           ? const Center(child: CircularProgressIndicator())
//           : Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Letter basic information at the top
//                   Card(
//                     elevation: 5,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Letter ID: ${letterData!['uniqueID']}",
//                             style: const TextStyle(
//                                 fontSize: 18, fontWeight: FontWeight.bold),
//                           ),
//                           const SizedBox(height: 10),
//                           Text(
//                             "Sender: ${letterData!['sender']['name']}",
//                             style: const TextStyle(fontSize: 16),
//                           ),
//                           const SizedBox(height: 10),
//                           Text(
//                             "Receiver: ${letterData!['receiver']['name']}",
//                             style: const TextStyle(fontSize: 16),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),

//                   // Tracking Logs
//                   const Text(
//                     "Tracking Log",
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 10),

//                   // Check if trackingLog is empty
//                   Expanded(
//                     child: letterData!['trackingLog'].isEmpty
//                         ? const Center(
//                             child: Text(
//                               "There's nothing in the tracking log",
//                               style: TextStyle(fontSize: 16),
//                             ),
//                           )
//                         : ListView.builder(
//                             itemCount: letterData!['trackingLog'].length,
//                             itemBuilder: (context, index) {
//                               final log = letterData!['trackingLog'][index];
//                               return Card(
//                                 margin:
//                                     const EdgeInsets.symmetric(vertical: 8.0),
//                                 elevation: 3,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(16.0),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "Received By: ${log['name']}",
//                                         style: const TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                       const SizedBox(height: 5),
//                                       Text(
//                                         "User ID: ${log['user']}",
//                                         style: const TextStyle(fontSize: 14),
//                                       ),
//                                       const SizedBox(height: 5),
//                                       Text(
//                                         "Updated at: ${formatDate(log['updatedAt'])}",
//                                         style: const TextStyle(fontSize: 14),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(20.20),
//                     child: Center(
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           foregroundColor: const Color.fromARGB(255, 116, 3, 3),
//                           backgroundColor: const Color.fromARGB(
//                               255, 229, 222, 221), // foreground
//                         ),
//                         onPressed: _updateTrackingLog,
//                         child: const Text('Update Tracking Log'),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//     );
//   }
// }

//new code

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fot_mail_track/services/auth_service.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrackingLog extends StatefulWidget {
  final String LetterID;
  final String uniqueID;
  const TrackingLog(
      {super.key, required this.LetterID, required this.uniqueID});

  @override
  State<TrackingLog> createState() => _TrackingLogState();
}

class _TrackingLogState extends State<TrackingLog> {
  final AuthService _authService = AuthService();
  Map<String, dynamic>? letterData;
  String? userId;
  String? uName;
  String? userRegNo;

  @override
  void initState() {
    super.initState();
    _fetchLetterData();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    userRegNo = await getUserRegNo();
    userId = await getUserId();
    uName = await getName();
    setState(() {});
  }

  Future<String?> getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('name');
  }

  Future<String?> getUserRegNo() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_Regno');
  }

  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_id');
  }

  Future<void> _showUpdateDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Letter ID: ${widget.LetterID}"),
          content: Text("$uName, I received this letter."),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: IconButton(
                    icon: Image.asset('assets/right.png'),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      await _updateTrackingLog();
                    },
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: 50,
                  child: IconButton(
                    icon: Image.asset('assets/reject.png'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateTrackingLog() async {
    try {
      bool lState = false;
      for (int i = 0; i < letterData!['trackingLog'].length; i++) {
        final trackingLog = letterData!['trackingLog'][i];
        if (trackingLog['user'].toString() == userRegNo.toString()) {
          lState = true;
        }
      }

      String senderID = letterData!['sender']['registrationNumber'].trim();
      String userID = userRegNo.toString().trim();

      if (!lState && userID != senderID) {
        await _authService.updateTrackingLog(
            userId, uName, userRegNo, widget.uniqueID);
        Fluttertoast.showToast(msg: "Tracking Log successfully updated");
      } else {
        Fluttertoast.showToast(
            msg: "Tracking log update failed", backgroundColor: Colors.red);
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Tracking log update failed", backgroundColor: Colors.red);
    }

    setState(() {
      _fetchLetterData();
    });
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
                  const Text(
                    "Tracking Log",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
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
                  Padding(
                    padding: const EdgeInsets.all(20.20),
                    child: Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color.fromARGB(255, 116, 3, 3),
                          backgroundColor:
                              const Color.fromARGB(255, 229, 222, 221),
                        ),
                        onPressed: _showUpdateDialog,
                        child: const Text('Update Tracking Log'),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
