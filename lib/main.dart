import 'package:flutter/material.dart';

// Screens for institute features
import 'add_institute1.dart';
import 'add_institute2.dart';
import 'add_institute3.dart';
import 'add_institute4.dart';
import 'institute1.dart';
import 'institute2.dart';
import 'institute3.dart';
import 'institute4.dart';
import 'institute5.dart'; // Delete confirmation popup

// Screens for labs
import 'add_lab1.dart';
import 'add_lab2.dart';
import 'add_lab3.dart';
import 'add_lab4.dart';
import 'lab1.dart';
import 'lab2.dart';
import 'lab3.dart';
import 'lab4.dart';
import 'lab5.dart'; // Delete confirmation popup

// Screens for complaints
import 'complaints1.dart';
import 'complaints2.dart';

// Other
import 'categories.dart';

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
        scaffoldBackgroundColor: const Color(0xFFEBF4F6),
        fontFamily: 'Arial',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 1,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      initialRoute: '/instituteDeleteConfirm',
      routes: {
        // Categories / Dashboard
        '/chooseCategory': (context) => const ChooseCategoryPage(),

        // Institute flow
        '/addInstitute': (context) => const AddInstitutePage(),
        '/instituteForm': (context) => const InstituteFormPage(),
        '/success': (context) => const InstituteCreatedScreen(),
        '/fail': (context) => const AddInstituteFailedScreen(),

        // Lab flow
        '/addLab': (context) => const AddLabPage(),
        '/labForm': (context) => const LabFormPage(),
        '/labSuccess': (context) => const LabCreatedScreen(),
        '/labFail': (context) => const AddLabFailedScreen(),

        // Complaints
        '/complaints': (context) => const ComplaintsScreen(),
        '/notifySuccess': (context) => const NotifySuccessScreen(),

        // Institute management
        '/instituteList': (context) => const InstituteListPage(),
        '/instituteProfile': (context) => const InstituteProfilePage(),
        '/instituteUpdated': (context) => const InstituteUpdatedScreen(),
        '/instituteDeleted': (context) => const InstituteDeletedScreen(),
        '/instituteDeleteConfirm': (context) => const InstituteDeletePopup(),

        // Lab management
        '/labList': (context) => const LabListPage(),
        '/labProfile': (context) => const LabProfilePage(),
        '/labUpdated': (context) => const LabUpdatedScreen(),
        '/labDeleted': (context) => const LabDeletedScreen(),
        '/labDeleteConfirm': (context) => const LabDeletePopup(),
      },
    );
  }
}
