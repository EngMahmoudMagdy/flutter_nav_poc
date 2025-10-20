// breadcrumb_service.dart
import 'package:auto_route/auto_route.dart';
import 'package:nav_poc/models/bread_crumb_item.dart';

import 'nav_service.dart';

class BreadcrumbService {
  late final StackRouter _router;
  final NavService _navService;

  BreadcrumbService(this._navService) {
    _router = _navService.appRouter;
  }

  /// Get auto-generated breadcrumbs from current stack
  List<BreadcrumbItem> getAutoBreadcrumbs() {
    final breadcrumbs = <BreadcrumbItem>[];

    for (final route in _router.stack) {
      final routeData = route.routeData;
      final breadcrumbName = _extractBreadcrumbName(routeData);
      final isCurrentPage = route == _router.stack.last;

      breadcrumbs.add(
        BreadcrumbItem(
          name: breadcrumbName,
          routePath: routeData.path,
          isClickable: !isCurrentPage, // Last item is not clickable
          routeInfo: routeData,
        ),
      );
    }

    return breadcrumbs;
  }

  /// Get combined breadcrumbs (auto-generated + custom)
  List<BreadcrumbItem> getBreadcrumbs({
    List<BreadcrumbItem>? customBreadcrumbs,
  }) {
    if (customBreadcrumbs != null && customBreadcrumbs.isNotEmpty) {
      return customBreadcrumbs;
    }

    return getAutoBreadcrumbs();
  }

  String _extractBreadcrumbName(RouteData routeData) {
    // Try to get from meta data first
    final meta = routeData.meta;
    if (meta != null && meta['breadcrumb'] != null) {
      return meta['breadcrumb'].toString();
    }

    // Fallback to route name
    final routeName = routeData.name;
    if (routeName != null) {
      return _beautifyRouteName(routeName);
    }

    // Final fallback: use path
    return _beautifyPath(routeData.path);
  }

  String _beautifyRouteName(String routeName) {
    return routeName
        .replaceAll('Route', '')
        .replaceAll('Page', '')
        .replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match.group(0)}')
        .trim();
  }

  String _beautifyPath(String path) {
    final segments = path
        .split('/')
        .where((segment) => segment.isNotEmpty)
        .toList();
    if (segments.isNotEmpty) {
      final lastSegment = segments.last;
      return lastSegment
          .replaceAll('-', ' ')
          .replaceAllMapped(
            RegExp(r'^[a-z]'),
            (match) => match.group(0)!.toUpperCase(),
          );
    }
    return 'Home';
  }

  /// Navigate to a breadcrumb item using NavService
  Future<void> navigateToBreadcrumb(BreadcrumbItem item) async {
    if (!item.isClickable) return;

    // Use custom navigation callback if provided
    if (item.customNavigationCallback != null) {
      item.customNavigationCallback!();
      return;
    }

    // Use path-based navigation to pop until we reach the target
    await _navigateToPath(item.routePath);
  }

  Future<void> _navigateToPath(String routePath) async {
    // Find the target route in stack
    final targetIndex = _router.stack.indexWhere(
      (route) => route.routeData.path == routePath,
    );

    if (targetIndex != -1) {
      // Calculate how many pops needed to reach the target
      final popsNeeded = _router.stack.length - targetIndex - 1;

      // Pop the required number of times
      for (int i = 0; i < popsNeeded; i++) {
        if (_router.canPop()) {
          await _navService.goBack();
        }
      }
    } else {
      // If route not found in stack, use NavService to navigate
      await _navService.navigateToIndependentWithPath(routePath: routePath);
    }
  }

  /// Check if current page is a main category
  bool isMainCategoryPage(String routePath) {
    return _navService.currentMainCategory?.routePath == routePath;
  }

  /// Check if current page is a subcategory
  bool isSubCategoryPage(String routePath) {
    return _navService.currentSubCategory?.routePath == routePath;
  }

  /// Get display name for main category
  String getMainCategoryDisplayName(MainCategory mainCategory) {
    return _beautifyRouteName(mainCategory.route.routeName);
  }

  /// Get display name for subcategory
  String getSubCategoryDisplayName(SubCategory subCategory) {
    return _beautifyRouteName(subCategory.route.routeName);
  }
}
