import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MainCat1Page extends StatelessWidget {
  const MainCat1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop) {
            // Pop was attempted but blocked
            _showExitWarning(context);
          }
        },
        child: AutoRouter(),
      ),
      appBar: AppBar(title: Text('Main Cat 1 page')),
    );
  }
  void _showExitWarning(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Cannot Exit'),
        content: Text('You cannot leave this page yet.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
