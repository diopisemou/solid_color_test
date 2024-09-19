// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:solid_color_test/main.dart';


void main() {
  testWidgets('Color change  smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const SolidRandomColorApp());

    // Verify that our initial text didn't change as we haven't tapped the '*' icon.
    expect(find.text('Hello there'), findsOneWidget);
    expect(find.text('Surprise! A new color has appeared.'), findsNothing);

    // Tap the '*' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.star));
    await tester.pump();

    // Verify that our text changed as we tapped the '*' icon.
    expect(find.text('Hello there'), findsNothing);
    expect(find.text('Surprise! A new color has appeared.'), findsOneWidget);

    print('Test executed successfully');
  });
}
