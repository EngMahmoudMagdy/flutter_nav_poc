import 'package:auto_route/auto_route.dart';

class BreadcrumbItem {
  final String name;
  final String routePath;
  final bool isClickable;

  const BreadcrumbItem({
    required this.name,
    required this.routePath,
    this.isClickable = true,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BreadcrumbItem &&
          runtimeType == other.runtimeType &&
          routePath == other.routePath;

  @override
  int get hashCode => routePath.hashCode;
}

class BreadcrumbService {
  final StackRouter _router;

  BreadcrumbService(this._router);

  List<BreadcrumbItem> getBreadcrumbs() {
    final breadcrumbs = <BreadcrumbItem>[];

    // Get the current stack and build hierarchy
    final currentStack = _router.stack;

    for (final route in currentStack) {
      breadcrumbs.add(_createBreadcrumbItem(route.routeData));
    }

    return breadcrumbs;
  }

  /// Alternative method using route history
  List<BreadcrumbItem> getBreadcrumbsFromHistory() {
    final breadcrumbs = <BreadcrumbItem>[];

    // Start from current route and go up the parent chain
    RouteData? current = _router.current;
    final visitedPaths = <String>{};

    while (current != null) {
      if (!visitedPaths.contains(current.path)) {
        breadcrumbs.insert(0, _createBreadcrumbItem(current));
        visitedPaths.add(current.path);
      }

      // Get parent by looking at route path hierarchy
      current = _getParentRoute(current);
    }

    return breadcrumbs;
  }

  RouteData? _getParentRoute(RouteData current) {
    final currentPath = current.path;

    // Remove the last segment to get parent path
    final segments = currentPath
        .split('/')
        .where((segment) => segment.isNotEmpty)
        .toList();
    if (segments.length > 1) {
      segments.removeLast();
      final parentPath = '/${segments.join('/')}';

      // Find the route that matches this parent path
      return _router.stack.cast<RouteData?>().firstWhere(
        (route) => route?.path == parentPath,
        orElse: () => null,
      );
    }

    return null;
  }

  BreadcrumbItem _createBreadcrumbItem(RouteData route) {
    return BreadcrumbItem(
      name: _getDisplayName(route),
      routePath: route.path,
      isClickable: route != _router.current, // Current page is not clickable
    );
  }

  String _getDisplayName(RouteData route) {
    // Use route name or extract from path
    final name = route.name;

    // Custom mapping for route names to display names
    final displayNames = {
      'root': 'Home',
      'category1': 'Category 1',
      'category2': 'Category 2',
      'sub1A': 'Subcategory A',
      'sub1B': 'Subcategory B',
      'sub2A': 'Products A',
      'sub2B': 'Products B',
    };

    return displayNames[name] ?? _formatRouteName(name);
  }

  String _formatRouteName(String routeName) {
    if (routeName.isEmpty) return 'Home';

    // Convert route_name to "Route Name"
    return routeName
        .split('_')
        .map((word) {
          if (word.isEmpty) return word;
          return word[0].toUpperCase() + word.substring(1);
        })
        .join(' ');
  }

  Future<void> navigateToBreadcrumb(BreadcrumbItem item) async {
    if (!item.isClickable) return;

    // Pop until we reach the target route
    _router.popUntil((route) => route.settings.name == item.routePath);
  }

  /// Get breadcrumbs for nested routes (if using nested navigation)
  List<BreadcrumbItem> getNestedBreadcrumbs() {
    final breadcrumbs = <BreadcrumbItem>[];

    // Get all active routes in the stack
    for (final route in _router.stack) {
      final pageRoute = route;

      breadcrumbs.add(
        BreadcrumbItem(
          name: _getDisplayNameForRoute(pageRoute),
          routePath: pageRoute.routeData.path,
          isClickable: pageRoute.routeData != _router.current,
        ),
      );
    }

    return breadcrumbs;
  }

  String _getDisplayNameForRoute(AutoRoutePage route) {
    // Try to extract name from route settings
    final settings = route.routeData.name;
    return _formatRouteName(settings);
  }
}
