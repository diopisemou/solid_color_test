// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:solid_color_test/app/solid_random_color_app.dart';

void main() {
  const testedWiget = SolidRandomColorApp();
  testWidgets('Color change  smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.

    await tester.pumpWidget(testedWiget);

    // Verify that our initial text didn't change
    // as we haven't tapped the '*' icon.
    // we also check that the initial color is white
    expect(find.text('Hello there'), findsOneWidget);
    expect(find.text('RGB: (0, 0, 0)'), findsOneWidget);
    expect(find.text('Surprise! A new color has appeared.'), findsNothing);

    // Tap the Gesture detector icon and trigger a frame.
    // Find the GestureDetector
    final gestureDetector = find.byType(GestureDetector).first;

    await tester.tap(gestureDetector);
    await tester.pumpAndSettle();

    // Verify that our initial text didn't change
    // but that the color has changed from the initial white color.
    expect(find.textContaining('Hello there'), findsAtLeast(1));
    expect(find.text('RGB: (0, 0, 0)'), findsNothing);

    // Tap the '*' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.star));
    await tester.pump();

    // Verify that our text changed as we tapped the '*' icon.
    expect(find.text('Hello there'), findsNothing);
    expect(find.text('RGB: (0, 0, 0)'), findsNothing);
    expect(find.text('Surprise! A new color has appeared.'), findsOneWidget);

    tester.verifyTickersWereDisposed();
  });
}
