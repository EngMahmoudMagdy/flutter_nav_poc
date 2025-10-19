import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nav_poc/widgets/bread_crumb_app_bar.dart';

@RoutePage()
class MainCat2Page extends StatelessWidget {
  const MainCat2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AutoRouter(),
      appBar: BreadcrumbAppBar(
        title: Text('Main Cat 2 page'),
      ),
    );
  }
}
