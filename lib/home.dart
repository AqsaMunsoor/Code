import 'package:flutter/material.dart';
import 'package:scalpinspector_app/screens/auth/login_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Text(
              '$height',
              style: TextStyle(fontSize: 30),
            ),
          ),
          Center(
            child: Text(
              '$width',
              style: TextStyle(fontSize: 30),
            ),
          ),
        ],
      ),
    );
  }
}
