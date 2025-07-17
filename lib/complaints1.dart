import 'package:flutter/material.dart';

class ComplaintsScreen extends StatelessWidget {
  const ComplaintsScreen({super.key});

  final List<Map<String, String>> complaints = const [
    {
      "hospitalName": "Adali Hospital",
      "complaintText": "Lorem ipsum has been the industry's standard dummy text since the 1500s."
    },
    {
      "hospitalName": "Kandy Medical Center",
      "complaintText": "They delayed my appointment by 3 hours with no explanation."
    },
    {
      "hospitalName": "Wellness Clinic",
      "complaintText": "Very poor service. The lab was not functioning as expected."
    },
    {
      "hospitalName": "Nova Health",
      "complaintText": "The pharmacy provided incorrect medication twice."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar with Back Arrow
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Color(0xFF071952)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Complaints',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF071952),
                    ),
                  ),
                ],
              ),
            ),

            const Divider(height: 1, color: Color(0xFFCECECE)),

            // Section Title
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: const Text(
                'Received Complaints',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF071952),
                ),
              ),
            ),

            // Complaints List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: complaints.length,
                itemBuilder: (context, index) {
                  final item = complaints[index];
                  return ComplaintItem(
                    hospitalName: item["hospitalName"]!,
                    complaintText: item["complaintText"]!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ComplaintItem extends StatelessWidget {
  final String hospitalName;
  final String complaintText;

  const ComplaintItem({
    super.key,
    required this.hospitalName,
    required this.complaintText,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      shadowColor: Colors.grey.withOpacity(0.2),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFE0E0E0)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hospital Name
            Text(
              'From: $hospitalName',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15,
                color: Color(0xFF071952),
              ),
            ),
            const SizedBox(height: 10),

            // Complaint Text
            Text(
              complaintText,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[800],
                height: 1.5,
              ),
            ),

            const SizedBox(height: 14),

            // Notify Button
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/notifySuccess');
                },
                icon: const Icon(Icons.notifications_active, size: 18, color: Color(0xFF071952)),
                label: const Text(
                  'Notify',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Color(0xFF071952),
                  ),
                ),
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF071952),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
