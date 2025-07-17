import 'package:flutter/material.dart';
import 'lab5.dart'; // Import popup

class LabListPage extends StatelessWidget {
  const LabListPage({super.key});

  final List<Map<String, String>> labs = const [
    {"name": "Sethma Lab", "location": "Kandy"},
    {"name": "Hemas Diagnostic", "location": "Colombo"},
    {"name": "Lanka Lab", "location": "Galle"},
    {"name": "CarePoint Lab", "location": "Matara"},
    {"name": "MediScan", "location": "Negombo"},
    {"name": "Wellness Lab", "location": "Colombo"},
    {"name": "Alpha Lab", "location": "Jaffna"},
    {"name": "Prime Lab", "location": "Kurunegala"},
    {"name": "Omega Diagnostics", "location": "Anuradhapura"},
  ];

  @override
  Widget build(BuildContext context) {
    const int crossAxisCount = 3; // 3 boxes per row
    const double spacing = 32;    // spacing between boxes

    return Scaffold(
      backgroundColor: const Color(0xFFEBF4F6),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(spacing),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,  // align title left
            children: [
              // Title aligned left
              Text(
                'LABS',
                style: const TextStyle(
                  color: Color(0xFF071952),
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                ),
              ),

              const SizedBox(height: 20),

              // Search bar
              TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  hintText: 'Search labs',
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Grid of Labs (3 per row)
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    double totalSpacing = (crossAxisCount - 1) * spacing;
                    double itemWidth = (constraints.maxWidth - totalSpacing) / crossAxisCount;
                    double itemHeight = 110; // smaller height for smaller boxes

                    return GridView.builder(
                      physics: const NeverScrollableScrollPhysics(), // no scrolling
                      itemCount: labs.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        mainAxisSpacing: spacing,
                        crossAxisSpacing: spacing,
                        childAspectRatio: itemWidth / itemHeight,
                      ),
                      itemBuilder: (context, index) {
                        final lab = labs[index];
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: const Color(0xFF071952).withOpacity(0.15), width: 1.2),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Wrap lab name with GestureDetector to navigate on tap
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/labProfile');
                                },
                                child: Text(
                                  lab["name"]!.toUpperCase(),
                                  style: const TextStyle(
                                    color: Color(0xFF071952),
                                    fontWeight: FontWeight.w800,
                                    fontSize: 14,
                                    letterSpacing: 1,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                lab["location"]!,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacer(),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => const LabDeletePopup(),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      textStyle: const TextStyle(fontSize: 11),
                                    ),
                                    child: const Text("Delete", style: TextStyle(color: Colors.white)),
                                  ),
                                  const SizedBox(width: 6),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/labProfile');
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      textStyle: const TextStyle(fontSize: 11),
                                    ),
                                    child: const Text("Update", style: TextStyle(color: Colors.white)),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
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
