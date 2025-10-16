// lib/mixins/navigation_guard_mixin.dart
import 'package:flutter/material.dart';
import 'package:nav_poc/nav_service.dart';

mixin NavigationGuardMixin<T extends StatefulWidget> on State<T> {
  bool _hasUnsavedChanges = false;

  bool _canPop = false;

  // Getter to access the unsaved changes state
  bool get hasUnsavedChanges => _hasUnsavedChanges;

  @override
  void initState() {
    super.initState();
    NavService().setNavigationGuard(_checkUnsavedChanges);
  }

  @override
  void dispose() {
    NavService().clearNavigationGuard();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildWithBackProtection(child: buildWithProtection(context));
  }

  Widget buildWithProtection(BuildContext context);

  Widget buildWithBackProtection({required Widget child}) {
    return PopScope(
      canPop: _canPop,
      onPopInvokedWithResult: (bool didPop, dynamic result) async{
        if (didPop) return;
        _canPop = await _checkUnsavedChanges();
        if (_canPop && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: child,
    );
  }

  /// Override this method in your form page to check for unsaved changes
  Future<bool> _checkUnsavedChanges() async {
    print("_checkUnsavedChanges called");
    if (!_hasUnsavedChanges) {
      return true;
    }

    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Unsaved Changes'),
              content: const Text(
                'You have unsaved changes. Are you sure you want to leave? Your changes will be lost.',
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('STAY'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('LEAVE'),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  /// Call this method when the form has unsaved changes
  void setHasUnsavedChanges(bool hasChanges) {
    if (mounted) {
      setState(() {
        _hasUnsavedChanges = hasChanges;
      });
    }
  }

  /// Call this when form is submitted successfully to clear unsaved changes
  void clearUnsavedChanges() {
    setHasUnsavedChanges(false);
  }
}
