import 'package:flutter/material.dart';

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

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red.shade700),
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
    const darkBlue = Color(0xFF071952);
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: darkBlue, size: 28),
                onPressed: () => Navigator.pop(context),
                splashRadius: 24,
              ),
              const SizedBox(height: 4),
              Center(
                child: Text(
                  'Add Lab',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: darkBlue,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Basic Info',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18, color: darkBlue),
                    ),
                    const Divider(height: 20, thickness: 2, color: Color(0xFFEBF1F5)),
                    const SizedBox(height: 14),
                    _buildTextField('Lab Name', controller: labNameController, darkBlue: darkBlue),
                    const SizedBox(height: 16),
                    _buildTextField('Lab Registration Number', controller: registrationNumberController, darkBlue: darkBlue),

                    const SizedBox(height: 32),
                    const Text(
                      'Contact Information',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18, color: darkBlue),
                    ),
                    const Divider(height: 20, thickness: 2, color: Color(0xFFEBF1F5)),
                    const SizedBox(height: 14),
                    _buildTextField(
                      'Mobile Number',
                      controller: mobileController,
                      keyboardType: TextInputType.phone,
                      darkBlue: darkBlue,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      'Email Address',
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      darkBlue: darkBlue,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      'Website (optional)',
                      controller: websiteController,
                      darkBlue: darkBlue,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      'Address',
                      controller: addressController,
                      darkBlue: darkBlue,
                    ),

                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: darkBlue,
                          elevation: 6,
                          shadowColor: darkBlue.withOpacity(0.6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: () {
                          if (_validateInputs()) {
                            Navigator.pushNamed(context, '/labForm'); // or submit directly if needed
                          }
                        },
                        child: const Text(
                          'Next',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildTextField(
    String hintText, {
    TextEditingController? controller,
    TextInputType keyboardType = TextInputType.text,
    required Color darkBlue,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(color: darkBlue, fontSize: 16, fontWeight: FontWeight.w500),
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
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: darkBlue, width: 2),
        ),
      ),
    );
  }
}
