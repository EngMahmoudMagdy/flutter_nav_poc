import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class Main2SubCat1Page extends StatelessWidget {
  const Main2SubCat1Page({super.key});

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
              'Main 2 Sub Cat 1 page',
              style: TextStyle(color: Colors.teal, fontSize: 22),
            ),
          ),
        ],
      ),
    );
  }
}
