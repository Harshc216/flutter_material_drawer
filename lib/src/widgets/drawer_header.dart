import 'package:flutter/material.dart';

import '../enums/drawer_type.dart';
import '../utils/drawer_constants.dart';
import '../utils/drawer_theme.dart';

/// Drawer header widget.
class DrawerHeaderWidget extends StatelessWidget {
  const DrawerHeaderWidget({
    super.key,
    required this.name,
    required this.email,
    this.image,
    required this.theme,
    this.type = DrawerType.classic,
    this.handle,
    this.followingCount,
    this.followersCount,
  });

  final String name;
  final String email;
  final ImageProvider? image;
  final MaterialDrawerTheme theme;
  final DrawerType type;
  final String? handle;
  final int? followingCount;
  final String? followersCount;

  @override
  Widget build(BuildContext context) {
    if (type == DrawerType.twitter) {
      final textStylePrimary = TextStyle(
        color: theme.unselectedColor,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      );
      final textStyleSecondary = TextStyle(
        color: theme.unselectedColor.withValues(alpha: 0.6),
        fontSize: 14,
      );

      return Container(
        width: double.infinity,
        color: theme.backgroundColor,
        padding: const EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 8),
        child: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 28,
                backgroundImage: image,
                backgroundColor: theme.selectedColor.withValues(alpha: 0.1),
                child: image == null
                    ? Icon(Icons.person_rounded, size: 28, color: theme.selectedColor)
                    : null,
              ),
              const SizedBox(height: 12),
              Text(
                name,
                style: textStylePrimary.copyWith(fontSize: 18),
              ),
              const SizedBox(height: 2),
              Text(
                handle ?? '@${email.split('@')[0]}',
                style: textStyleSecondary,
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${followingCount ?? 0} ',
                          style: textStylePrimary.copyWith(fontSize: 14),
                        ),
                        TextSpan(
                          text: 'Following',
                          style: textStyleSecondary,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 18),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${followersCount ?? '0'} ',
                          style: textStylePrimary.copyWith(fontSize: 14),
                        ),
                        TextSpan(
                          text: 'Followers',
                          style: textStyleSecondary,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    // Default horizontal layout for classic and other drawer styles
    return Container(
      height: DrawerConstants.headerHeight,
      width: double.infinity,
      decoration: BoxDecoration(color: theme.headerColor),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 35,
                backgroundImage: image,
                child: image == null
                    ? const Icon(Icons.person, size: 35, color: Colors.white)
                    : null,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      email,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
