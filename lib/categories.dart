import 'package:flutter/material.dart';

class ChooseCategoryPage extends StatelessWidget {
  const ChooseCategoryPage({super.key});

  static const Color primaryBlue = Color(0xFF1E79BF);
  static const Color darkBlue = Color(0xFF0A2472);
  static const Color lightBlue = Color(0xFFE8F3FF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: primaryBlue,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                const Row(
                  children: [
                    Icon(
                      Icons.admin_panel_settings,
                      color: primaryBlue,
                      size: 32,
                    ),
                    SizedBox(width: 12),
                    Text(
                      "Admin Dashboard",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C3E50),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: primaryBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: primaryBlue.withOpacity(0.2)),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.info_outline, color: primaryBlue, size: 20),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          "Select a category to manage your healthcare services",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF536D7A),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                _buildCategoryButton(
                  context,
                  "Institutes",
                  navigateTo: '/instituteList',
                ),
                const SizedBox(height: 16),
                _buildCategoryButton(context, "Labs", navigateTo: '/labList'),
                const SizedBox(height: 16),
                _buildCategoryButton(
                  context,
                  "Add institute",
                  navigateTo: '/addInstitute',
                ),
                const SizedBox(height: 16),
                _buildCategoryButton(context, "Add lab", navigateTo: '/addLab'),
                const SizedBox(height: 16),
                _buildCategoryButton(
                  context,
                  "Complaints and Support",
                  navigateTo: '/complaints',
                ),
                const SizedBox(height: 16),
                _buildCategoryButton(
                  context,
                  "Analytics Summary",
                  navigateTo: '/analytics',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget _buildCategoryButton(
    BuildContext context,
    String title, {
    String? navigateTo,
  }) {
    IconData getIcon() {
      switch (title.toLowerCase()) {
        case 'institutes':
          return Icons.business_outlined;
        case 'labs':
          return Icons.science_outlined;
        case 'add institute':
          return Icons.add_business_outlined;
        case 'add lab':
          return Icons.add_box_outlined;
        case 'complaints and support':
          return Icons.support_agent_outlined;
        case 'analytics summary':
          return Icons.analytics_outlined;
        default:
          return Icons.arrow_forward_ios;
      }
    }

    return Container(
      width: double.infinity,
      height: 75,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: primaryBlue.withOpacity(0.15),
            offset: const Offset(0, 4),
            blurRadius: 12,
          ),
        ],
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            if (navigateTo != null) {
              Navigator.pushNamed(context, navigateTo);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: primaryBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(getIcon(), color: primaryBlue, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2C3E50),
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: primaryBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: primaryBlue,
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
