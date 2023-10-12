import 'package:flutter/material.dart';

import 'extensions.dart';

/// Can wait for asynchronous processing.
mixin Awaitable<T extends StatefulWidget, R> on State<T> {
  /// True if the process is running.
  bool processing = false;

  /// Called when the button is tapped or otherwise activated.
  /// Return values can be used to pass values to [whenComplete].
  OnPressed<R> get onPressed;

  /// Callback when [onPressed] completes without throwing an exception.
  /// Receive the return value of [onPressed].
  WhenComplete<R>? get whenComplete;

  /// Callback when [onPressed] throws an exception.
  OnError? get onError;

  /// Process when the button is pressed.
  /// If it is being processed, nothing is done.
  /// If the button is not in process, [onPressed] is executed.
  /// Execute [whenComplete] when processing is complete.
  /// If an exception occurs during processing, [onError] is executed.
  Future<void> execute() async {
    if (processing) {
      // Do nothing while button action is being executed
      // (to prevent consecutive hits)
      return;
    }
    setState(() => processing = true);
    try {
      final r = await onPressed!.call();
      whenComplete?.call(r);
    } on Exception catch (e, s) {
      onError?.call(e, s);
    } finally {
      // Check for presence before execution in case you come back
      // from a screen transition, etc.
      if (mounted) {
        setState(() => processing = false);
      }
    }
  }
}
