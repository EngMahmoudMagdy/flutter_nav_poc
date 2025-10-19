import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nav_poc/nav_service.dart';
import 'package:nav_poc/route/app_router.dart';

@RoutePage()
class Main2ContentPage extends StatelessWidget {
  const Main2ContentPage({super.key});

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
                'Main 2 Content page',
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
          ],
        ),
      ),
    );
  }
}
