import 'package:flutter/material.dart';

class ChooseCategoryPage extends StatelessWidget {
  const ChooseCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.from(alpha: 1, red: 0.922, green: 0.957, blue: 0.965),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Go back to SelectRoleScreen
          },
        ),
        title: const Text(
          "Choose Category",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildCategoryButton(context, "Institutes", navigateTo: '/instituteList'),
              const SizedBox(height: 16),
              _buildCategoryButton(context, "Labs", navigateTo: '/labList'),
              const SizedBox(height: 16),
              _buildCategoryButton(context, "Add institute", navigateTo: '/addInstitute'),
              const SizedBox(height: 16),
              _buildCategoryButton(context, "Add lab", navigateTo: '/addLab'),
              const SizedBox(height: 16),
              _buildCategoryButton(
                context,
                "Complaints and Support",
                navigateTo: '/complaints',
              ),
              const SizedBox(height: 16),
              _buildCategoryButton(
                context,
                "Analytics Summary",
                navigateTo: '/analytics',
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildCategoryButton(BuildContext context, String title,
      {String? navigateTo}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1E79BF),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 4,
        ),
        onPressed: () {
          if (navigateTo != null) {
            Navigator.pushNamed(context, navigateTo);
          }
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
