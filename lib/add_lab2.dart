import 'package:flutter/material.dart';

class LabFormPage extends StatefulWidget {
  const LabFormPage({super.key});

  @override
  State<LabFormPage> createState() => _LabFormPageState();
}

class _LabFormPageState extends State<LabFormPage> {
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController certController = TextEditingController();

  final InputDecoration textFieldDecoration = const InputDecoration(
    filled: true,
    fillColor: Colors.white,
    contentPadding: EdgeInsets.all(16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide.none,
    ),
  );

  void handleCreate() {
    // About and Certificate are optional, so no validation needed
    Navigator.pushNamed(context, '/labSuccess');
  }

  @override
  void dispose() {
    aboutController.dispose();
    certController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBF4F6),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('About', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: aboutController,
              maxLines: 3,
              decoration: textFieldDecoration.copyWith(
                hintText: 'Add description about the lab (optional)',
              ),
            ),
            const SizedBox(height: 20),
            const Text('Certificates', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: certController,
              maxLines: 2,
              decoration: textFieldDecoration.copyWith(
                hintText: 'Add description about certificates (optional)',
              ),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: handleCreate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF071952),
                  padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 2,
                ),
                child: const Text(
                  'Create',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
