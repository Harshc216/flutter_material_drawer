import 'package:flutter/material.dart';

/// Provides common drawer animations.
class DrawerAnimation {
  DrawerAnimation._();

  /// Slide animation.
  static Widget slide({
    required Animation<double> animation,
    required Widget child,
  }) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
      child: child,
    );
  }

  /// Fade animation.
  static Widget fade({
    required Animation<double> animation,
    required Widget child,
  }) {
    return FadeTransition(opacity: animation, child: child);
  }

  /// Scale animation.
  static Widget scale({
    required Animation<double> animation,
    required Widget child,
  }) {
    return ScaleTransition(scale: animation, child: child);
  }
}
