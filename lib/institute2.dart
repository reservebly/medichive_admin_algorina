import 'package:flutter/material.dart';

class InstituteProfilePage extends StatefulWidget {
  const InstituteProfilePage({super.key});

  @override
  State<InstituteProfilePage> createState() => _InstituteProfilePageState();
}

class _InstituteProfilePageState extends State<InstituteProfilePage> {
  String selectedService = 'Channeling';
  final List<String> services = ['Channeling', 'OPD', 'Emergency', 'Pharmacy', 'Laboratory'];

  final TextEditingController phoneController = TextEditingController(text: '+94815656001');
  final TextEditingController emailController = TextEditingController(text: 'asirihospital@gmail.com');
  final TextEditingController websiteController = TextEditingController(text: 'asirihospital.com');
  final TextEditingController addressController = TextEditingController(text: 'Asiri hospital, Kandy');
  final TextEditingController aboutController = TextEditingController(text: "Lorem ipsum has been the industry's standard dummy text ever since the");
  final TextEditingController certificateController = TextEditingController(text: '(1) The best Hospital of the year (2024)');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Custom Back Button and Title
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Color(0xFF071952), size: 28),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/categories');
                  },
                ),
                const SizedBox(width: 8),
                const Text(
                  '',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF071952),
                  ),
                ),
              ],
            ),

            // Title section
            Center(
              child: Column(
                children: const [
                  SizedBox(height: 12),
                  Text('Asiri Hospital', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text('Institute ID: 234F', style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 24),
                ],
              ),
            ),

            _sectionTitle('📞 Contact Information'),
            _buildTextField('Mobile number', phoneController),
            _buildTextField('Email', emailController),
            _buildTextField('Address', addressController),
            _buildTextField('Website', websiteController),

            const SizedBox(height: 24),
            _sectionTitle('💼 Services'),
            _buildDropdown(),

            const SizedBox(height: 24),
            _sectionTitle('ℹ️ About'),
            _buildTextField('Description', aboutController, maxLines: 3),

            const SizedBox(height: 24),
            _sectionTitle('🏅 Certificates'),
            _buildTextField('Achievements', certificateController, maxLines: 2),

            const SizedBox(height: 32),
            Center(
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/instituteUpdated');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF071952),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    'Save Changes',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Color(0xFF071952)),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black54),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black26),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.blue),
          ),
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
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black26),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedService,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
          items: services.map((String service) {
            return DropdownMenuItem<String>(
              value: service,
              child: Text(service),
            );
          }).toList(),
          onChanged: (value) => setState(() => selectedService = value!),
        ),
      ),
    );
  }
}
