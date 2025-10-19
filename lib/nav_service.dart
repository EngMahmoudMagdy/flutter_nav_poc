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
  late final StackRouter _appRouter;

  bool _appRouterInitialized = false;

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
  /// This MUST be called in RootLayoutRouter page before the app runs.
  void setRouter(StackRouter router) {
    if (!_appRouterInitialized) {
      _appRouter = router;
      _appRouterInitialized = true;
    }
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

  /// Navigates to a Independent screen using Path.
  Future<T?> navigateToIndependentWithPath<T extends Object?>({
    required String routePath,
  }) {
    return _safeNavigate<T?>(() => _appRouter.pushPath<T>(routePath));
  }

  /// Navigates to a main category screen using Enum.
  Future<T?> navigateToMainCategory<T extends Object?>({
    required BuildContext context,
    required MainCategory mainCategory,
  }) {
    final isMainCategoryShown = _isMainCategoryShown(context);
    if (!isMainCategoryShown) {
      _safeNavigate<T?>(() {
        _appRouter.popUntil((route) {
          return route.isFirst;
        },);
        return Future.value();
      });
    }
    print("currentMainCategory ${currentMainCategory?.routePath}");
    print("mainCategory ${mainCategory.routePath}");
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

  bool showBreadcrumb = true;

  /// Navigates to a subcategory screen using a type-safe route.
  Future<T?> navigateToSubcategory<T extends Object?>({
    required BuildContext context,
    required SubCategory subCategory,
  }) async {
    final currentPath = _getCurrentPath(context);
    print('Current path: $currentPath');
    print('Subcategory path: ${subCategory.routePath}');
    final isSameMainCategory =
        currentSubCategory?.mainCategory == subCategory.mainCategory;
    final isSameSubCategory = currentSubCategory == subCategory;
    final isOnSubCategoryPage = currentPath == subCategory.routePath;
    final isOnSameMainCategoryPage =
        currentPath == subCategory.mainCategory.routePath;

    final isMainCategoryShown =
        _isMainCategoryShown(context) && isOnSameMainCategoryPage;

    currentSubCategory = subCategory;
    currentMainCategory = subCategory.mainCategory;

    // Case 1: Clicking the same subcategory in drawer - pop to existing instance
    if(isOnSubCategoryPage) {
      return Future.value();
    }

    if (isMainCategoryShown) {
      print('_pushNewSubCategory');
      return _pushNewSubCategory<T>(subCategory);
    }

    // Case 2: Same main category, different subcategory - pop to main category and push new subcategory
    if (isSameMainCategory && !isSameSubCategory) {
      return _switchSubCategoryInSameMainCategory<T>(subCategory, context);
    }

    if (isSameMainCategory && isSameSubCategory) {
      return _popToExistingSubCategory<T>(subCategory);
    }

    // Case 3: Different main category - complete stack rebuild
    if (!isSameMainCategory) {
      return _switchToDifferentMainCategory<T>(subCategory);
    }

    // Case 4: Default - push new subcategory
    if (!isSameSubCategory) {
      return _pushNewSubCategory<T>(subCategory);
    }

    return Future.value();
  }

  Future<T?> _popToExistingSubCategory<T>(SubCategory subCategory) {
    return _safeNavigate<T?>(() async {
      // Pop until we reach the existing subcategory page
      _appRouter.popUntil((route) {
        print("route.settings.name ${route.settings.name}");
        print("subCategory ${subCategory.routePath}");
        return route.settings.name == subCategory.routePath;
      });
      return null;
    });
  }

  Future<T?> _switchSubCategoryInSameMainCategory<T>(
    SubCategory subCategory,
    BuildContext context,
  ) {
    return _safeNavigate<T?>(() async {
      // Pop all pages until main category
      _appRouter.popUntil((route) {
        print("route.data?.path ${route.data?.path}");
        print("mainCategory ${subCategory.mainCategory.routePath}");
        return route.data?.path == subCategory.mainCategory.routePath;
      });
      print('current path: ${_getCurrentPath(context)}');
      // Push new subcategory
      return _appRouter.push<T>(subCategory.route);
    });
  }

  Future<T?> _switchToDifferentMainCategory<T>(SubCategory subCategory) {
    return _safeNavigate<T?>(() async {
      _appRouter.popUntil((route) {
        return route.isFirst;
      },);
      _appRouter.pop();
      await _appRouter.pushAll([
        subCategory.mainCategory.route,
        subCategory.route,
      ]);
      return Future.value();
    });
  }

  Future<T?> _pushNewSubCategory<T>(SubCategory subCategory) {
    return _safeNavigate<T?>(
      () => _appRouter.pushPath<T>(subCategory.routePath),
    );
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

  bool _isMainCategoryShown(BuildContext context) {
    return MainCategory.values.any(
      (element) => element.routePath == _getCurrentPath(context),
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
