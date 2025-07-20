import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LabsListPage extends StatefulWidget {
  const LabsListPage({super.key});

  @override
  State<LabsListPage> createState() => _LabsListPageState();
}

class _LabsListPageState extends State<LabsListPage> {
  late Future<List<Lab>> labs;

  @override
  void initState() {
    super.initState();
    labs = fetchLabs();
  }

  Future<List<Lab>> fetchLabs() async {
    final response = await http.get(
  Uri.parse('http://10.10.3.132:3000/labs'), // ✅ Your correct IP
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Lab.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load labs');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Labs List'),
        backgroundColor: Colors.blue[900],
      ),
      body: FutureBuilder<List<Lab>>(
        future: labs,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No labs found.'));
          } else {
            final labList = snapshot.data!;
            return ListView.builder(
              itemCount: labList.length,
              itemBuilder: (context, index) {
                final lab = labList[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  elevation: 3,
                  child: ListTile(
                    title: Text(
                      lab.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Reg No: ${lab.registrationNumber}\nEmail: ${lab.email}',
                    ),
                    isThreeLine: true,
                    trailing: Icon(
                      Icons.medical_services,
                      color: Colors.blue[800],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class Lab {
  final int id;
  final String name;
  final String registrationNumber;
  final String telephoneNumber;
  final String email;
  final String address;
  final String website;
  final String about;
  final String certificate;

  Lab({
    required this.id,
    required this.name,
    required this.registrationNumber,
    required this.telephoneNumber,
    required this.email,
    required this.address,
    required this.website,
    required this.about,
    required this.certificate,
  });

  factory Lab.fromJson(Map<String, dynamic> json) {
    return Lab(
      id: json['id'],
      name: json['name'],
      registrationNumber: json['registrationNumber'],
      telephoneNumber: json['telephoneNumber'],
      email: json['email'],
      address: json['address'],
      website: json['website'],
      about: json['about'],
      certificate: json['certificate'],
    );
  }
}
