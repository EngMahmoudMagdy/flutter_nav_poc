import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nav_poc/route/app_router.dart';

@RoutePage()
class Main2SubCat2Page extends StatelessWidget {
  const Main2SubCat2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red.withAlpha(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Main 2 Sub Cat 2 page',
              style: TextStyle(color: Colors.teal, fontSize: 22),
            ),
          ),
          SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              context.router.push(VacationRequestRoute());
            },
            child: Text(
              'Go to\nVacation Request page',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
