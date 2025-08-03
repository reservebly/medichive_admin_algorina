import 'package:flutter/material.dart';

class InstituteFormPage extends StatefulWidget {
  const InstituteFormPage({Key? key}) : super(key: key);

  @override
  State<InstituteFormPage> createState() => _InstituteFormPageState();
}

class _InstituteFormPageState extends State<InstituteFormPage> {
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController certController = TextEditingController();

  void handleCreate() {
    Navigator.pushNamed(context, '/success');
  }

  @override
  void dispose() {
    aboutController.dispose();
    certController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const darkBlue = Color(0xFF071952);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              IconButton(
                icon: const Icon(Icons.arrow_back, color: darkBlue, size: 28),
                onPressed: () => Navigator.pop(context),
                splashRadius: 24,
              ),

              const SizedBox(height: 24),

              
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
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
                      'About',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: darkBlue,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildMultilineField(
                      hintText: 'Add description about the institute (optional)',
                      controller: aboutController,
                      darkBlue: darkBlue,
                      maxLines: 4,
                    ),

                    const SizedBox(height: 32),

                    const Text(
                      'Certificates',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: darkBlue,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildMultilineField(
                      hintText: 'Add description about certificates',
                      controller: certController,
                      darkBlue: darkBlue,
                      maxLines: 3,
                    ),

                    const SizedBox(height: 48),

                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: handleCreate,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: darkBlue,
                          elevation: 6,
                          shadowColor: darkBlue.withOpacity(0.6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text(
                          'Create',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                            color: Colors.white,
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

  static Widget _buildMultilineField({
    required String hintText,
    required TextEditingController controller,
    required Color darkBlue,
    int maxLines = 3,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: TextStyle(
        color: darkBlue,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: darkBlue.withOpacity(0.5)),
        filled: true,
        fillColor: const Color(0xFFF7F9FC),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: darkBlue, width: 2),
        ),
      ),
    );
  }
}
