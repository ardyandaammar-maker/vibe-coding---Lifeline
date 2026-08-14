// This is a basic Flutter widget test.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lifeline/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const LifelineApp());

    // Verify that the app builds without crashing.
    // The initial screen should be the Welcome Screen or Onboarding.
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
