import 'package:awaitable_button/awaitable_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AwaitableElevatedButton', () {
    late Widget target;

    setUpAll(() {
      target = MaterialApp(
        home: AwaitableElevatedButton<void>(
          onPressed: () async {},
          child: const Text('AwaitableButton like ElevatedButton'),
        ),
      );
    });

    testWidgets('Find Text widget', (tester) async {
      await tester.pumpWidget(target);
      expect(find.byType(Text), findsOneWidget);
    });

    testWidgets('Find a ElevatedButton', (tester) async {
      await tester.pumpWidget(target);
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.byType(TextButton), findsNothing);
      expect(find.byType(OutlinedButton), findsNothing);
      expect(find.byType(IconButton), findsNothing);
    });
  });
}
