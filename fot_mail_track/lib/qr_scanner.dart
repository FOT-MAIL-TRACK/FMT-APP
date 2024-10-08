import 'package:flutter/material.dart';
import 'package:fot_mail_track/result_screen.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

const bgColor = Color(0xfffafafa);

class QRscanner extends StatefulWidget {
  const QRscanner({super.key});

  @override
  State<QRscanner> createState() => _QRscannerState();
}

class _QRscannerState extends State<QRscanner> {
  final MobileScannerController controller = MobileScannerController();

  String? result = "";

  bool isScanCompleted = false;

  void closeScreen() {
    isScanCompleted = false;
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
                child: MobileScanner(
                  controller: controller,
                  onDetect: (BarcodeCapture capture) async {
                    final List<Barcode> barcodes = capture.barcodes;
                    final barcode = barcodes.first;

                    if (barcode.rawValue != null) {
                      result = barcode.rawValue;

                      await controller
                          .stop()
                          .then((value) => controller.dispose())
                          .then((value) => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => ResultScreen(
                                          result: result,
                                        )),
                              ));
                    }
                  },
                )),
            Expanded(
                child: Container(
              alignment: Alignment.center,
              child: const Text("Developed by FOT-MAIL-TRACK"),
            )),
          ],
        ),
      ),
    );
  }
}
