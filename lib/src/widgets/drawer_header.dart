import 'package:flutter/material.dart';

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
  });

  final String name;
  final String email;
  final ImageProvider? image;
  final MaterialDrawerTheme theme;

  @override
  Widget build(BuildContext context) {
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
