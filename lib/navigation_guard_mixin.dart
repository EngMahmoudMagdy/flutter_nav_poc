// lib/mixins/navigation_guard_mixin.dart
import 'package:flutter/material.dart';
import 'package:nav_poc/nav_service.dart';

mixin NavigationGuardMixin<T extends StatefulWidget> on State<T> {
  bool _hasUnsavedChanges = false;

  // Getter to access the unsaved changes state
  bool get hasUnsavedChanges => _hasUnsavedChanges;

  @override
  void initState() {
    super.initState();
    // Register this page as having navigation guard
    NavService().setNavigationGuard(_checkUnsavedChanges);
  }

  @override
  void dispose() {
    // Clear the navigation guard when this page is disposed
    NavService().clearNavigationGuard();
    super.dispose();
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
    ) ?? false;
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