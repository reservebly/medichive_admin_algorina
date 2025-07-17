// medichive_main.dart
import 'package:flutter/material.dart';

class MedichiveMainScreen extends StatelessWidget {
  const MedichiveMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF071952),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, '/selectRole');
          },
          child: const Text(
            'MEDICHIVE',
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
    );
  }
}
