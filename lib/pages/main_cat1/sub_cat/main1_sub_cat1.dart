import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nav_poc/nav_service.dart';
import 'package:nav_poc/route/app_router.dart';

@RoutePage()
class Main1SubCat1Page extends StatelessWidget {
  const Main1SubCat1Page({super.key});

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
                'Main 1 Sub Cat 1 page',
                style: TextStyle(color: Colors.black, fontSize: 22),
              ),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                NavService().navigateToIndependent(
                  route: IndependentRoute(),
                );
              },
              child: Text(
                'Go to\nIndependent page',
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                NavService().navigateToIndependent(
                  route: VacationRequestRoute(),
                );
              },
              child: Text(
                'Go to\nVacation Request page',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(title: Text('Cat 1'), backgroundColor: Colors.brown),
    );
  }
}
