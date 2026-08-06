// This is a basic Flutter widget test for the example application.
// Verify drawer behaviors using WidgetTester.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:example/main.dart';

void main() {
  testWidgets('Drawer App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the Dashboard is displayed on startup.
    expect(find.text('Dashboard'), findsWidgets);

    // Verify that the left drawer is closed initially (cannot find the email).
    expect(find.text('jane.doe@example.com'), findsNothing);

    // Tap the menu icon to open the left drawer.
    final menuIcon = find.byIcon(Icons.menu_rounded);
    expect(menuIcon, findsOneWidget);
    await tester.tap(menuIcon);
    await tester.pumpAndSettle();

    // Verify that the left drawer is now open and displays the user's email.
    expect(find.text('jane.doe@example.com'), findsOneWidget);
  });
}
