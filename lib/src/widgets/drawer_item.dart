import 'package:flutter/material.dart';

import '../enums/drawer_type.dart';
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
    this.type = DrawerType.classic,
  });

  final DrawerMenuItem item;
  final bool selected;
  final VoidCallback onTap;
  final MaterialDrawerTheme theme;
  final DrawerType type;

  @override
  Widget build(BuildContext context) {
    final isTwitter = type == DrawerType.twitter;

    // Twitter style has transparent background (no pill capsule) and brand color highlight for selected items
    final itemBgColor = isTwitter
        ? (selected ? theme.selectedColor.withValues(alpha: 0.06) : Colors.transparent)
        : (selected ? theme.selectedColor : Colors.transparent);

    final itemTextColor = isTwitter
        ? (selected ? theme.selectedColor : theme.unselectedColor)
        : (selected ? Colors.white : theme.unselectedColor);

    final itemIconColor = isTwitter
        ? (selected ? theme.selectedColor : theme.iconColor)
        : (selected ? theme.selectedIconColor : theme.iconColor);

    final itemFontWeight = isTwitter
        ? (selected ? FontWeight.bold : FontWeight.w400)
        : (selected ? FontWeight.bold : FontWeight.w500);

    final itemRadius = isTwitter ? 28.0 : theme.itemRadius;

    final padding = isTwitter
        ? const EdgeInsets.symmetric(horizontal: 16, vertical: 3)
        : DrawerConstants.itemPadding;

    return Padding(
      padding: padding,
      child: Material(
        color: itemBgColor,
        borderRadius: BorderRadius.circular(itemRadius),
        child: InkWell(
          borderRadius: BorderRadius.circular(itemRadius),
          onTap: item.enabled ? onTap : null,
          child: Container(
            height: isTwitter ? 48 : DrawerConstants.itemHeight,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(
                  item.icon,
                  size: isTwitter ? 22 : DrawerConstants.iconSize,
                  color: itemIconColor,
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    item.title,
                    style: TextStyle(
                      fontSize: isTwitter ? 16 : 16,
                      color: itemTextColor,
                      fontWeight: itemFontWeight,
                      fontFamily: isTwitter ? 'Roboto' : null,
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
                      color: isTwitter ? theme.selectedColor : Colors.red,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      item.badge!,
                      style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
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
