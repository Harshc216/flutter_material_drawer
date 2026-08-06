import 'package:flutter/material.dart';

/// Represents a single item inside the Material Drawer.
class DrawerMenuItem {
  /// Creates a drawer menu item.
  const DrawerMenuItem({
    required this.title,
    required this.icon,
    this.onTap,
    this.badge,
    this.enabled = true,
  });

  /// Text displayed in the drawer.
  final String title;

  /// Leading icon.
  final IconData icon;

  /// Optional badge text.
  final String? badge;

  /// Whether this item can be tapped.
  final bool enabled;

  /// Callback when the item is pressed.
  final VoidCallback? onTap;
}
