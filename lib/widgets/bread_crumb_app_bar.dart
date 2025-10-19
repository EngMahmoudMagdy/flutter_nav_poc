// breadcrumb_app_bar.dart
import 'package:flutter/material.dart';
import 'package:nav_poc/models/bread_crumb_item.dart';
import 'package:nav_poc/widgets/bread_crumb_widget.dart';

class BreadcrumbAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Color? backgroundColor;
  final List<Widget>? actions;
  final bool automaticallyImplyLeading;
  final List<BreadcrumbItem>? customBreadcrumbs;
  final Future<bool> Function()? navigationInterceptor;

  const BreadcrumbAppBar({
    super.key,
    this.title,
    this.actions,
    this.backgroundColor,
    this.automaticallyImplyLeading = true,
    this.customBreadcrumbs,
    this.navigationInterceptor,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 48);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: automaticallyImplyLeading,
      actions: actions,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: EsBreadCrumb(
          customBreadcrumbs: customBreadcrumbs,
          navigationInterceptor: navigationInterceptor,
        ),
      ),
    );
  }
}
