// pages/root_layout.dart
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:nav_poc/app_drawer.dart';
import 'package:nav_poc/nav_service.dart';
import 'package:nav_poc/route/app_router.dart';

@RoutePage()
class RootLayoutPage extends StatefulWidget {
  const RootLayoutPage({super.key});

  @override
  State<RootLayoutPage> createState() => _RootLayoutPageState();
}

class _RootLayoutPageState extends State<RootLayoutPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      NavService().setRouter(
        context.innerRouterOf<StackRouter>(RootLayoutRoute.name) ??
            context.router,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          // Persistent drawer on the left
          Flexible(child: const AppDrawer()),

          // Vertical divider
          Container(width: 1, color: Colors.grey.shade300),

          // Content area on the right
          Expanded(
            flex: 3,
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
