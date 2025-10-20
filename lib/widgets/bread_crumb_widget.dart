import 'package:flutter/material.dart';
import 'package:nav_poc/bread_crumb_service.dart';
import 'package:nav_poc/models/bread_crumb_item.dart';
import 'package:nav_poc/nav_service.dart';

class EsBreadCrumb extends StatefulWidget {
  final List<BreadcrumbItem>? customBreadcrumbs;
  final Future<bool> Function()? navigationInterceptor;

  const EsBreadCrumb({
    super.key,
    this.customBreadcrumbs,
    this.navigationInterceptor,
  });

  @override
  State<EsBreadCrumb> createState() => _EsBreadCrumbState();
}

class _EsBreadCrumbState extends State<EsBreadCrumb> {
  late BreadcrumbService _breadcrumbService;
  late NavService _navService;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _navService = NavService();
    _breadcrumbService = BreadcrumbService(_navService);
  }

  @override
  Widget build(BuildContext context) {
    // Check if breadcrumb should be visible
    if (!_navService.showBreadcrumb) {
      return const SizedBox.shrink();
    }

    final breadcrumbs = _breadcrumbService.getBreadcrumbs(
      customBreadcrumbs: widget.customBreadcrumbs,
    );

    return _buildBreadcrumbNavigation(breadcrumbs);
  }

  Widget _buildBreadcrumbNavigation(List<BreadcrumbItem> breadcrumbs) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: _buildBreadcrumbItems(breadcrumbs)),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildBreadcrumbItems(List<BreadcrumbItem> breadcrumbs) {
    final items = <Widget>[];

    for (int i = 0; i < breadcrumbs.length; i++) {
      final item = breadcrumbs[i];
      final isLast = i == breadcrumbs.length - 1;

      items.add(_buildBreadcrumbItem(item, isLast));

      // Add separator if not the last item
      if (!isLast) {
        items.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Icon(
              Icons.chevron_right,
              size: 16,
              color: Colors.grey.shade400,
            ),
          ),
        );
      }
    }

    return items;
  }

  Widget _buildBreadcrumbItem(BreadcrumbItem item, bool isLast) {
    return GestureDetector(
      onTap: item.isClickable ? () => _onBreadcrumbTap(item) : null,
      child: MouseRegion(
        cursor: item.isClickable
            ? SystemMouseCursors.click
            : SystemMouseCursors.basic,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: item.isClickable
                ? Theme.of(context).primaryColor.withAlpha(25)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            item.name,
            style: TextStyle(
              color: item.isClickable
                  ? Colors.black
                  : Colors.grey.shade900,
              fontWeight: isLast ? FontWeight.w600 : FontWeight.normal,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onBreadcrumbTap(BreadcrumbItem item) async {
    // Check navigation interceptor if provided
    if (widget.navigationInterceptor != null) {
      final canNavigate = await widget.navigationInterceptor!();
      if (!canNavigate) return;
    }

    // Use breadcrumb service for navigation
    await _breadcrumbService.navigateToBreadcrumb(item);
  }
}
