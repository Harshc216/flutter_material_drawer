import 'package:flutter/material.dart';

import '../utils/drawer_theme.dart';

/// Divider used inside drawer.
class DrawerDividerWidget extends StatelessWidget {
  const DrawerDividerWidget({super.key, required this.theme});

  final MaterialDrawerTheme theme;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: theme.dividerColor,
      height: 1,
      thickness: 1,
      indent: 16,
      endIndent: 16,
    );
  }
}
