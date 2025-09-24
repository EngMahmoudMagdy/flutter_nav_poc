import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nav_poc/master_details_page.dart';

@RoutePage()
class MainCat1Page extends StatelessWidget {
  const MainCat1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return MasterDetailScaffold(
      body: Container(
        color: Colors.white.withAlpha(100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Main Cat 1 page',
                style: TextStyle(color: Colors.green, fontSize: 22),
              ),
            ),
          ],
        ),
      ), title: 'Main Cat 1 page',
    );
  }
}
