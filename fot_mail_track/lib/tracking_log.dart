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

  //Update Current Holder
  Future<void> updateCurrentUser(String regNo) async {}

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
          title: Text("Letter ID: ${widget.uniqueID}"),
          content: Text("$uName, received this letter."),
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
      //Current user reg No - registrationNumber
      String userID = userRegNo.toString().trim();

      //End recievers registration number
      String recieverID = letterData!['receiver']['registrationNumber'].trim();

      //Current latter Status
      String letterStatus = letterData!['status'].trim();

      String completeState = "Completed";
      String inProgressState = "In Progress";
      //Method for check and update and status
      Future<void> _updateCurrentStatus() async {
        if (letterStatus == "Pending") {
          try {
            if (userID == recieverID) {
              //Status Update Function

              await _authService.updateStatus(
                  widget.uniqueID, completeState.trim());
            } else {
              await _authService.updateStatus(
                  widget.uniqueID, inProgressState.trim());
            }
          } catch (e) {
            // ignore: avoid_print
            print("Error is : $e");
          }
        }
      }

      //Check wether this is external letter
      if (letterData!['uniqueID'].startsWith("EXT")) {
        if (!lState) {
          await _authService.updateTrackingLog(
              userId, uName, userRegNo, widget.uniqueID);

          _updateCurrentStatus();

          Fluttertoast.showToast(msg: "Tracking Log successfully updated");
        } else {
          Fluttertoast.showToast(
              msg: "Tracking log update failed", backgroundColor: Colors.red);
        }
      } else {
        String senderID = letterData!['sender']['registrationNumber'].trim();

        if (!lState && userID != senderID) {
          await _authService.updateTrackingLog(
              userId, uName, userRegNo, widget.uniqueID);

          _updateCurrentStatus();
          Fluttertoast.showToast(msg: "Tracking Log successfully updated");
        } else {
          Fluttertoast.showToast(
              msg: "Tracking log update failed", backgroundColor: Colors.red);
        }
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
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor:
                                const Color.fromARGB(255, 116, 3, 3),
                            backgroundColor:
                                const Color.fromARGB(255, 236, 41, 41),
                          ),
                          onPressed: _showUpdateDialog,
                          child: const Text(
                            'Update Tracking Log',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
