import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LaunchScreen extends StatelessWidget {
  const LaunchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Hello World")
        ],
      ),
    );
  }
}
