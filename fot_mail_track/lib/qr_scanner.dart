import 'package:flutter/material.dart';

const bgColor = Color(0xfffafafa);

class QRscanner extends StatelessWidget {
  const QRscanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text("QR Scanner"),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Place the QR Code in the Erea"),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Scanning Will be Started Automatically")
                ],
              ),
            ),
            Expanded(
                flex: 4,
                child: Container(
                  color: Colors.green,
                )),
            Expanded(
                child: Container(
              color: Colors.amber,
            )),
          ],
        ),
      ),
    );
  }
}
