import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InstituteProfilePage extends StatefulWidget {
  final Map<String, dynamic> instituteData;

  const InstituteProfilePage({super.key, required this.instituteData});

  @override
  State<InstituteProfilePage> createState() => _InstituteProfilePageState();
}

class _InstituteProfilePageState extends State<InstituteProfilePage> {
  late TextEditingController nameController;
  late TextEditingController registrationController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController addressController;
  late TextEditingController websiteController;
  late TextEditingController aboutController;
  late TextEditingController certificateController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.instituteData['name']);
    registrationController = TextEditingController(text: widget.instituteData['registerNumber']);
    phoneController = TextEditingController(text: widget.instituteData['telephoneNumber']);
    emailController = TextEditingController(text: widget.instituteData['email']);
    addressController = TextEditingController(text: widget.instituteData['address']);
    websiteController = TextEditingController(text: widget.instituteData['website']);
    aboutController = TextEditingController(text: widget.instituteData['about']);
    certificateController = TextEditingController(text: widget.instituteData['certificate']);
  }

  Future<void> updateInstitute() async {
    final String id = widget.instituteData['id'];
    final url = Uri.parse('http://192.168.43.120:3000/institutes/$id');

    final updatedData = {
      "name": nameController.text,
      "registerNumber": registrationController.text,
      "telephoneNumber": phoneController.text,
      "email": emailController.text,
      "address": addressController.text,
      "website": websiteController.text,
      "about": aboutController.text,
      "certificate": certificateController.text,
    };

    try {
      final response = await http.patch(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(updatedData),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Updated successfully")),
        );
        Navigator.pushReplacementNamed(context, '/institute3');
      } else {
        print("Update failed: ${response.statusCode}");
        print("Response body: ${response.body}");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to update. Please try again.")),
        );
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    registrationController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    websiteController.dispose();
    aboutController.dispose();
    certificateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Institute'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildTextField('Name', nameController),
              buildTextField('Registration Number', registrationController),
              buildTextField('Phone Number', phoneController),
              buildTextField('Email', emailController),
              buildTextField('Address', addressController),
              buildTextField('Website', websiteController),
              buildTextField('About', aboutController),
              buildTextField('Certificate', certificateController),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: updateInstitute,
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
