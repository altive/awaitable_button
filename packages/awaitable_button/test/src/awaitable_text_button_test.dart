import 'package:awaitable_button/awaitable_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AwaitableTextButton', () {
    late Widget target;

    setUpAll(() {
      target = MaterialApp(
        home: AwaitableTextButton<void>(
          onPressed: () async {},
          child: const Text('AwaitableButton like TextButton'),
        ),
      );
    });

    testWidgets('Find a Text widget', (tester) async {
      await tester.pumpWidget(target);
      expect(find.byType(Text), findsOneWidget);
    });

    testWidgets('Find a TextButton', (tester) async {
      await tester.pumpWidget(target);
      expect(find.byType(TextButton), findsOneWidget);
      expect(find.byType(ElevatedButton), findsNothing);
      expect(find.byType(OutlinedButton), findsNothing);
      expect(find.byType(IconButton), findsNothing);
    });
  });
}
