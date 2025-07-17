import 'package:flutter/material.dart';
import 'institute5.dart'; // import popup from separate file

class InstituteListPage extends StatelessWidget {
  const InstituteListPage({super.key});

  final List<Map<String, String>> institutes = const [
    {"name": "Asiri Institute", "location": "Kandy"},
    {"name": "Channel Center", "location": "Colombo"},
    {"name": "Suwasewana Institute", "location": "Kandy"},
    {"name": "Healthcare Institute", "location": "Colombo"},
    {"name": "Nawaloka Institute", "location": "Kandy"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBF4F6),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back button and title
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 48, 8, 8),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Color(0xFF071952), size: 28),
                  onPressed: () {
                    Navigator.pop(context); // Go back to previous page (Categories)
                  },
                ),
                const SizedBox(width: 8),
                const Text(
                  "INSTITUTES",
                  style: TextStyle(
                    color: Color(0xFF071952),
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),

          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                hintText: 'Search',
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Institute List
          Expanded(
            child: ListView.builder(
              itemCount: institutes.length,
              itemBuilder: (context, index) {
                final institute = institutes[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 6,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      title: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/instituteProfile');
                        },
                        child: Text(
                          institute["name"]!,
                          style: const TextStyle(
                            color: Color(0xFF071952),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      subtitle: Text(
                        institute["location"]!,
                        style: const TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      trailing: SizedBox(
                        width: 180,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => const InstituteDeletePopup(),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text("Delete", style: TextStyle(color: Colors.white)),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/instituteProfile');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text("Update", style: TextStyle(color: Colors.white)),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
                          ],
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
