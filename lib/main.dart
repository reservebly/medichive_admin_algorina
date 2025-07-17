// main.dart
import 'package:flutter/material.dart';

// Institute files...
import 'institute1.dart' as inst1;
import 'institute2.dart' as inst2;
import 'institute3.dart' as inst3;
import 'institute4.dart' as inst4;
import 'institute5.dart' as inst5;

// Lab files
import 'lab1.dart';
import 'lab2.dart';
import 'lab3.dart';
import 'lab4.dart';
import 'lab5.dart'; // popup

// Add lab/institute & complaints
import 'add_lab1.dart';
import 'add_lab2.dart';
import 'add_lab3.dart';
import 'add_lab4.dart';
import 'add_institute1.dart';
import 'add_institute2.dart';
import 'add_institute3.dart';
import 'add_institute4.dart';
import 'complaints1.dart';
import 'complaints2.dart';

// Categories
import 'categories.dart';

// New imports
import 'medichive_main.dart';
import 'select_role.dart';

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
      initialRoute:  '/',
      routes: {
        '/': (context) => const MedichiveMainScreen(),
        '/selectRole': (context) => const SelectRoleScreen(),
        '/chooseCategory': (context) => const ChooseCategoryPage(),

        // Institute
        '/addInstitute': (context) => const AddInstitutePage(),
        '/instituteForm': (context) => const InstituteFormPage(),
        '/success': (context) => const InstituteCreatedScreen(),
        '/fail': (context) => const AddInstituteFailedScreen(),
        '/instituteList': (context) => const inst1.InstituteListPage(),
        '/instituteProfile': (context) => const inst2.InstituteProfilePage(),
        '/instituteUpdated': (context) => const inst3.InstituteUpdatedScreen(),
        '/instituteDeleted': (context) => const inst4.InstituteDeletedScreen(),
        '/instituteDeleteConfirm': (context) => const inst5.InstituteDeletePopup(),

        // Lab
        '/addLab': (context) => const AddLabPage(),
        '/labForm': (context) => const LabFormPage(),
        '/labSuccess': (context) => const LabCreatedScreen(),
        '/labFail': (context) => const AddLabFailedScreen(),
        '/labList': (context) => const LabListPage(),
        '/labProfile': (context) => const LabProfilePage(),
        '/labUpdated': (context) => const LabUpdatedScreen(),
        '/labDeleted': (context) => const LabDeletedScreen(),
        '/labDeleteConfirm': (context) => const LabDeletePopup(),

        // Complaints
        '/complaints': (context) => const ComplaintsScreen(),
        '/notifySuccess': (context) => const NotifySuccessScreen(),
      },
    );
  }
}
