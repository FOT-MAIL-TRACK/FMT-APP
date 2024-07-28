import 'package:flutter/material.dart';

class ApproveScreen extends StatefulWidget {
  final String? title;
  final String? sender;
  final String? reciever;
  final String? content;
  const ApproveScreen(
      {required this.title,
      required this.sender,
      required this.reciever,
      required this.content,
      super.key});

  @override
  State<ApproveScreen> createState() => _ApproveScreenState();
}

class _ApproveScreenState extends State<ApproveScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Results Screen"),
      ),
      body: Column(
        children: [Text(widget.title.toString())],
      ),
    );
  }
}
