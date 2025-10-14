import 'package:auto_route/auto_route.dart';
import 'package:nav_poc/pages/IndependentPage.dart';
import 'package:nav_poc/pages/main_cat1/main_cat1.dart';
import 'package:nav_poc/pages/main_cat1/sub_cat/main1_sub_cat1.dart';
import 'package:nav_poc/pages/main_cat1/sub_cat/main1_sub_cat2.dart';
import 'package:nav_poc/pages/main_cat1/sub_cat/main1_sub_cat_3.dart';
import 'package:nav_poc/pages/main_cat1/sub_cat/main_content.dart';
import 'package:nav_poc/pages/main_cat2/main2_content.dart';
import 'package:nav_poc/pages/main_cat2/main_cat2.dart';
import 'package:nav_poc/pages/main_cat2/sub_cat/main2_sub_cat1.dart';
import 'package:nav_poc/pages/main_cat2/sub_cat/main2_sub_cat2.dart';
import 'package:nav_poc/pages/main_cat3/main_cat3.dart';
import 'package:nav_poc/pages/root_layout.dart';
import 'package:nav_poc/pages/vacation_request_page.dart';

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
    // Root layout that contains the persistent drawer
    AutoRoute(
      path: '/',
      page: RootLayoutRoute.page,
      initial: true,
      children: [
        // Main categories and subcategories as nested routes
        AutoRoute(
          path: 'mainCat1',
          page: MainCat1Route.page,
          children: [
            AutoRoute(
              path: 'main1Content',
              page: MainContentRoute.page,
              initial: true,
            ),
          ],
        ),
        AutoRoute(path: 'sub1Main1', page: Main1SubCat1Route.page),
        AutoRoute(path: 'sub2Main1', page: Main1SubCat2Route.page),
        AutoRoute(path: 'sub3Main1', page: Main1SubCat3Route.page),
        AutoRoute(
          path: 'mainCat2',
          page: MainCat2Route.page,
          children: [
            AutoRoute(
              path: 'main2Content',
              page: Main2ContentRoute.page,
              initial: true,
            ),
          ],
        ),
        AutoRoute(path: 'sub1Main2', page: Main2SubCat1Route.page),
        AutoRoute(path: 'sub2Main2', page: Main2SubCat2Route.page),
        AutoRoute(path: 'mainCat3', page: MainCat3Route.page),
        AutoRoute(path: 'independent', page: IndependentRoute.page),
        AutoRoute(
          path: 'vacation_request_page',
          page: VacationRequestRoute.page,
        ),
      ],
    ),
  ];
}
