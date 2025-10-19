import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nav_poc/widgets/bread_crumb_app_bar.dart';

@RoutePage()
class MainCat3Page extends StatelessWidget {
  const MainCat3Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BreadcrumbAppBar(title: Text('Main Cat 3 page')),
      body: Container(
        color: Colors.blue.withAlpha(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Main Cat 3 page',
                style: TextStyle(color: Colors.blue, fontSize: 22),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
