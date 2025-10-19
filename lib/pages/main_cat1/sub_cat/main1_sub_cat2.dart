import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nav_poc/widgets/bread_crumb_app_bar.dart';

@RoutePage()
class Main1SubCat2Page extends StatelessWidget {
  const Main1SubCat2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
      appBar: BreadcrumbAppBar(
        title: Text('Cat 2'),
        backgroundColor: Colors.green,
      ),
    );
  }
}
