import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fot_mail_track/approve_screen.dart';
import 'package:fot_mail_track/qr_scanner.dart';
import 'package:fot_mail_track/reject_screen.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ResultScreen extends StatefulWidget {
  final String? result;
  const ResultScreen({required this.result, super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  String? title;
  String? content;
  String? sender;
  String? receiver;
  //SetFields Method
  String? setFields(String? result) {
    if (result == null || result == "") {
      result = "NO VALUE";
      return result;
    } else {
      // Step 2: Decode the JSON string
      Map<String, dynamic> jsonData = json.decode(result);

      // Step 3: Extract values
      title = jsonData['title'];
      content = jsonData['content'];
      sender = jsonData['sender'];
      receiver = jsonData['receiver'];

      return "Title is $title \n Sender is $sender. \n Receiver is $receiver";
    }
  }

  @override
  void initState() {
    super.initState();
    setFields(widget.result);
    print("Title is : ");
    print(title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "QR Scanner",
          style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              letterSpacing: 1),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              //Show QR Image Here
              QrImageView(
                data: "",
                size: 150,
                version: QrVersions.auto,
              ),

              Text(
                setFields(widget.result) ?? 'No result',
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Results",
                style: TextStyle(
                    color: Colors.black87, fontSize: 16, letterSpacing: 1),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 100,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ApproveScreen(
                                title: title,
                                sender: sender,
                                reciever: receiver,
                                content: content,
                              )),
                    );
                  },
                  child: const Text(
                    "Approve",
                    style: TextStyle(
                        color: Colors.black87, fontSize: 16, letterSpacing: 1),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 100,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 218, 28, 28),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RejectScreen(
                                sender: sender,
                                reciever: receiver,
                              )),
                    );
                  },
                  child: const Text(
                    "Reject",
                    style: TextStyle(
                        color: Color.fromARGB(221, 231, 217, 217),
                        fontSize: 16,
                        letterSpacing: 1),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
