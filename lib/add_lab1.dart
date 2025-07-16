import 'package:flutter/material.dart';

class AddLabPage extends StatefulWidget {
  const AddLabPage({super.key});

  @override
  State<AddLabPage> createState() => _AddLabPageState();
}

class _AddLabPageState extends State<AddLabPage> {
  final TextEditingController labNameController = TextEditingController();
  final TextEditingController registrationNumberController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  bool _validateInputs() {
    if (labNameController.text.trim().isEmpty) {
      _showError('Lab Name is required');
      return false;
    }
    if (registrationNumberController.text.trim().isEmpty) {
      _showError('Lab Registration Number is required');
      return false;
    }
    final mobile = mobileController.text.trim();
    if (mobile.isEmpty) {
      _showError('Mobile Number is required');
      return false;
    }
    if (!RegExp(r'^\d{10}$').hasMatch(mobile)) {
      _showError('Mobile Number must be exactly 10 digits');
      return false;
    }
    final email = emailController.text.trim();
    if (email.isEmpty) {
      _showError('Email Address is required');
      return false;
    }
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(email)) {
      _showError('Enter a valid Email Address');
      return false;
    }
    if (addressController.text.trim().isEmpty) {
      _showError('Address is required');
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    labNameController.dispose();
    registrationNumberController.dispose();
    mobileController.dispose();
    emailController.dispose();
    websiteController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBF4F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEBF4F6),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          'Add Lab',
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
            _buildTextField('Lab Name', controller: labNameController),
            const SizedBox(height: 12),
            _buildTextField('Lab Registration Number', controller: registrationNumberController),

            const SizedBox(height: 24),

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
            _buildTextField('Mobile Number', controller: mobileController, keyboardType: TextInputType.phone),
            const SizedBox(height: 12),
            _buildTextField('Email Address', controller: emailController, keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 12),
            _buildTextField('Website', controller: websiteController),
            const SizedBox(height: 12),
            _buildTextField('Address', controller: addressController),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF071952),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  if (_validateInputs()) {
                    Navigator.pushNamed(context, '/labForm');
                  }
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

  static Widget _buildTextField(String hintText,
      {TextEditingController? controller, TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
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
