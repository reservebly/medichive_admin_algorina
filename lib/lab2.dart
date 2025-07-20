import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LabProfilePage extends StatefulWidget {
  final int labId;

  const LabProfilePage({super.key, required this.labId, required Map labData});

  @override
  State<LabProfilePage> createState() => _LabProfilePageState();
}

class _LabProfilePageState extends State<LabProfilePage> {
  bool isLoading = true;
  bool isSaving = false;
  Map<String, dynamic>? labData;
  String? error;

  String selectedService = 'Blood Test';
  final List<String> services = [
    'Blood Test',
    'X-Ray',
    'MRI',
    'CT Scan',
    'Ultrasound',
  ];

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
      final url = Uri.parse('http://localhost:3000/labs/${widget.labId}');
      final response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        labData = jsonDecode(response.body);

        nameController = TextEditingController(text: labData?['name'] ?? '');
        regNumberController = TextEditingController(
          text: labData?['registrationNumber'] ?? '',
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

    // Validate required fields
    if (nameController.text.trim().isEmpty ||
        regNumberController.text.trim().isEmpty ||
        phoneController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        addressController.text.trim().isEmpty) {
      setState(() => isSaving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
      return;
    }

    final url = Uri.parse('http://localhost:3000/labs/${widget.labId}');
    // Ensure all fields match the API's expected format
    final body = jsonEncode({
      "name": nameController.text.trim(),
      "registrationNumber": regNumberController.text.trim(),
      "telephoneNumber": phoneController.text.trim(),
      "email": emailController.text.trim(),
      "address": addressController.text.trim(),
      "website":
          websiteController.text.trim().isEmpty
              ? null
              : websiteController.text.trim(),
      "about":
          aboutController.text.trim().isEmpty
              ? null
              : aboutController.text.trim(),
      "certificate":
          certificateController.text.trim().isEmpty
              ? null
              : certificateController.text.trim(),
    });

    try {
      print('Sending update request with body: $body'); // Debug print

      final response = await http.patch(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      print('Response status: ${response.statusCode}'); // Debug print
      print('Response body: ${response.body}'); // Debug print

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Lab updated successfully')),
          );
          Navigator.pop(context, true);
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to update lab: ${response.body}')),
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
          labelText: label.isNotEmpty ? label : null,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedService,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down),
          items:
              services
                  .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                  .toList(),
          onChanged: (value) => setState(() => selectedService = value!),
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
  );

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Lab Profile")),
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
              _sectionTitle('Basic Info'),
              _buildTextField('Lab Name', nameController),
              _buildTextField('Registration Number', regNumberController),
              _sectionTitle('Contact Information'),
              _buildTextField('Mobile number', phoneController),
              _buildTextField('Email', emailController),
              _buildTextField('Address', addressController),
              _buildTextField('Website', websiteController),
              _sectionTitle('Services'),
              _buildDropdown(),
              _sectionTitle('About'),
              _buildTextField('', aboutController, maxLines: 3),
              _sectionTitle('Certificates'),
              _buildTextField('', certificateController, maxLines: 2),
              const SizedBox(height: 20),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: ElevatedButton(
                    onPressed: isSaving ? null : _saveChanges,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF071952),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child:
                        isSaving
                            ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                            : const Text(
                              'Save Changes',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
