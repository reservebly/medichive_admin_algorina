import 'package:flutter/material.dart';

class InstituteCreatedScreen extends StatelessWidget {
  const InstituteCreatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBF4F6),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 80),
            const SizedBox(height: 20),
            const Text(
              'Institute successfully created!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/chooseCategory'));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF071952),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: const Text('Go to Dashboard', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
