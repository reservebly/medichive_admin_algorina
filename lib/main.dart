import 'package:flutter/material.dart';
import 'add_institute.dart';
import 'add_lab.dart'; // New import
import 'institute_form.dart';
import 'package:medichive_admin_algorina/category_card.dart';
import 'successful_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Institute App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFEFF6F9),
        fontFamily: 'Arial',
      ),
      initialRoute: '/addLab',
      routes: {
        '/chooseCategory': (context) => const ChooseCategoryPage(),
        '/addInstitute': (context) => const AddInstitutePage(),
        '/addLab': (context) => const AddLabPage(), // New route
        '/instituteForm': (context) => InstituteFormPage(),
        '/success': (context) => const SuccessScreen(),
      },
    );
  }
}