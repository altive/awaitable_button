import 'package:awaitable_button/awaitable_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AwaitableIconButton', () {
    late Widget target;

    setUpAll(() {
      target = MaterialApp(
        home: Scaffold(
          body: AwaitableIconButton<void>(
            onPressed: () async {},
            icon: const Icon(Icons.abc),
          ),
        ),
      );
    });

    testWidgets('Find Icon', (tester) async {
      await tester.pumpWidget(target);
      expect(find.byType(Icon), findsOneWidget);
    });

    testWidgets('Find a IconButton', (tester) async {
      await tester.pumpWidget(target);
      expect(find.byType(IconButton), findsOneWidget);
      expect(find.byType(ElevatedButton), findsNothing);
      expect(find.byType(TextButton), findsNothing);
      expect(find.byType(OutlinedButton), findsNothing);
    });
  });
}
