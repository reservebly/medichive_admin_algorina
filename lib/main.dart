import 'package:flutter/material.dart';
import 'add_institute.dart';
import 'add_lab.dart';
import 'institute_form.dart';
import 'package:medichive_admin_algorina/category_card.dart';
import 'successful_screen.dart';
import 'complaint_item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hospital Management System',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFEFF6F9),
        fontFamily: 'Arial',
        cardTheme: CardTheme(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      initialRoute: '/complaints',
      routes: {
      
        '/chooseCategory': (context) => const ChooseCategoryPage(),
        '/addInstitute': (context) => const AddInstitutePage(),
        '/addLab': (context) => const AddLabPage(),
        '/instituteForm': (context) => InstituteFormPage(),
        '/success': (context) => const SuccessScreen(),
        '/complaints': (context) => const ComplaintsScreen(),
      },
    );
  }
}

class ComplaintsScreen extends StatelessWidget {
  const ComplaintsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Completing and Support'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(bottom: 20),
        itemCount: 1,
        itemBuilder: (context, index) => const ComplaintItem(
          hospitalName: 'Adali hospital',
          complaintText: 'Lorem ipsum faci isoem the industry\'s standard dummy text ever since the',
        ),
      ),
    );
  }
}