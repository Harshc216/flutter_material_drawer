import 'package:flutter/material.dart';

/// Theme configuration for MaterialDrawer.
class MaterialDrawerTheme {
  const MaterialDrawerTheme({
    this.backgroundColor = Colors.white,
    this.selectedColor = Colors.blue,
    this.unselectedColor = Colors.black87,
    this.iconColor = Colors.black87,
    this.selectedIconColor = Colors.white,
    this.headerColor = Colors.blue,
    this.dividerColor = const Color(0xFFE0E0E0),
    this.elevation = 8,
    this.borderRadius = 20,
    this.itemRadius = 12,
  });

  final Color backgroundColor;

  final Color selectedColor;

  final Color unselectedColor;

  final Color iconColor;

  final Color selectedIconColor;

  final Color headerColor;

  final Color dividerColor;

  final double elevation;

  final double borderRadius;

  final double itemRadius;
}