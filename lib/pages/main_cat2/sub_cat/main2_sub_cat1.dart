import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nav_poc/widgets/bread_crumb_app_bar.dart';

@RoutePage()
class Main2SubCat1Page extends StatelessWidget {
  const Main2SubCat1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BreadcrumbAppBar(
        title: Text('Main 2 Cat 1'),
        backgroundColor: Colors.orange,
      ),
      body: Container(
        color: Colors.red.withAlpha(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Main 2 Sub Cat 1 page',
                style: TextStyle(color: Colors.teal, fontSize: 22),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
