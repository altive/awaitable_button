import 'package:flutter/material.dart';

import 'awaitable.dart';
import 'button_type.dart';
import 'extensions.dart';
import 'indicator.dart';

extension on ButtonType {
  bool get isElevated => this == ButtonType.elevated;
}

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
abstract class AwaitableButton<R> extends StatefulWidget {
  /// Create an AwaitableButton.
  ///
  /// [child] arguments must not be null.
  const AwaitableButton({
    Key? key,
    required this.buttonType,
    required this.onPressed,
    this.whenComplete,
    this.onError,
    this.buttonStyle,
    this.indicatorColor,
    this.indicator,
    this.executingChild,
    required this.child,
  })  : assert(
          indicatorColor == null || indicator == null,
          'Cannot specify both',
        ),
        super(key: key);

  /// ButtonType has ElevatedButton, OutlinedButton, TextButton types.
  final ButtonType buttonType;

  /// Called when the button is tapped or otherwise activated.
  /// Return values can be used to pass values to [whenComplete].
  final OnPressed<R> onPressed;

  /// Callback when [onPressed] completes without throwing an exception.
  /// Receive the return value of [onPressed].
  final WhenComplete<R> whenComplete;

  /// Callback when [onPressed] throws an exception.
  final OnError onError;

  /// Customizes this button's appearance.
  ///
  /// Null by default.
  final ButtonStyle? buttonStyle;

  /// Indicator color during asynchronous processing.
  /// Cannot be specified if [indicator] is specified.
  final Color? indicatorColor;

  /// Widget to display as an indicator during asynchronous processing.
  /// Cannot be specified when [indicatorColor] is specified.
  final Widget? indicator;

  /// Widget to display while running.
  ///
  /// Null by default.
  final Widget? executingChild;

  /// Typically the button's label.
  final Widget child;

  @override
  _AwaitableButtonState<R> createState() => _AwaitableButtonState<R>();
}

class _AwaitableButtonState<R> extends State<AwaitableButton<R>>
    with Awaitable<AwaitableButton<R>, R> {
  @override
  OnPressed<R>? get onPressed => widget.onPressed;

  @override
  WhenComplete<R>? get whenComplete => widget.whenComplete;

  @override
  OnError? get onError => widget.onError;

  @override
  Widget build(BuildContext context) {
    final indicator = widget.indicator ??
        Indicator(
          color: widget.indicatorColor ??
              (widget.buttonType.isElevated
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.primary),
        );
    final executingIcon = widget.executingChild;
    final child = AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      child: processing
          ? executingIcon == null
              ? indicator
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    indicator,
                    const SizedBox(width: 8),
                    executingIcon,
                  ],
                )
          : widget.child,
    );

    final p = onPressed == null ? null : execute;
    final splashFactory = processing ? NoSplash.splashFactory : null;

    switch (widget.buttonType) {
      case ButtonType.elevated:
        return ElevatedButton(
          onPressed: p,
          style: widget.buttonStyle?.copyWith(splashFactory: splashFactory) ??
              Theme.of(context).elevatedButtonTheme.style?.copyWith(
                    splashFactory: splashFactory,
                  ),
          child: child,
        );
      case ButtonType.outlined:
        return OutlinedButton(
          onPressed: p,
          style: widget.buttonStyle?.copyWith(splashFactory: splashFactory) ??
              Theme.of(context).outlinedButtonTheme.style?.copyWith(
                    splashFactory: splashFactory,
                  ),
          child: child,
        );
      case ButtonType.text:
        return TextButton(
          onPressed: p,
          style: widget.buttonStyle?.copyWith(splashFactory: splashFactory) ??
              Theme.of(context).textButtonTheme.style?.copyWith(
                    splashFactory: splashFactory,
                  ),
          child: child,
        );
    }
  }
}
