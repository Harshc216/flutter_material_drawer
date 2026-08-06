import 'package:flutter/material.dart';

import '../models/drawer_menu_item.dart';
import '../utils/drawer_constants.dart';
import '../utils/drawer_theme.dart';

/// Single drawer menu item.
class DrawerItem extends StatelessWidget {
  const DrawerItem({
    super.key,
    required this.item,
    required this.selected,
    required this.onTap,
    required this.theme,
  });

  final DrawerMenuItem item;
  final bool selected;
  final VoidCallback onTap;
  final MaterialDrawerTheme theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: DrawerConstants.itemPadding,
      child: Material(
        color: selected ? theme.selectedColor : Colors.transparent,
        borderRadius: BorderRadius.circular(theme.itemRadius),
        child: InkWell(
          borderRadius: BorderRadius.circular(theme.itemRadius),
          onTap: item.enabled ? onTap : null,
          child: Container(
            height: DrawerConstants.itemHeight,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(
                  item.icon,
                  size: DrawerConstants.iconSize,
                  color: selected ? theme.selectedIconColor : theme.iconColor,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    item.title,
                    style: TextStyle(
                      fontSize: 16,
                      color: selected ? Colors.white : theme.unselectedColor,
                      fontWeight: selected ? FontWeight.bold : FontWeight.w500,
                    ),
                  ),
                ),
                if (item.badge != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      item.badge!,
                      style: const TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
