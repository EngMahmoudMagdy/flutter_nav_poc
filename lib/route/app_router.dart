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

@AutoRouterConfig(replaceInRouteName: 'Page|Screen|Tab,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    // Use custom transitions to remove animation
    CustomRoute(
      path: '/${AppRoutes.mainCat1.name}',
      page: MainCat1Route.page,
      initial: true,
      transitionsBuilder: TransitionsBuilders.noTransition,
    ),
    CustomRoute(
      path: '/${AppRoutes.main1SubCat1.name}',
      page: Main1SubCat1Route.page,
      transitionsBuilder: TransitionsBuilders.noTransition,
    ),
    CustomRoute(
      path: '/${AppRoutes.main1SubCat2.name}',
      page: Main1SubCat2Route.page,
      transitionsBuilder: TransitionsBuilders.noTransition,
    ),
    CustomRoute(
      path: '/${AppRoutes.mainCat2.name}',
      page: MainCat2Route.page,
      transitionsBuilder: TransitionsBuilders.noTransition,
    ),
    CustomRoute(
      path: '/${AppRoutes.main2SubCat1.name}',
      page: Main2SubCat1Route.page,
      transitionsBuilder: TransitionsBuilders.noTransition,
    ),
    CustomRoute(
      path: '/${AppRoutes.main2SubCat2.name}',
      page: Main2SubCat2Route.page,
      transitionsBuilder: TransitionsBuilders.noTransition,
    ),
    CustomRoute(
      path: '/${AppRoutes.mainCat3.name}',
      page: MainCat3Route.page,
      transitionsBuilder: TransitionsBuilders.noTransition,
    ),
  ];
}