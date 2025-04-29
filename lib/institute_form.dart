import 'package:flutter/material.dart';

class InstituteFormPage extends StatelessWidget {
  const InstituteFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textFieldDecoration = InputDecoration(
      hintText: 'Add description about the institute',
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.all(16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('About', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            TextField(
              maxLines: 3,
              decoration: textFieldDecoration.copyWith(
                hintText: 'Add description about the institute',
              ),
            ),
            SizedBox(height: 20),
            Text('Certificates', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            TextField(
              maxLines: 2,
              decoration: textFieldDecoration.copyWith(
                hintText: 'Add description about certificates',
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.upload, color: Colors.white),
                label: Text('Upload'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF001B54),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 4,
                ),
              ),
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Create'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF001B54),
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
