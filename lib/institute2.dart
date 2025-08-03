import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class InstituteProfilePage extends StatefulWidget {
  final Map<String, dynamic> instituteData;

  const InstituteProfilePage({super.key, required this.instituteData});

  @override
  State<InstituteProfilePage> createState() => _InstituteProfilePageState();
}

class _InstituteProfilePageState extends State<InstituteProfilePage> {
  late TextEditingController nameController;
  late TextEditingController registrationController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  late TextEditingController websiteController;
  late TextEditingController aboutController;
  late TextEditingController certificateController;

  @override
  void initState() {
    super.initState();
    final data = widget.instituteData;
    nameController = TextEditingController(text: data['name'] ?? '');
    registrationController = TextEditingController(
      text: data['registerNumber'] ?? '',
    );
    emailController = TextEditingController(text: data['email'] ?? '');
    phoneController = TextEditingController(
      text: data['telephoneNumber'] ?? '',
    );
    addressController = TextEditingController(text: data['address'] ?? '');
    websiteController = TextEditingController(text: data['website'] ?? '');
    aboutController = TextEditingController(text: data['about'] ?? '');
    certificateController = TextEditingController(
      text: data['certificate'] ?? '',
    );
  }

  Future<void> updateInstitute() async {
    final String id = widget.instituteData['id'];
    final url = Uri.parse('http://10.74.27.42:3000/institute/$id');

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

    final response = await http.patch(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(updatedData),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Updated successfully")));
      Navigator.pop(context);
    } else {
      print("Update failed: ${response.statusCode}");
      print("Response body: ${response.body}");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to update. Please try again.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Institute"),
        backgroundColor: const Color(0xFF071952),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            buildField("Name", nameController),
            buildField("Registration Number", registrationController),
            buildField("Email", emailController),
            buildField("Telephone", phoneController),
            buildField("Address", addressController),
            buildField("Website", websiteController),
            buildField("About", aboutController),
            buildField("Certificate", certificateController),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: updateInstitute,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF071952),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 12,
                ),
              ),
              child: const Text("Save Changes", style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
