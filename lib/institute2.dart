import 'package:flutter/material.dart';

class InstituteProfilePage extends StatefulWidget {
  const InstituteProfilePage({super.key});

  @override
  State<InstituteProfilePage> createState() => _InstituteProfilePageState();
}

class _InstituteProfilePageState extends State<InstituteProfilePage> {
  String selectedService = 'Channeling';
  final List<String> services = ['Channeling', 'OPD', 'Emergency', 'Pharmacy', 'Laboratory'];

  // Editable controllers
  final TextEditingController phoneController = TextEditingController(text: '+94815656001');
  final TextEditingController emailController = TextEditingController(text: 'asirihospital@gmail.com');
  final TextEditingController websiteController = TextEditingController(text: 'asirihospital.com');
  final TextEditingController addressController = TextEditingController(text: 'Asiri hospital, Kandy');
  final TextEditingController aboutController = TextEditingController(text: "Lorem ipsum has been the industry's standard dummy text ever since the");
  final TextEditingController certificateController = TextEditingController(text: '(1) The best Hospital of the year (2024)');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBF4F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Profile', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            const Text('Asiri Hospital', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const Text('234F', style: TextStyle(color: Colors.grey)),

            const SizedBox(height: 24),
            _sectionTitle('Contact Information'),
            _buildTextField('Mobile number', phoneController),
            _buildTextField('Email', emailController),
            _buildTextField('Address', addressController),
            _buildTextField('Website', websiteController),

            const SizedBox(height: 24),
            _sectionTitle('Services'),
            _buildDropdown(),

            const SizedBox(height: 24),
            _sectionTitle('About'),
            _buildTextField('', aboutController, maxLines: 3),

            const SizedBox(height: 24),
            _sectionTitle('Certificates'),
            _buildTextField('', certificateController, maxLines: 2),

            const SizedBox(height: 32),
            SizedBox(
              width: 370,
              height: 44,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/instituteUpdated');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF071952),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Save Changes', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label.isNotEmpty ? label : null,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Colors.black)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Colors.blue)),
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.black)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedService,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
          items: services.map((String service) {
            return DropdownMenuItem<String>(value: service, child: Text(service));
          }).toList(),
          onChanged: (value) => setState(() => selectedService = value!),
        ),
      ),
    );
  }
}
