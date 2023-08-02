import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  final String message;

  const SecondScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.amber),

      ),
    );
  }
}
