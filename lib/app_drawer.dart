import 'package:flutter/material.dart';
import 'package:nav_poc/nav_service.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drawer header
            Container(
              height: 120,
              decoration: BoxDecoration(color: Colors.blue.shade700),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Navigation POC',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Master-Detail Layout',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            ListView(
              shrinkWrap: true,
              children: [
                _buildSectionHeader('Main Category 1'),
                _buildDrawerItem(
                  context,
                  'Main Cat1 - Home',
                  Icons.home,
                  () => _navigateToMainCategory(MainCategory.category1),
                ),
                _buildDrawerItem(
                  context,
                  'Sub Cat1.1',
                  Icons.arrow_forward_ios,
                  () => _navigateToSubCategory(SubCategory.sub1Main1),
                  indent: 16.0,
                ),
                _buildDrawerItem(
                  context,
                  'Sub Cat1.2',
                  Icons.arrow_forward_ios,
                  () => _navigateToSubCategory(SubCategory.sub2Main1),
                  indent: 16.0,
                ),
                _buildDrawerItem(
                  context,
                  'Sub Cat1.3',
                  Icons.arrow_forward_ios,
                  () => _navigateToSubCategory(SubCategory.sub3Main1),
                  indent: 16.0,
                ),
                _buildSectionHeader('Main Category 2'),
                _buildDrawerItem(
                  context,
                  'Main Cat2 - Home',
                  Icons.business,
                  () => _navigateToMainCategory(MainCategory.category2),
                ),
                _buildDrawerItem(
                  context,
                  'Sub Cat2.1',
                  Icons.arrow_forward_ios,
                  () => _navigateToSubCategory(SubCategory.sub1Main2),
                  indent: 16.0,
                ),
                _buildDrawerItem(
                  context,
                  'Sub Cat2.2',
                  Icons.arrow_forward_ios,
                  () => _navigateToSubCategory(SubCategory.sub2Main2),
                  indent: 16.0,
                ),

                _buildSectionHeader('Main Category 3'),
                _buildDrawerItem(
                  context,
                  'Main Cat3',
                  Icons.category,
                  () => _navigateToMainCategory(MainCategory.category3),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Or use replace to change the main content:
  void _navigateToMainCategory(MainCategory mainCategory) {
    NavService().navigateToMainCategory(
      context: context,
      mainCategory: mainCategory,
    );
  }

  void _navigateToSubCategory(SubCategory subCategory) {
    NavService().navigateToSubcategory(
      context: context,
      subCategory: subCategory,
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.blue,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap, {
    double indent = 0.0,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: indent),
      child: ListTile(
        leading: Icon(icon, size: 20, color: Colors.grey.shade700),
        title: Text(
          title,
          style: TextStyle(color: Colors.grey.shade800, fontSize: 14),
        ),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        minLeadingWidth: 24,
      ),
    );
  }
}
