import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:nav_poc/route/app_router.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Navigation POC',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          _buildSectionHeader(context, 'Main Category 1'),
          _buildDrawerItem(
            context,
            'Main Cat1 - Home',
            Icons.home,
                () => context.router.push(const MainCat1Route()),
          ),
          _buildDrawerItem(
            context,
            'Sub Cat1.1',
            Icons.arrow_forward_ios,
                () => context.router.push(const Main1SubCat1Route()),
            indent: 16.0,
          ),
          _buildDrawerItem(
            context,
            'Sub Cat1.2',
            Icons.arrow_forward_ios,
                () => context.router.push(const Main1SubCat2Route()),
            indent: 16.0,
          ),

          _buildSectionHeader(context, 'Main Category 2'),
          _buildDrawerItem(
            context,
            'Main Cat2 - Home',
            Icons.business,
                () => context.router.push(const MainCat2Route()),
          ),
          _buildDrawerItem(
            context,
            'Sub Cat2.1',
            Icons.arrow_forward_ios,
                () => context.router.push(const Main2SubCat1Route()),
            indent: 16.0,
          ),
          _buildDrawerItem(
            context,
            'Sub Cat2.2',
            Icons.arrow_forward_ios,
                () => context.router.push(const Main2SubCat2Route()),
            indent: 16.0,
          ),

          _buildSectionHeader(context, 'Main Category 3'),
          _buildDrawerItem(
            context,
            'Main Cat3',
            Icons.category,
                () => context.router.push(const MainCat3Route()),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.blue.shade700,
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
        leading: Icon(icon, size: 20),
        title: Text(title),
        onTap: () {
          Navigator.pop(context); // Close drawer
          onTap();
        },
      ),
    );
  }
}