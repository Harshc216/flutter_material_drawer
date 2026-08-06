import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_material_drawer/flutter_material_drawer.dart';

void main() {
  group('MaterialDrawerController Tests', () {
    test('initial selected index should be 0', () {
      final controller = MaterialDrawerController();
      expect(controller.selectedIndex, 0);
    });

    test('select should update index and notify listeners', () {
      final controller = MaterialDrawerController();
      int callCount = 0;
      controller.addListener(() {
        callCount++;
      });

      controller.select(2);
      expect(controller.selectedIndex, 2);
      expect(callCount, 1);

      // Selecting the same index should not notify again
      controller.select(2);
      expect(controller.selectedIndex, 2);
      expect(callCount, 1);
    });
  });
}
