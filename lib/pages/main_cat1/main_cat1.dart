import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MainCat1Page extends StatelessWidget {
  const MainCat1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AutoRouter(),
      appBar: AppBar(title: Text('Main Cat 1 page')),
    );
  }
}
