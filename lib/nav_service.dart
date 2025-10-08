import 'package:flutter/material.dart';

/// A singleton navigation service to handle app-wide navigation logic.
///
/// This service allows navigating to different parts of the app, such as
/// main categories or specific subcategories, using their route names. It can
/// be accessed from anywhere in the app without needing a BuildContext.
class NavService {
  /// A global key for the navigator state, allowing navigation from anywhere.
  ///
  /// This key must be assigned to the `navigatorKey` property of your
  /// `MaterialApp` or `CupertinoApp`.
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // 1. Private constructor for the singleton pattern.
  NavService._privateConstructor();

  // 2. The single, static instance of the NavService.
  static final NavService _instance = NavService._privateConstructor();

  // 3. The public factory constructor that returns the instance.
  /// Provides access to the singleton instance of the [NavService].
  factory NavService() {
    return _instance;
  }

  /// Navigates to a main category screen.
  ///
  /// Uses the provided [routeName] to push a new named route onto the stack.
  /// Example: NavService().navigateToMainCategory('/categories');
  Future<T?>? navigateToMainCategory<T extends Object?>(String routeName, {Object? arguments}) {
    // Check if the navigator can be used.
    if (navigatorKey.currentState != null) {
      return navigatorKey.currentState!.pushNamed<T>(
        routeName,
        arguments: arguments,
      );
    }
    _logNavigationError(routeName);
    return null;
  }

  /// Navigates to a subcategory screen.
  ///
  /// This is functionally similar to [navigateToMainCategory] but provides
  /// semantic clarity for navigating to more specific content.
  /// Example: NavService().navigateToSubcategory('/category/electronics');
  Future<T?>? navigateToSubcategory<T extends Object?>(String routeName, {Object? arguments}) {
    if (navigatorKey.currentState != null) {
      return navigatorKey.currentState!.pushNamed<T>(
        routeName,
        arguments: arguments,
      );
    }
    _logNavigationError(routeName);
    return null;
  }

  /// A generic navigation function to push a named route.
  ///
  /// This can be used for any route that doesn't fit the category/subcategory model.
  Future<T?>? navigateTo<T extends Object?>(String routeName, {Object? arguments}) {
    if (navigatorKey.currentState != null) {
      return navigatorKey.currentState!.pushNamed<T>(
        routeName,
        arguments: arguments,
      );
    }
    _logNavigationError(routeName);
    return null;
  }

  /// Pops the current route off the navigator stack.
  void goBack<T extends Object?>([T? result]) {
    if (navigatorKey.currentState != null) {
      navigatorKey.currentState!.pop<T>(result);
    }
  }

  /// Helper function to log an error if navigation fails.
  void _logNavigationError(String routeName) {
    // In a real app, you might use a logging framework like 'logger'.
    debugPrint('Navigation Error: Could not navigate to "$routeName". The navigatorKey.currentState is null.');
    debugPrint('Ensure you have assigned the navigatorKey to your MaterialApp.');
  }
}
