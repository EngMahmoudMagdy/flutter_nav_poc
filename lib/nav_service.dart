// lib/nav_service.dart
import 'package:auto_route/auto_route.dart';
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

  /// Navigates to a main category screen using a type-safe route.
  ///
  /// Example: NavService().navigateToMainCategory(CategoryARoute());
  Future<T?> navigateToMainCategory<T extends Object?>(
      {required PageRouteInfo route}) {
    return _appRouter.push<T>(route);
  }

  /// Navigates to a subcategory screen using a type-safe route.
  ///
  /// Example: NavService().navigateToSubcategory(route: SubCategoryXRoute());
  Future<T?> navigateToSubcategory<T extends Object?>(
      {required PageRouteInfo route}) {
    return _appRouter.push<T>(route);
  }

  /// A generic navigation function to push any type-safe route.
  Future<T?> navigateTo<T extends Object?>({required PageRouteInfo route}) {
    return _appRouter.push<T>(route);
  }

  /// Pops the current route off the navigator stack.
  Future<void> goBack<T extends Object?>([T? result]) async {
    return _appRouter.pop<T>(result);
  }
}
