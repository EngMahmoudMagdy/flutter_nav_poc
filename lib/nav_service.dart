// lib/nav_service.dart
import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nav_poc/route/app_router.dart';

/// A singleton navigation service to work with auto_route.
///
/// This service allows navigating from anywhere in the app (e.g., from
/// providers or business logic classes) without needing a BuildContext,
/// while leveraging the type-safe routing from auto_route.
class NavService {
  // The single, static instance of the AppRouter.
  // This will be initialized in main.dart.
  late final AppRouter _appRouter;

  // Navigation guard callback
  Future<bool> Function()? _onNavigationRequested;

  // Private constructor for the singleton pattern.
  NavService._privateConstructor();

  // The static instance of the NavService.
  static final NavService _instance = NavService._privateConstructor();

  // The public factory constructor that returns the singleton instance.
  factory NavService() {
    return _instance;
  }

  /// Initializes the NavService with the app's router instance.
  /// This MUST be called in main.dart before the app runs.
  void setRouter(AppRouter router) {
    _appRouter = router;
  }

  /// Sets a global navigation guard callback
  void setNavigationGuard(Future<bool> Function()? guard) {
    _onNavigationRequested = guard;
  }

  /// Clears the navigation guard
  void clearNavigationGuard() {
    _onNavigationRequested = null;
  }

  /// Safe navigation method that checks with navigation guard
  Future<T?> _safeNavigate<T extends Object?>(
    Future<T?> Function() navigate,
  ) async {
    if (_onNavigationRequested != null) {
      final canNavigate = await _onNavigationRequested!();
      if (!canNavigate) {
        return null;
      }
    }
    return navigate();
  }

  /// Navigates to a Independent screen using a type-safe route.
  Future<T?> navigateToIndependent<T extends Object?>({
    required PageRouteInfo route,
  }) {
    return _safeNavigate<T?>(() => _appRouter.push<T>(route));
  }

  /// Navigates to a main category screen using Enum.
  Future<T?> navigateToMainCategory<T extends Object?>({
    required MainCategory mainCategory,
  }) {
    if (currentSubCategory != null) {
      _safeNavigate<T?>(() {
        _appRouter.popTop<T>();
        return Future.value();
      });
    }
    if (currentMainCategory != mainCategory) {
      currentMainCategory = mainCategory;
      currentSubCategory = null;
      return _safeNavigate<T?>(
        () => _appRouter.replacePath<T>(mainCategory.routePath),
      );
    }
    return _safeNavigate<T?>(() => Future.value());
  }

  MainCategory? currentMainCategory;
  SubCategory? currentSubCategory;

  var isInitial = true;

  /// Navigates to a subcategory screen using a type-safe route.
  Future<T?> navigateToSubcategory<T extends Object?>(
    BuildContext context, {
    required SubCategory subCategory,
  }) async {
    final currentTopPagePathName = _getCurrentPath(context);
    print("currentMainCategory $currentMainCategory");
    print("currentSubCategory $currentSubCategory");
    print("currentTopPagePathName $currentTopPagePathName");
    if (currentSubCategory?.mainCategory == subCategory.mainCategory &&
        currentTopPagePathName != subCategory.mainCategory.routePath) {
      currentSubCategory = subCategory;
      return _safeNavigate<T?>(
        () => _appRouter.replacePath<T>(subCategory.routePath),
      );
    } else if (currentMainCategory != subCategory.mainCategory) {
      currentMainCategory = subCategory.mainCategory;
      if (currentSubCategory != null) {
        currentSubCategory = subCategory;
        _safeNavigate<T?>(() {
          _appRouter.popTop();
          return Future.value();
        });
        return _safeNavigate<T?>(() async {
          _appRouter.popAndPush(subCategory.mainCategory.route);
          _appRouter.push(subCategory.route);
          return Future.value();
        });
      } else {
        _safeNavigate<T?>(() {
          _appRouter.popAndPush(subCategory.mainCategory.route);
          return Future.value();
        });
        await _safeNavigate<T?>(
          () => _appRouter.pushPath<T>(subCategory.routePath),
        );
      }
    } else {
      currentSubCategory = subCategory;
      return _safeNavigate<T?>(
        () => _appRouter.pushPath<T>(subCategory.routePath),
      );
    }
    return Future.value();
  }

  String _getCurrentPath(BuildContext context) {
    // This gets the router that's managing the pages inside AutoRouter()
    final innerRouter = context.innerRouterOf<StackRouter>(
      RootLayoutRoute.name,
    );

    if (innerRouter != null) {
      return innerRouter.current.path;
    }

    // Fallback to main router if inner router not found
    return context.router.current.path;
  }

  /// Pops the current route off the navigator stack.
  Future<void> goBack<T extends Object?>([T? result]) async {
    return _safeNavigate<void>(() async => _appRouter.pop<T>(result));
  }

  /// Replaces the current route with a new one
  Future<T?> replace<T extends Object?>({required PageRouteInfo route}) {
    return _safeNavigate<T?>(() => _appRouter.replace<T>(route));
  }

  /// Navigates to a route and removes all previous routes
  Future<T?> navigateAndPopAll<T extends Object?>({
    required PageRouteInfo route,
  }) {
    return _safeNavigate<T?>(
      () => _appRouter.pushAndPopUntil<T>(
        route,
        onFailure: (route) => false,
        predicate: (Route<dynamic> route) {
          return false;
        },
      ),
    );
  }
}

enum MainCategory {
  category1('mainCat1', MainCat1Route()),
  category2('mainCat2', MainCat2Route()),
  category3('mainCat3', MainCat3Route());

  const MainCategory(this.routePath, this.route);

  final String routePath;
  final PageRouteInfo route;
}

enum SubCategory {
  // Category 1 subcategories
  sub1Main1(MainCategory.category1, 'sub1Main1', Main1SubCat1Route()),
  sub2Main1(MainCategory.category1, 'sub2Main1', Main1SubCat2Route()),
  sub3Main1(MainCategory.category1, 'sub3Main1', Main1SubCat3Route()),

  // Category 2 subcategories
  sub1Main2(MainCategory.category2, 'sub1Main2', Main2SubCat1Route()),
  sub2Main2(MainCategory.category2, 'sub2Main2', Main2SubCat2Route());

  const SubCategory(this.mainCategory, this.routePath, this.route);

  final MainCategory mainCategory;
  final String routePath;
  final PageRouteInfo route;
}

// Helper extension
extension SubCategoryExt on SubCategory {
  bool isSameMainCategory(SubCategory other) {
    return mainCategory == other.mainCategory;
  }
}
