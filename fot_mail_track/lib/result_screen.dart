import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fot_mail_track/qr_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ResultScreen extends StatefulWidget {
  final String? result;
  const ResultScreen({required this.result, super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  void setFields(String? result) {
    if (result == null || result == "") {
      result = "NO VALUE";
    } else {
      // Step 2: Decode the JSON string
      Map<String, dynamic> jsonData = json.decode(result);

      // Step 3: Extract values
      String? title = jsonData['title'];
      //ToDo Do Rest from here
      print("TITLE IS : ");
      print(title);
    }
  }

  @override
  void initState() {
    super.initState();
    setFields(widget.result);
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
      body: Padding(
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
              widget.result ?? 'No result',
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
                onPressed: () {},
                child: const Text(
                  "COPY",
                  style: TextStyle(
                      color: Colors.black87, fontSize: 16, letterSpacing: 1),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
