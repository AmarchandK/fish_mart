import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fish_mart/presentation/widgets/category_card.dart';

void main() {
  group('CategoryCard Widget Tests', () {
    testWidgets('should display category name and icon',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CategoryCard(
              name: 'Sea Fish',
              icon: Icons.waves,
              color: Colors.blue,
              onTap: () {},
            ),
          ),
        ),
      );

      // Verify category name is displayed
      expect(find.text('Sea Fish'), findsOneWidget);

      // Verify icon is displayed
      expect(find.byIcon(Icons.waves), findsOneWidget);
    });

    testWidgets('should handle tap events', (WidgetTester tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CategoryCard(
              name: 'Boat Fish',
              icon: Icons.sailing,
              color: Colors.green,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      // Tap the category card
      await tester.tap(find.byType(CategoryCard));
      await tester.pump();

      // Verify tap was handled
      expect(tapped, true);
    });

    testWidgets('should apply correct colors', (WidgetTester tester) async {
      const testColor = Colors.red;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CategoryCard(
              name: 'Meat Products',
              icon: Icons.restaurant,
              color: testColor,
              onTap: () {},
            ),
          ),
        ),
      );

      // Find the icon container (second container)
      final containers = find.descendant(
        of: find.byType(CategoryCard),
        matching: find.byType(Container),
      );

      final iconContainer = tester.widget<Container>(containers.at(1));

      // Verify color is applied correctly
      final decoration = iconContainer.decoration as BoxDecoration;
      expect(decoration.color, testColor);
    });

    testWidgets('should handle long text properly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CategoryCard(
              name: 'Very Long Category Name That Should Be Truncated',
              icon: Icons.anchor,
              color: Colors.orange,
              onTap: () {},
            ),
          ),
        ),
      );

      // Verify text is displayed (it should be truncated by the widget)
      expect(find.textContaining('Very Long Category'), findsOneWidget);
    });
  });
}
