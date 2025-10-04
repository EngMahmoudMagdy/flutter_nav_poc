import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MainCat2Page extends StatelessWidget {
  const MainCat2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AutoRouter(),
      appBar: AppBar(title: Text('Main Cat 2 page')),
    );
  }
}
