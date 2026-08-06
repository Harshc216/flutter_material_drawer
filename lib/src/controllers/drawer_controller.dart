import 'package:flutter/foundation.dart';

/// Controls the selected drawer item.
class MaterialDrawerController extends ChangeNotifier {
  int _selectedIndex = 0;

  /// Currently selected menu index.
  int get selectedIndex => _selectedIndex;

  /// Updates the selected menu index.
  void select(int index) {
    if (_selectedIndex == index) return;

    _selectedIndex = index;
    notifyListeners();
  }
}
