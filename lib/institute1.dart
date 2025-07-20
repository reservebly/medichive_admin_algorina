import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'institute2.dart';

class InstituteListPage extends StatefulWidget {
  const InstituteListPage({super.key});

  @override
  State<InstituteListPage> createState() => _InstituteListPageState();
}

class _InstituteListPageState extends State<InstituteListPage> {
  List<dynamic> institutes = [];
  List<dynamic> filteredInstitutes = [];

  @override
  void initState() {
    super.initState();
    fetchInstitutes();
  }

  Future<void> fetchInstitutes() async {
    final url = Uri.parse('http://10.10.3.132:3000/institute');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        institutes = json.decode(response.body);
        filteredInstitutes = institutes;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load institutes')),
      );
    }
  }

  Future<void> deleteInstitute(String id) async {
    final url = Uri.parse('http://10.10.3.132:3000/institute/$id');
    final response = await http.delete(url);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Institute deleted successfully')),
      );
      fetchInstitutes();
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to delete')));
    }
  }

  void search(String query) {
    setState(() {
      filteredInstitutes =
          institutes.where((institute) {
            final name = institute['name']?.toString().toLowerCase() ?? '';
            return name.contains(query.toLowerCase());
          }).toList();
    });
  }

  Future<void> fetchAndNavigateToInstitute(String id) async {
    final url = Uri.parse('http://10.10.3.132:3000/institute/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final instituteDetails = json.decode(response.body);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => InstituteProfilePage(instituteData: instituteDetails),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load institute details')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBF4F6),
      appBar: AppBar(
        title: const Text('Institutes'),
        backgroundColor: const Color(0xFF071952),
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: search,
              decoration: InputDecoration(
                hintText: 'Search Institutes',
                prefixIcon: const Icon(Icons.search),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredInstitutes.length,
              itemBuilder: (context, index) {
                final institute = filteredInstitutes[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 4),
                      ],
                    ),
                    child: ListTile(
                      title: Text(
                        institute['name'] ?? 'No Name',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(institute['address'] ?? 'No Address'),
                      onTap: () => fetchAndNavigateToInstitute(institute['id']),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed:
                            () => showDialog(
                              context: context,
                              builder:
                                  (_) => AlertDialog(
                                    title: const Text('Confirm Deletion'),
                                    content: const Text(
                                      'Are you sure you want to delete this institute?',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          deleteInstitute(institute['id']);
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'Confirm',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  ),
                            ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
