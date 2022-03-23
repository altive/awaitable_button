# Awaitable Button

## Features

Button with indicator display during processing to prevent consecutive hits.

## Getting started

```pubspec.yaml
awaitable_button: any
```

## Usage

import 'package:awaitable_button/awaitable_button.dart';

```dart
@override
Widget build(BuildContext context) {
    return AwaitableElevatedButton<String>(
      // Required
      onPressed: () {
        // do something
      },
      // Optional
      whenComplete: (value) {
        // do something
      },
      // Optional
      onError: (exception, stackTrace) {
        // do something
      },
      // Optional
      buttonStyle: ElevatedButton.styleFrom(),
      // Optional
      indicator: CircularProgressIndicator(),
      // Optional
      executingChild: const Text('Executing...'),
      // Required
      child: const Text('Button'),
    );
}
```

```dart
@override
Widget build(BuildContext context) {
    return AwaitableTextButton<String>(
      // Required
      onPressed: () {
        // do something
      },
      // Optional
      whenComplete: (value) {
        // do something (Optional)
      },
      // Optional
      onError: (exception, stackTrace) {
        // do something
      },
      // Optional
      buttonStyle: TextButton.styleFrom(),
      // Optional
      indicator: CircularProgressIndicator(),
      // Optional
      executingChild: const Text('Executing...'),
      // Required
      child: const Text('Button'),
    );
}
```

```dart
@override
Widget build(BuildContext context) {
    return AwaitableIconButton<String>(
      // Required
      onPressed: () {
        // do something
      },
      // Optional
      whenComplete: (value) {
        // do something
      },
      // Optional
      executingIcon: const Icon(Icons.timer_sharp),
      // Required
      icon: const Icon(Icons.timer),
    );
}
```
