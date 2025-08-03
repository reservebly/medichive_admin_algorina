import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  static const String baseUrl = 'http://10.74.27.42:3000';

  int instituteCount = 0;
  int labCount = 0;
  String? recentComplaint;
  String? complaintSource;

  bool isLoading = true;
  String? errorMessage;

  final Color primaryColor = const Color(0xFF071952);
  final Color bgColor = const Color(0xFFEBF4F6);

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final responses = await Future.wait([
        http.get(Uri.parse('$baseUrl/institute')),
        http.get(Uri.parse('$baseUrl/lab')),
        http.get(Uri.parse('$baseUrl/complaint')),
      ]);

      final instituteRes = responses[0];
      final labRes = responses[1];
      final complaintRes = responses[2];

      if (instituteRes.statusCode == 200 &&
          labRes.statusCode == 200 &&
          complaintRes.statusCode == 200) {
        final instituteData = jsonDecode(instituteRes.body);
        final labData = jsonDecode(labRes.body);
        final complaints = jsonDecode(complaintRes.body);

        setState(() {
          instituteCount = instituteData.length;
          labCount = labData.length;

          if (complaints.isNotEmpty) {
            final latest = complaints.last;
            recentComplaint = latest['complain'] ?? 'No complaint detail';
            complaintSource = latest['source'] ?? 'Unknown source';
          } else {
            recentComplaint = 'No recent complaint';
            complaintSource = '';
          }

          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage =
              'Error: institute ${instituteRes.statusCode}, lab ${labRes.statusCode}, complaint ${complaintRes.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load data: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text('System Analytics'),
        backgroundColor: primaryColor,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: _fetchData,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: isLoading
              ? const CircularProgressIndicator()
              : errorMessage != null
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(errorMessage!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.red)),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: _fetchData,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                          ),
                          child: const Text('Retry'),
                        )
                      ],
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              final isWide = constraints.maxWidth > 600;
                              return GridView.count(
                                crossAxisCount: isWide ? 2 : 1,
                                mainAxisSpacing: 20,
                                crossAxisSpacing: 20,
                                childAspectRatio: isWide ? 2.8 : 2.2,
                                shrinkWrap: true,
                                children: [
                                  _StatCard(
                                    title: 'Total Institutes',
                                    value: instituteCount.toString(),
                                    icon: Icons.account_balance,
                                    color: primaryColor,
                                  ),
                                  _StatCard(
                                    title: 'Total Labs',
                                    value: labCount.toString(),
                                    icon: Icons.biotech,
                                    color: Colors.orange,
                                  ),
                                  if (recentComplaint != null)
                                    _ComplaintCard(
                                      complaint: recentComplaint!,
                                      source: complaintSource ?? '',
                                      primaryColor: primaryColor,
                                    ),
                                ],
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

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white, // Match white background
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      shadowColor: Colors.black12,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: color.withOpacity(0.15),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ComplaintCard extends StatelessWidget {
  final String complaint;
  final String source;
  final Color primaryColor;

  const _ComplaintCard({
    required this.complaint,
    required this.source,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent Complaint',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 17,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              complaint,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 10),
            Text(
              'Source: $source',
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/complaints');
                },
                icon:
                    Icon(Icons.list_alt_outlined, color: primaryColor, size: 18),
                label: Text(
                  'View All',
                  style: TextStyle(color: primaryColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
