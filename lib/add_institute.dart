import 'package:flutter/material.dart';

class AddInstitutePage extends StatelessWidget {
  const AddInstitutePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF4F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEAF4F8),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          'Add institute',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Circle Avatar for Image
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[300],
              child: Icon(
                Icons.camera_alt,
                size: 30,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 24),

            // Basic Info
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Basic Info',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const Divider(thickness: 1),

            const SizedBox(height: 12),
            _buildTextField('Institute Name'),
            const SizedBox(height: 12),
            _buildTextField('Institute Registration Number'),

            const SizedBox(height: 24),

            // Contact Information
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Contact Information',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 12),
            _buildTextField('Mobile Number'),
            const SizedBox(height: 12),
            _buildTextField('Email Address'),
            const SizedBox(height: 12),
            _buildTextField('Website'),
            const SizedBox(height: 12),
            _buildTextField('Address'),

            const SizedBox(height: 32),

            // Next Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  // No navigation yet
                },
                child: const Text(
                  'Next',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // TextField Widget
  static Widget _buildTextField(String hintText) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
