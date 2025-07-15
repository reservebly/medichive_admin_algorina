import 'package:flutter/material.dart';

class ComplaintsScreen extends StatelessWidget {
  const ComplaintsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complaints and Support'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Received Complaints',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) => const ComplaintItem(
                  hospitalName: 'Adali Hospital',
                  complaintText:
                      'Lorem ipsum faci isoem the industry\'s standard dummy text ever since the',
                ),
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
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(
          color: Color(0xFFCECECE),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'From: $hospitalName',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              complaintText,
              style: TextStyle(
                color: Colors.grey[700],
                height: 1.4,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/notifySuccess');
                },
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF071952), // Notify button color
                ),
                child: const Text('Notify'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
