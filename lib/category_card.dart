import 'package:flutter/material.dart';

class ChooseCategoryPage extends StatelessWidget {
  const ChooseCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF6FA), // light blue background
      appBar: AppBar(
        title: const Text('Categories'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildCategoryButton("Hospitals"),
              const SizedBox(height: 16),
              _buildCategoryButton("Labs"),
              const SizedBox(height: 16),
              _buildCategoryButton("Add institute"),
              const SizedBox(height: 16),
              _buildCategoryButton("Add lab"),
              const SizedBox(height: 16),
              _buildCategoryButton("Complains and Support"),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildCategoryButton(String title) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 4,
        ),
        onPressed: () {
          // Add your onPressed logic here
        },
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
