import 'package:flutter/material.dart';

class ChooseCategoryPage extends StatelessWidget {
  const ChooseCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBF4F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 0,
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
          } else {
            // No action defined yet
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
