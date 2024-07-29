import 'package:flutter/material.dart';

class RejectScreen extends StatefulWidget {
  final String? sender;
  final String? reciever;
  const RejectScreen({required this.reciever, required this.sender, super.key});

  @override
  State<RejectScreen> createState() => _RejectScreenState();
}

class _RejectScreenState extends State<RejectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Letter Rejected"),
      ),
      body: const Column(
        children: [
          Text("Letter Rejected"),
          SizedBox(
            height: 20,
          ),
          Text("Reason For Rejection"),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Reason',
            ),
          ),
        ],
      ),
    );
  }
}
