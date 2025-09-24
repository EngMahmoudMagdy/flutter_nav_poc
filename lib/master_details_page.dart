import 'package:flutter/material.dart';
import 'app_drawer.dart';

class MasterDetailScaffold extends StatefulWidget {
  final String title;
  final Widget body;

  const MasterDetailScaffold({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  State<MasterDetailScaffold> createState() => _MasterDetailScaffoldState();
}

class _MasterDetailScaffoldState extends State<MasterDetailScaffold> {
  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      appBar: isLargeScreen ? null : AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      body: isLargeScreen ? _buildDesktopLayout(context) : _buildMobileLayout(context),
      drawer: isLargeScreen ? null : const AppDrawer(),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      children: [
        // Drawer as permanent sidebar
        Container(
          width: 280,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            border: Border(right: BorderSide(color: Colors.grey.shade300)),
          ),
          child: const AppDrawer(),
        ),
        // Main content area
        Expanded(
          child: Column(
            children: [
              // App bar for desktop
              Container(
                height: 64,
                color: Colors.blue,
                child: Center(
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              // Content - Use AutoRouter to handle the current page
              Expanded(
                child: widget.body,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return widget.body;
  }
}