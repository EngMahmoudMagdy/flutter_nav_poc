import 'package:auto_route/auto_route.dart';
import 'package:nav_poc/pages/main_cat1/main_cat1.dart';
import 'package:nav_poc/pages/main_cat1/sub_cat/main1_sub_cat1.dart';
import 'package:nav_poc/pages/main_cat1/sub_cat/main1_sub_cat2.dart';
import 'package:nav_poc/pages/main_cat2/main_cat2.dart';
import 'package:nav_poc/pages/main_cat2/sub_cat/main2_sub_cat1.dart';
import 'package:nav_poc/pages/main_cat2/sub_cat/main2_sub_cat2.dart';
import 'package:nav_poc/pages/main_cat3/main_cat3.dart';

part 'app_router.gr.dart';

enum AppRoutes {
  mainCat1,
  main1SubCat1,
  main1SubCat2,
  mainCat2,
  main2SubCat1,
  main2SubCat2,
  mainCat3,
}

extension AppRoutesExtension on AppRoutes {
  String get path {
    switch (this) {
      case AppRoutes.mainCat1:
        return '/mainCat1';
      case AppRoutes.main1SubCat1:
        return 'SubCat1'; // Relative path for nested route
      case AppRoutes.main1SubCat2:
        return 'SubCat2'; // Relative path for nested route
      case AppRoutes.mainCat2:
        return '/mainCat2';
      case AppRoutes.main2SubCat1:
        return 'SubCat1'; // Relative path for nested route
      case AppRoutes.main2SubCat2:
        return 'SubCat2'; // Relative path for nested route
      case AppRoutes.mainCat3:
        return '/mainCat3';
    }
  }
}

@AutoRouterConfig(replaceInRouteName: 'Page|Screen|Tab,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    // Main Category 1 with nested routes
    AutoRoute(
      path: AppRoutes.mainCat1.path,
      page: MainCat1Route.page,
      initial: true,
      children: [
        AutoRoute(path: '', page: MainCat1Route.page),
        AutoRoute(
          path: AppRoutes.main1SubCat1.path,
          page: Main1SubCat1Route.page,
        ),
        AutoRoute(
          path: AppRoutes.main1SubCat2.path,
          page: Main1SubCat2Route.page,
        ),
      ],
    ),
    // Main Category 2 with nested routes
    AutoRoute(
      path: AppRoutes.mainCat2.path,
      page: MainCat2Route.page,
      children: [
        AutoRoute(path: '', page: MainCat2Route.page),
        AutoRoute(
          path: AppRoutes.main2SubCat1.path,
          page: Main2SubCat1Route.page,
        ),
        AutoRoute(
          path: AppRoutes.main2SubCat2.path,
          page: Main2SubCat2Route.page,
        ),
      ],
    ),
    // Main Category 3 (no nested routes)
    AutoRoute(
      path: AppRoutes.mainCat3.path,
      page: MainCat3Route.page,
    ),
  ];
}