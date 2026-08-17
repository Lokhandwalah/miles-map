import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:miles_map/app.dart';
import 'package:miles_map/features/onboarding/presentation/views/onboarding_view.dart';

void main() {
  testWidgets('App navigates from splash to onboarding after delay', (
    WidgetTester tester,
  ) async {
    // OnboardingView is laid out for a phone-sized viewport (Figma's
    // reference frame is 375x812). The default test surface (800x600) is
    // shorter than that and would trip a spurious overflow that can't
    // happen on a real device, so pin a realistic phone size here.
    tester.view.physicalSize = const Size(375, 812);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const App());

    expect(find.byType(OnboardingView), findsNothing);

    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.byType(OnboardingView), findsOneWidget);
  });
}
