import 'package:flutter/material.dart';

class TrackDelete extends StatefulWidget {
  const TrackDelete({super.key});

  @override
  State<TrackDelete> createState() => _TrackDeleteState();
}

class _TrackDeleteState extends State<TrackDelete> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hi"),
      ),
      body: Text("Hi hi hi"),
    );
  }
}
