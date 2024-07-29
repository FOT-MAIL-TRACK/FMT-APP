import 'package:flutter/material.dart';

class RejectScreen extends StatefulWidget {
  final String? sender;
  final String? reciever;
  const RejectScreen({required this.reciever, required this.sender, super.key});

  @override
  State<RejectScreen> createState() => _RejectScreenState();
}

class _RejectScreenState extends State<RejectScreen> {
  late TextEditingController _controller;
  Color _borderColor = Colors.grey;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Letter Rejected"),
      ),
      body: Column(
        children: [
          const Text("Letter Rejected"),
          const SizedBox(
            height: 20,
          ),
          const Text("Reason For Rejection"),
          Container(
            margin: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  borderSide: BorderSide(color: _borderColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: _borderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: _borderColor),
                ),
                labelText: 'Reason',
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 50.0, horizontal: 15.0),
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                String reason = _controller.text;
                if (reason != "") {
                  //Copied Code
                  await showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Thanks!'),
                        content: Text(
                            'You typed "$reason", which has length ${reason.characters.length}.'),
                      );
                    },
                  );
                } else {
                  setState(() async {
                    _borderColor = Colors.red;
                    await showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return const AlertDialog(
                          // title: Text('Resason!'),
                          content: Text('Please Enter Reason for Rejection'),
                        );
                      },
                    );
                  });
                }
              },
              child: const Text("Submit")),
        ],
      ),
    );
  }
}
