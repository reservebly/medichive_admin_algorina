import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddInstitutePage extends StatefulWidget {
  const AddInstitutePage({Key? key}) : super(key: key);

  @override
  State<AddInstitutePage> createState() => _AddInstitutePageState();
}

class _AddInstitutePageState extends State<AddInstitutePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController registerNumberController =
      TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController certificateController = TextEditingController();

  final Color darkBlue = const Color(0xFF071952);
  final _formKey = GlobalKey<FormState>();

  void _showSnack(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red.shade700 : Colors.green,
      ),
    );
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    final url = Uri.parse('http://10.74.27.42:3000/institute');

    final Map<String, String> body = {
      "name": nameController.text.trim(),
      "registerNumber": registerNumberController.text.trim(),
      "telephoneNumber": phoneController.text.trim(),
      "email": emailController.text.trim(),
      "address": addressController.text.trim(),
      "website": websiteController.text.trim(),
      "about": aboutController.text.trim(),
      "certificate": certificateController.text.trim(),
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        _showSnack("Institute created successfully!");
        Navigator.pop(context); 
      } else {
        _showSnack(
          "Failed to create institute: ${response.body}",
          isError: true,
        );
      }
    } catch (e) {
      _showSnack("Error: $e", isError: true);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    registerNumberController.dispose();
    phoneController.dispose();
    emailController.dispose();
    websiteController.dispose();
    addressController.dispose();
    aboutController.dispose();
    certificateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 28,
                    color: Color(0xFF071952),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                const SizedBox(height: 12),
                Center(
                  child: Text(
                    'Add Institute',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: darkBlue,
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                _buildCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Basic Info'),
          _buildTextField(
            nameController,
            'Institute Name',
            validator: _requiredValidator,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            registerNumberController,
            'Institute Registration Number',
            validator: _requiredValidator,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            phoneController,
            'Mobile Number',
            keyboardType: TextInputType.phone,
            validator: _phoneValidator,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            emailController,
            'Email Address',
            keyboardType: TextInputType.emailAddress,
            validator: _emailValidator,
          ),
          const SizedBox(height: 16),
          _buildTextField(websiteController, 'Website'),
          const SizedBox(height: 16),
          _buildTextField(
            addressController,
            'Address',
            validator: _requiredValidator,
          ),
          const SizedBox(height: 28),
          _sectionTitle('Additional Info'),
          _buildTextField(aboutController, 'About ', maxLines: 3),
          const SizedBox(height: 16),
          _buildTextField(
            certificateController,
            'Certificate ',
            maxLines: 2,
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: darkBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Create Institute',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: darkBlue,
          ),
        ),
        const Divider(height: 20, thickness: 2, color: Color(0xFFEBF1F5)),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hintText, {
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: const Color(0xFFF7F9FC),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        border: OutlineInputBorder(
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

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'This field is required';
    return null;
  }

  String? _phoneValidator(String? value) {
    if (value == null || value.trim().isEmpty)
      return 'Phone number is required';
    if (!RegExp(r'^\d{10}$').hasMatch(value)) return 'Enter a 10-digit number';
    return null;
  }

  String? _emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required';
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value))
      return 'Enter a valid email';
    return null;
  }
}
