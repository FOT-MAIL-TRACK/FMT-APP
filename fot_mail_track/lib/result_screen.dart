import 'package:flutter/material.dart';
import 'package:fot_mail_track/qr_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:toast/toast.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  String? _result;

  Toast toast = Toast();

  void setResult(String result) {
    setState(() => _result = result);
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

            const Text(
              "Scanned Results",
              style: TextStyle(
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
