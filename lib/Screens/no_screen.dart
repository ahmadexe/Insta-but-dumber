import 'package:flutter/material.dart';

class NoScreen extends StatelessWidget {
  const NoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Yup, I haven't implemented this screen yet."),
      ),
    );
  }
}