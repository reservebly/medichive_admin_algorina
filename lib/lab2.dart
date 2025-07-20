import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LabProfilePage extends StatefulWidget {
  final String labId;

  const LabProfilePage({super.key, required this.labId});

  @override
  State<LabProfilePage> createState() => _LabProfilePageState();
}

class _LabProfilePageState extends State<LabProfilePage> {
  bool isLoading = true;
  bool isSaving = false;
  Map<String, dynamic>? labData;
  String? error;

  final List<String> services = [
    'Blood Test',
    'X-Ray',
    'MRI',
    'CT Scan',
    'Ultrasound',
  ];
  String selectedService = 'Blood Test';

  late TextEditingController nameController;
  late TextEditingController regNumberController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController addressController;
  late TextEditingController websiteController;
  late TextEditingController aboutController;
  late TextEditingController certificateController;

  @override
  void initState() {
    super.initState();
    fetchLab();
  }

  Future<void> fetchLab() async {
    try {
      final url = Uri.parse('http://10.10.3.132:3000/lab/${widget.labId}');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        labData = jsonDecode(response.body);

        nameController = TextEditingController(text: labData?['name'] ?? '');
        regNumberController = TextEditingController(
          text: labData?['registerNumber'] ?? '',
        );
        phoneController = TextEditingController(
          text: labData?['telephoneNumber'] ?? '',
        );
        emailController = TextEditingController(text: labData?['email'] ?? '');
        addressController = TextEditingController(
          text: labData?['address'] ?? '',
        );
        websiteController = TextEditingController(
          text: labData?['website'] ?? '',
        );
        aboutController = TextEditingController(text: labData?['about'] ?? '');
        certificateController = TextEditingController(
          text: labData?['certificate'] ?? '',
        );

        selectedService =
            services.contains(labData?['service'])
                ? labData!['service']
                : services[0];

        setState(() => isLoading = false);
      } else {
        setState(() {
          error = 'Failed to load lab: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = 'Error fetching lab: $e';
        isLoading = false;
      });
    }
  }

  Future<void> _saveChanges() async {
    setState(() => isSaving = true);

    final body = jsonEncode({
      "name": nameController.text.trim(),
      "registerNumber": regNumberController.text.trim(),
      "telephoneNumber": phoneController.text.trim(),
      "email": emailController.text.trim(),
      "address": addressController.text.trim(),
      "website": websiteController.text.trim(),
      "about": aboutController.text.trim(),
      "certificate": certificateController.text.trim(),
      // 🚫 Do NOT include 'service'
    });

    try {
      final url = Uri.parse('http://10.10.3.132:3000/lab/${widget.labId}');
      final response = await http.patch(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      if (response.statusCode == 200) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Lab updated successfully')),
          );
          Navigator.pop(context, true);
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to update: ${response.body}')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      setState(() => isSaving = false);
    }
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedService,
          isExpanded: true,
          items:
              services
                  .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                  .toList(),
          onChanged: (val) => setState(() => selectedService = val!),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Lab Profile')),
        body: Center(child: Text(error!)),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFEBF4F6),
      appBar: AppBar(
        title: Text(labData?['name'] ?? 'Lab Profile'),
        backgroundColor: const Color(0xFF071952),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Basic Info",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              _buildTextField("Lab Name", nameController),
              _buildTextField("Registration Number", regNumberController),
              const Text(
                "Contact",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              _buildTextField("Phone", phoneController),
              _buildTextField("Email", emailController),
              _buildTextField("Address", addressController),
              _buildTextField("Website", websiteController),
              const Text(
                "Services",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              _buildDropdown(), // Optional UI only
              const Text(
                "About",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              _buildTextField("About", aboutController, maxLines: 3),
              const Text(
                "Certificate",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              _buildTextField(
                "Certificate",
                certificateController,
                maxLines: 2,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: isSaving ? null : _saveChanges,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF071952),
                ),
                child:
                    isSaving
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                          "Save Changes",
                          style: TextStyle(color: Colors.white),
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
