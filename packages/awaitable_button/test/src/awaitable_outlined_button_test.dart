import 'package:awaitable_button/awaitable_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AwaitableOutlinedButton', () {
    late Widget target;

    setUpAll(() {
      target = MaterialApp(
        home: AwaitableOutlinedButton<void>(
          onPressed: () async {},
          child: const Text('AwaitableButton like OutlinedButton'),
        ),
      );
    });

    testWidgets('Find Text widget', (tester) async {
      await tester.pumpWidget(target);
      expect(find.byType(Text), findsOneWidget);
    });

    testWidgets('Find a OutlinedButton', (tester) async {
      await tester.pumpWidget(target);
      expect(find.byType(OutlinedButton), findsOneWidget);
      expect(find.byType(TextButton), findsNothing);
      expect(find.byType(ElevatedButton), findsNothing);
      expect(find.byType(IconButton), findsNothing);
    });
  });
}
