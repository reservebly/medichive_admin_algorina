import 'package:flutter/material.dart';

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
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Received complaints',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 8),
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
                  // Handle notification action
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue,
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