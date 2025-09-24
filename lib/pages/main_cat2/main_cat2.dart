import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nav_poc/master_details_page.dart';

@RoutePage()
class MainCat2Page extends StatelessWidget {
  const MainCat2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return MasterDetailScaffold(
      body: Container(
        color: Colors.red.withAlpha(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Main Cat 2 page',
                style: TextStyle(color: Colors.brown, fontSize: 22),
              ),
            ),
          ],
        ),
      ),
      title: 'Main Cat 2 page',
    );
  }
}
