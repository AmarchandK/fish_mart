import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fish_mart/presentation/app/fish_mart_app.dart';

void main() {
  group('Fish Mart App Tests', () {
    testWidgets('App should start and show splash screen',
        (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const FishMartApp());

      // Verify that the splash screen is shown initially
      expect(find.text('Fish Mart'), findsOneWidget);
      expect(find.text('Fresh Fish & Seafood Delivery'), findsOneWidget);
    });

    testWidgets('Splash screen should have loading indicator',
        (WidgetTester tester) async {
      await tester.pumpWidget(const FishMartApp());

      // Verify loading indicator is present
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('App should have proper theme colors',
        (WidgetTester tester) async {
      await tester.pumpWidget(const FishMartApp());

      // Get the MaterialApp widget
      final MaterialApp materialApp = tester.widget(find.byType(MaterialApp));

      // Verify theme configuration
      expect(materialApp.theme, isNotNull);
      expect(materialApp.darkTheme, isNotNull);
      expect(materialApp.themeMode, ThemeMode.system);
    });
  });
}
