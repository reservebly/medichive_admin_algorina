import 'package:flutter/material.dart';

class SelectRoleScreen extends StatelessWidget {
  final List<Map<String, String>> roles = [
    {"title": "Patient", "icon": "assets/patient.png"},
    {"title": "Doctor", "icon": "assets/doctor.png"},
    {"title": "Lab Admin", "icon": "assets/lab admin.jpg"},
    {"title": "Institute Admin", "icon": "assets/institute admin.png"},
    {"title": "Medichive Admin", "icon": "assets/medichive admin.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF071952),
      appBar: AppBar(
        backgroundColor: const Color(0xFF071952),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Select Your Role",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // First row with Patient, Doctor, Lab Admin
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildRoleItem(context, roles[0]), // Patient
                const SizedBox(width: 30),
                _buildRoleItem(context, roles[1]), // Doctor
                const SizedBox(width: 30),
                _buildRoleItem(context, roles[2]), // Lab Admin
              ],
            ),
            const SizedBox(height: 24),
            // Second row with Institute Admin, Medichive Admin
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildRoleItem(context, roles[3]), // Institute Admin
                const SizedBox(width: 30),
                _buildRoleItem(context, roles[4]), // Medichive Admin
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleItem(BuildContext context, Map<String, String> role) {
    return GestureDetector(
      onTap: () {
        if (role['title'] == 'Medichive Admin') {
          Navigator.pushNamed(context, '/chooseCategory');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${role['title']} selected'),
              backgroundColor: Colors.blueGrey[800],
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 70,
              width: 70,
              child: Image.asset(
                role["icon"]!,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.image_not_supported,
                  size: 40,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              role["title"]!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF071952),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
