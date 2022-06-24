import 'package:awaitable_button/awaitable_button.dart';
import 'package:awaitable_button/src/awaitable_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('AwaitableElevatedButton is AwaitableButton', () {
    final awaitableElevatedButton = AwaitableElevatedButton<void>(
      onPressed: () async {},
      child: const Text('label'),
    );

    expect(awaitableElevatedButton, isA<AwaitableButton<void>>());
  });
  test('AwaitableOutlinedButton is AwaitableButton', () {
    final awaitableElevatedButton = AwaitableOutlinedButton<void>(
      onPressed: () async {},
      child: const Text('label'),
    );

    expect(awaitableElevatedButton, isA<AwaitableButton<void>>());
  });
  test('AwaitableTextButton is AwaitableButton', () {
    final awaitableElevatedButton = AwaitableTextButton<void>(
      onPressed: () async {},
      child: const Text('label'),
    );

    expect(awaitableElevatedButton, isA<AwaitableButton<void>>());
  });
  test('AwaitableFilledButton is AwaitableButton', () {
    final awaitableElevatedButton = AwaitableFilledButton<void>(
      onPressed: () async {},
      child: const Text('label'),
    );

    expect(awaitableElevatedButton, isA<AwaitableButton<void>>());
  });
  test('AwaitableFilledTonalButton is AwaitableButton', () {
    final awaitableElevatedButton = AwaitableFilledTonalButton<void>(
      onPressed: () async {},
      child: const Text('label'),
    );

    expect(awaitableElevatedButton, isA<AwaitableButton<void>>());
  });
  test('AwaitableFilledTonalButton is not AwaitableButton', () {
    final awaitableElevatedButton = AwaitableIconButton<void>(
      onPressed: () async {},
      icon: const Icon(Icons.label),
    );

    expect(awaitableElevatedButton is AwaitableButton<void>, isFalse);
  });
}
