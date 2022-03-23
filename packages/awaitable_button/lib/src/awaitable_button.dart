import 'package:flutter/material.dart';

import 'indicator.dart';

/// ButtonType has ElevatedButton, OutlinedButton, TextButton types.
enum ButtonType {
  /// Use ElevatedButton
  elevated,

  /// Use OutlinedButton
  outlined,

  /// Use TextButton
  text,
}

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
  final Future<R> Function()? onPressed;

  /// Callback when [onPressed] completes without throwing an exception.
  /// Receive the return value of [onPressed].
  final void Function(R)? whenComplete;

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

class _AwaitableButtonState<R> extends State<AwaitableButton<R>> {
  var _isExecuting = false;

  @override
  Widget build(BuildContext context) {
    final onPressed = widget.onPressed == null ? null : _onPressed;
    final style =
        widget.buttonStyle ?? Theme.of(context).elevatedButtonTheme.style;
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
      child: _isExecuting
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

    switch (widget.buttonType) {
      case ButtonType.elevated:
        return ElevatedButton(
          onPressed: onPressed,
          style: style,
          child: child,
        );
      case ButtonType.outlined:
        return OutlinedButton(
          onPressed: onPressed,
          style: style,
          child: child,
        );
      case ButtonType.text:
        return TextButton(
          onPressed: onPressed,
          style: style,
          child: child,
        );
    }
  }

  Future<void> _onPressed() async {
    if (_isExecuting) {
      // Do nothing while button action is being executed
      // (to prevent consecutive hits)
      return;
    }
    setState(() => _isExecuting = true);
    try {
      final r = await widget.onPressed!.call();
      widget.whenComplete?.call(r);
    } finally {
      // Check for presence before execution in case you come back
      // from a screen transition, etc.
      if (mounted) {
        setState(() => _isExecuting = false);
      }
    }
  }
}
