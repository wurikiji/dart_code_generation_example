import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'samples/auto_dispose.dart';

void main() {
  group('AutoDispose', () {
    test('can generate getter automatically', () {
      final widget = AutoDisposeController();
      // can access to the getter
      widget.controller;
    });

    testWidgets('can create instance', (tester) async {
      final widget = AutoDisposeController();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: widget),
        ),
      );
      expect(widget.controller, isNotNull);
    });

    testWidgets('has no problem using it', (tester) async {
      final globalKey = GlobalKey();
      final widget = AutoDisposeController(key: globalKey);
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: widget),
        ),
      );
      await tester.enterText(find.byType(TextField), 'hi');
      await tester.pumpAndSettle();
      final controller = widget.controller(globalKey.currentContext!);
      expect(controller.text, 'hi');
    });

    testWidgets('can dispose after the widget is unmounted', (tester) async {
      final globalKey = GlobalKey();
      final widget = AutoDisposeController(key: globalKey);
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: widget),
        ),
      );
      await tester.enterText(find.byType(TextField), 'hi');
      await tester.pumpAndSettle();
      // simulate widget unmount
      await tester.pumpWidget(Container());
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: widget),
        ),
      );
      final controller = widget.controller(globalKey.currentContext!);
      expect(controller.text, isEmpty);
    });

    testWidgets('can create multiple auto disposer', (tester) async {
      final widget = MultipleAutoDisposeTestWidget();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: widget),
        ),
      );
    });
  });
}
