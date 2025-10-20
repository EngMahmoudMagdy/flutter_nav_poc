import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nav_poc/widgets/bread_crumb_app_bar.dart';

@RoutePage()
class IndependentPage extends StatelessWidget {
  const IndependentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BreadcrumbAppBar(title: Text('Independent page')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Independent page',
              style: TextStyle(color: Colors.teal, fontSize: 22),
            ),
          ),
        ],
      ),
    );
  }
}
