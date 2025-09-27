import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddLabFullPage extends StatefulWidget {
  const AddLabFullPage({super.key});

  @override
  State<AddLabFullPage> createState() => _AddLabFullPageState();
}

class _AddLabFullPageState extends State<AddLabFullPage> {
  final TextEditingController labNameController = TextEditingController();
  final TextEditingController registrationNumberController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController certificateController = TextEditingController();

  bool isLoading = false;

  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red.shade700 : Colors.green.shade600,
      ),
    );
  }

  bool _validateInputs() {
    if (labNameController.text.trim().isEmpty) {
      _showMessage('Lab Name is required', isError: true);
      return false;
    }
    if (registrationNumberController.text.trim().isEmpty) {
      _showMessage('Lab Registration Number is required', isError: true);
      return false;
    }
    final mobile = mobileController.text.trim();
    if (mobile.isEmpty || !RegExp(r'^\d{10}$').hasMatch(mobile)) {
      _showMessage('Mobile Number must be exactly 10 digits', isError: true);
      return false;
    }
    final email = emailController.text.trim();
    if (email.isEmpty || !RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
      _showMessage('Enter a valid Email Address', isError: true);
      return false;
    }
    if (addressController.text.trim().isEmpty) {
      _showMessage('Address is required', isError: true);
      return false;
    }
    return true;
  }

  Future<void> _submitForm() async {
    setState(() => isLoading = true);
    final labData = {
      "name": labNameController.text.trim(),
      "registerNumber": registrationNumberController.text.trim(),
      "telephoneNumber": mobileController.text.trim(),
      "email": emailController.text.trim(),
      "address": addressController.text.trim(),
      "website": websiteController.text.trim(),
      "about": aboutController.text.trim(),
      "certificate": certificateController.text.trim(),
    };

    final url = Uri.parse('http://192.168.43.120:3000/lab');

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(labData),
      );

      if (response.statusCode == 201) {
        // Lab created successfully — navigate only
        Navigator.pushNamed(context, '/labCreated');
      } else {
        _showMessage('Failed to add lab. Try again.', isError: true);
      }
    } catch (e) {
      _showMessage('Error: $e', isError: true);
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    labNameController.dispose();
    registrationNumberController.dispose();
    mobileController.dispose();
    emailController.dispose();
    websiteController.dispose();
    addressController.dispose();
    aboutController.dispose();
    certificateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const darkBlue = Color(0xFF071952);
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: darkBlue, size: 28),
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(height: 4),
              Center(
                child: Text(
                  'Add Lab',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: darkBlue,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Basic Info', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: darkBlue)),
                    const Divider(),
                    _buildTextField('Lab Name', controller: labNameController, darkBlue: darkBlue),
                    _buildTextField('Lab Registration Number', controller: registrationNumberController, darkBlue: darkBlue),
                    const SizedBox(height: 20),
                    const Text('Contact Information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: darkBlue)),
                    const Divider(),
                    _buildTextField('Mobile Number', controller: mobileController, keyboardType: TextInputType.phone, darkBlue: darkBlue),
                    _buildTextField('Email Address', controller: emailController, keyboardType: TextInputType.emailAddress, darkBlue: darkBlue),
                    _buildTextField('Website ', controller: websiteController, darkBlue: darkBlue),
                    _buildTextField('Address', controller: addressController, darkBlue: darkBlue),
                    const SizedBox(height: 20),
                    const Text('Other Info', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: darkBlue)),
                    const Divider(),
                    _buildTextField('About ', controller: aboutController, darkBlue: darkBlue),
                    _buildTextField('Certificate ', controller: certificateController, darkBlue: darkBlue),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () {
                                if (_validateInputs()) {
                                  _submitForm();
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: darkBlue,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 6,
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text('Submit', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildTextField(
    String hintText, {
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    required Color darkBlue,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(color: darkBlue),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: darkBlue.withOpacity(0.5)),
          filled: true,
          fillColor: const Color(0xFFF7F9FC),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: darkBlue, width: 2),
          ),
        ),
      ),
    );
  }
}
