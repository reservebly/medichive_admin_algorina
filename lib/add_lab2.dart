import 'package:flutter/material.dart';

class LabFormPage extends StatefulWidget {
  const LabFormPage({super.key});

  @override
  State<LabFormPage> createState() => _LabFormPageState();
}

class _LabFormPageState extends State<LabFormPage> {
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController certController = TextEditingController();

  static const darkBlue = Color(0xFF071952);

  final InputDecoration textFieldDecoration = const InputDecoration(
    filled: true,
    fillColor: Color(0xFFF7F9FC),
    contentPadding: EdgeInsets.all(16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide.none,
    ),
  );

  void handleCreate() {
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
      backgroundColor: const Color(0xFFF4F7FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: darkBlue, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title "LAB FORM" removed from here

              const SizedBox(height: 32),

              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'About the Lab',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: darkBlue,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: aboutController,
                      maxLines: 4,
                      decoration: textFieldDecoration.copyWith(
                        hintText: 'Add description about the lab (optional)',
                        hintStyle: TextStyle(color: darkBlue.withOpacity(0.5)),
                      ),
                    ),

                    const SizedBox(height: 28),

                    const Text(
                      'Certificates',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: darkBlue,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: certController,
                      maxLines: 3,
                      decoration: textFieldDecoration.copyWith(
                        hintText: 'Add details about lab certificates (optional)',
                        hintStyle: TextStyle(color: darkBlue.withOpacity(0.5)),
                      ),
                    ),

                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: handleCreate,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: darkBlue,
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text(
                          'SUBMIT',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
