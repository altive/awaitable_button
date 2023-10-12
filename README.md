# Awaitable Button

## Features

Button with indicator display during processing to prevent consecutive hits.

## Web demo for awaitable_button/example

You can try out the interactive buttons on the demo page below.

https://altive.github.io/awaitable_button/

## Getting started

```pubspec.yaml
awaitable_button: any
```

## Usage
```dart
import 'package:awaitable_button/awaitable_button.dart';
```

This package includes the following buttons.
Use them according to your style.

- `AwaitableElevatedButton`
- `AwaitableOutlinedButton`
- `AwaitableTextButton`
- `AwaitableFilledButton`
- `AwaitableFilledTonalButton`

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
      indicatorColor: Colors.green,
      // Optional
      indicatorSize: Size.square(24),
      // Optional
      executingChild: const Text('Executing...'),
      // Required
      child: const Text('Button'),
    );
}
```

`AwaitableOutlinedButton`, `AwaitableTextButton`, `AwaitableFilledButton` and `AwaitableFilledTonalButton` is exactly the same as for `AwaitableElevatedButton`.

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
      onError: (exception, stackTrace) {
        // do something
      },
      // Optional
      iconSize: 24,
      // Optional
      indicator: CircularProgressIndicator(),
      // Optional
      indicatorColor: Colors.green,
      // Optional
      indicatorSize: Size.square(24),
      // Optional
      executingIcon: const Icon(Icons.timer_sharp),
      // Required
      icon: const Icon(Icons.timer),
    );
}
```
