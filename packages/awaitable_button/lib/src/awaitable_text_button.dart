import 'package:flutter/material.dart';

import 'awaitable_button.dart';

/// Button with indicator display during processing to prevent consecutive hits.
///
/// Setting an asynchronous function to [onPressed] will display an indicator
/// during execution and prevent pressing.
/// [whenComplete] is executed when [onPressed] completes
/// without throwing an exception
/// [child] specifies the string to be displayed on the button
/// If [executingChild] is specified, the string can be displayed
/// with the running indicator.
/// If [buttonStyle] is not specified, the value set in Theme
/// Use `ElevatedButtonThemeData` in `Theme.of(context)`.
class AwaitableTextButton<R> extends AwaitableButton<R> {
  /// Create an AwaitableButton.
  ///
  /// [child] arguments must not be null.
  const AwaitableTextButton({
    Key? key,
    required Future<R> Function()? onPressed,
    void Function(R)? whenComplete,
    ButtonStyle? buttonStyle,
    Color? indicatorColor,
    Widget? indicator,
    Widget? executingChild,
    required Widget child,
  }) : super(
          key: key,
          buttonType: ButtonType.text,
          onPressed: onPressed,
          whenComplete: whenComplete,
          buttonStyle: buttonStyle,
          indicatorColor: indicatorColor,
          indicator: indicator,
          executingChild: executingChild,
          child: child,
        );
}
