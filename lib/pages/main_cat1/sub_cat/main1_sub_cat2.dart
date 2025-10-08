import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class Main1SubCat2Page extends StatelessWidget {
  const Main1SubCat2Page({super.key});

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
        child: Container(
          color: Colors.amber.withAlpha(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'Main 1 Sub Cat 2 page',
                  style: TextStyle(color: Colors.deepPurple, fontSize: 22),
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(title: Text('Cat 2')),
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
