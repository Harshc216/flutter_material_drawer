import 'package:flutter/material.dart';
import '../controllers/drawer_controller.dart';
import '../enums/drawer_type.dart';
import '../models/drawer_menu_item.dart';
import '../utils/drawer_constants.dart';
import '../utils/drawer_theme.dart';
import 'drawer_divider.dart';
import 'drawer_header.dart';
import 'drawer_item.dart';

/// Main Material Drawer widget.
class MaterialDrawer extends StatelessWidget {
  const MaterialDrawer({
    super.key,
    required this.controller,
    required this.items,
    required this.name,
    required this.email,
    this.image,
    this.theme = const MaterialDrawerTheme(),
    this.type = DrawerType.classic,
  });

  final MaterialDrawerController controller;

  final List<DrawerMenuItem> items;

  final String name;

  final String email;

  final ImageProvider? image;

  final MaterialDrawerTheme theme;

  final DrawerType type;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Drawer(
          width: DrawerConstants.drawerWidth,
          elevation: theme.elevation,
          shape: _shape(),
          child: Container(
            decoration: _decoration(),
            child: Column(
              children: [
                DrawerHeaderWidget(
                  name: name,
                  email: email,
                  image: image,
                  theme: theme,
                ),

                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: items.length,
                    separatorBuilder: (context, index) =>
                        DrawerDividerWidget(theme: theme),
                    itemBuilder: (context, index) {
                      final item = items[index];

                      return DrawerItem(
                        item: item,
                        selected: controller.selectedIndex == index,
                        theme: theme,
                        onTap: () {
                          controller.select(index);

                          Navigator.pop(context);

                          item.onTap?.call();
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  ShapeBorder? _shape() {
    switch (type) {
      case DrawerType.rounded:
        return const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(right: Radius.circular(30)),
        );

      default:
        return null;
    }
  }

  Decoration? _decoration() {
    switch (type) {
      case DrawerType.gradient:
        return const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff2196F3), Color(0xff1565C0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        );

      case DrawerType.dark:
        return const BoxDecoration(color: Color(0xff202124));

      case DrawerType.glass:
        return BoxDecoration(color: Colors.white.withValues(alpha: 0.15));

      case DrawerType.minimal:
        return const BoxDecoration(color: Colors.white);

      case DrawerType.rounded:
      case DrawerType.classic:
        return BoxDecoration(color: theme.backgroundColor);
    }
  }
}
