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
class MaterialDrawer extends StatefulWidget {
  const MaterialDrawer({
    super.key,
    required this.controller,
    required this.items,
    required this.name,
    required this.email,
    this.image,
    this.theme = const MaterialDrawerTheme(),
    this.type = DrawerType.classic,
    this.handle,
    this.followingCount,
    this.followersCount,
    this.onProfileTap,
    this.onThemeToggle,
    this.width,
    this.maxItems,
  });

  final MaterialDrawerController controller;

  final List<DrawerMenuItem> items;

  final String name;

  final String email;

  final ImageProvider? image;

  final MaterialDrawerTheme theme;

  final DrawerType type;

  /// Handle for Twitter profile style (e.g. @username)
  final String? handle;

  /// Number of accounts the profile is following (Twitter style)
  final int? followingCount;

  /// Number of followers (Twitter style)
  final String? followersCount;

  /// Callback when profile header/avatar is tapped (Twitter style)
  final VoidCallback? onProfileTap;

  /// Callback when theme toggle button is tapped (Twitter style)
  final VoidCallback? onThemeToggle;

  /// Custom width for the drawer
  final double? width;

  /// Maximum number of items to show initially before collapsing.
  /// If null, all items are shown.
  final int? maxItems;

  @override
  State<MaterialDrawer> createState() => _MaterialDrawerState();
}

class _MaterialDrawerState extends State<MaterialDrawer> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final showCollapse = widget.maxItems != null && widget.items.length > widget.maxItems!;
    
    // Calculate how many items to display
    final int displayCount;
    if (showCollapse) {
      if (_isExpanded) {
        displayCount = widget.items.length + 1; // all items + "See Less"
      } else {
        displayCount = widget.maxItems!; // maxItems (first N-1 items + "See All")
      }
    } else {
      displayCount = widget.items.length;
    }

    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Drawer(
          width: widget.width ?? DrawerConstants.drawerWidth,
          elevation: widget.theme.elevation,
          shape: _shape(),
          child: Container(
            decoration: _decoration(),
            child: Column(
              children: [
                DrawerHeaderWidget(
                  name: widget.name,
                  email: widget.email,
                  image: widget.image,
                  theme: widget.theme,
                  type: widget.type,
                  handle: widget.handle,
                  followingCount: widget.followingCount,
                  followersCount: widget.followersCount,
                  onProfileTap: widget.onProfileTap,
                ),

                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: displayCount,
                    separatorBuilder: (context, index) =>
                        DrawerDividerWidget(theme: widget.theme),
                    itemBuilder: (context, index) {
                      if (showCollapse) {
                        if (!_isExpanded && index == widget.maxItems! - 1) {
                          // Render "See All" button
                          return DrawerItem(
                            item: DrawerMenuItem(
                              title: 'See All',
                              icon: Icons.keyboard_arrow_down_rounded,
                              onTap: () {
                                setState(() {
                                  _isExpanded = true;
                                });
                              },
                            ),
                            selected: false,
                            theme: widget.theme,
                            type: widget.type,
                            onTap: () {
                              setState(() {
                                _isExpanded = true;
                              });
                            },
                          );
                        } else if (_isExpanded && index == widget.items.length) {
                          // Render "See Less" button
                          return DrawerItem(
                            item: DrawerMenuItem(
                              title: 'See Less',
                              icon: Icons.keyboard_arrow_up_rounded,
                              onTap: () {
                                setState(() {
                                  _isExpanded = false;
                                });
                              },
                            ),
                            selected: false,
                            theme: widget.theme,
                            type: widget.type,
                            onTap: () {
                              setState(() {
                                _isExpanded = false;
                              });
                            },
                          );
                        }
                      }

                      final item = widget.items[index];

                      return DrawerItem(
                        item: item,
                        selected: widget.controller.selectedIndex == index,
                        theme: widget.theme,
                        type: widget.type,
                        onTap: () {
                          widget.controller.select(index);

                          Navigator.pop(context);

                          item.onTap?.call();
                        },
                      );
                    },
                  ),
                ),

                if (widget.type == DrawerType.twitter) ...[
                  Divider(
                    color: widget.theme.dividerColor,
                    height: 1,
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            isDark
                                ? Icons.light_mode_rounded
                                : Icons.dark_mode_rounded,
                            color: widget.theme.unselectedColor.withValues(alpha: 0.6),
                          ),
                          onPressed: widget.onThemeToggle,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.qr_code_rounded,
                            color: widget.theme.unselectedColor.withValues(alpha: 0.6),
                          ),
                          onPressed: () {
                            // QR Code action callback
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  ShapeBorder? _shape() {
    switch (widget.type) {
      case DrawerType.rounded:
        return const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(right: Radius.circular(30)),
        );

      default:
        return null;
    }
  }

  Decoration? _decoration() {
    switch (widget.type) {
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
      case DrawerType.twitter:
        return BoxDecoration(color: widget.theme.backgroundColor);
    }
  }
}
