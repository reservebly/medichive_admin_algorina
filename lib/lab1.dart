import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Lab {
  final String id; // Updated: String instead of int
  final String name;
  final String address;

  Lab({required this.id, required this.name, required this.address});

  factory Lab.fromJson(Map<String, dynamic> json) {
    return Lab(
      id: json['id'],
      name: json['name'],
      address: json['address'] ?? 'No address',
    );
  }
}

class LabListPage extends StatefulWidget {
  const LabListPage({super.key});

  @override
  State<LabListPage> createState() => _LabListPageState();
}

class _LabListPageState extends State<LabListPage> {
  List<Lab> labs = [];
  String searchQuery = '';
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    fetchLabs();
  }

  Future<void> fetchLabs() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final response = await http.get(Uri.parse('http://10.10.3.132:3000/lab'));
      if (response.statusCode == 200) {
        final List<dynamic> labsJson = jsonDecode(response.body);
        setState(() {
          labs = labsJson.map((json) => Lab.fromJson(json)).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          error = 'Server error: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        error = 'Failed to load labs: $e';
      });
    }
  }

  List<Lab> get filteredLabs {
    if (searchQuery.isEmpty) return labs;
    return labs.where((lab) {
      final lowerQuery = searchQuery.toLowerCase();
      return lab.name.toLowerCase().contains(lowerQuery) ||
          lab.address.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  Future<void> deleteLab(String id) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Confirm Deletion'),
            content: const Text('Are you sure you want to delete this lab?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text(
                  'Confirm',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );

    if (confirmed == true) {
      final response = await http.delete(
        Uri.parse('http://10.10.3.132:3000/labs/$id'),
      );
      if (response.statusCode == 200) {
        fetchLabs();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Lab deleted successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to delete lab. Status: ${response.statusCode}',
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBF4F6),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'LABS',
                style: TextStyle(
                  color: Color(0xFF071952),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                onChanged: (value) => setState(() => searchQuery = value),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search labs',
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child:
                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : error != null
                        ? Center(child: Text(error!))
                        : ListView.builder(
                          itemCount: filteredLabs.length,
                          itemBuilder: (context, index) {
                            final lab = filteredLabs[index];
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 4,
                              ),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              child: ListTile(
                                title: Text(
                                  lab.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(lab.address),
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () => deleteLab(lab.id),
                                ),
                              ),
                            );
                          },
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
