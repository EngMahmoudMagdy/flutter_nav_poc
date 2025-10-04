// pages/root_layout.dart
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:nav_poc/app_drawer.dart';

@RoutePage()
class RootLayoutPage extends StatelessWidget {
  const RootLayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          // Persistent drawer on the left
          Flexible(child: const AppDrawer()),

          // Vertical divider
          Container(
            width: 1,
            color: Colors.grey.shade300,
          ),

          // Content area on the right
          Expanded(
            child: Container(
              color: Colors.grey.shade50,
              child: const AutoRouter(), // This will show the current page
            ),
          ),
        ],
      ),
    );
  }
}