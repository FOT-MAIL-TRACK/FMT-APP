import 'package:flutter/material.dart';

//import 'mongo_service.dart';

class ProcessScannedData extends StatelessWidget {
  final String letterId;

  ProcessScannedData({required this.letterId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Process Letter')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              //await MongoService().updateTracker(letterId, 'Approved');
              Navigator.pop(context);
            },
            child: Text('Approve'),
          ),
          ElevatedButton(
            onPressed: () async {
              await _showRejectDialog(context);
            },
            child: Text('Reject'),
          ),
        ],
      ),
    );
  }

  Future<void> _showRejectDialog(BuildContext context) async {
    TextEditingController reasonController = TextEditingController();
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Reject Letter'),
          content: TextField(
            controller: reasonController,
            decoration: InputDecoration(hintText: 'Enter reason'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Submit'),
              onPressed: () async {
                //   await MongoService().updateTracker(letterId, 'Rejected',
                //       reason: reasonController.text);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
