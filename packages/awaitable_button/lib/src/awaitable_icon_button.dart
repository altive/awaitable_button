import 'package:flutter/material.dart';

import 'awaitable_button.dart';
import 'indicator.dart';

/// Button with indicator display during processing to prevent consecutive hits.
///
/// Setting an asynchronous function to [onPressed] will display an indicator
/// during execution and prevent pressing.
/// [whenComplete] is executed when [onPressed] completes
/// without throwing an exception
/// [icon] specifies the icon to be displayed on the button
/// If [executingIcon] is specified, the icon can be displayed
/// with the running indicator.
class AwaitableIconButton<R> extends StatefulWidget {
  /// Create an AwaitableIconButton.
  ///
  /// [icon] arguments must not be null.
  const AwaitableIconButton({
    Key? key,
    required this.onPressed,
    this.whenComplete,
    this.onError,
    this.executingIcon,
    this.iconSize,
    this.indicatorColor,
    this.indicator,
    required this.icon,
  })  : assert(
          indicatorColor == null || indicator == null,
          'Cannot specify both',
        ),
        super(key: key);

  /// Called when the button is tapped or otherwise activated.
  /// Return values can be used to pass values to [whenComplete].
  final OnPressed<R> onPressed;

  /// Callback when [onPressed] completes without throwing an exception.
  /// Receive the return value of [onPressed].
  final WhenComplete<R> whenComplete;

  /// Callback when [onPressed] throws an exception.
  final OnError onError;

  /// Size of the IconButton icon.
  final double? iconSize;

  /// Indicator color during asynchronous processing.
  /// Cannot be specified if [indicator] is specified.
  final Color? indicatorColor;

  /// Widget to display as an indicator during asynchronous processing.
  /// Cannot be specified when [indicatorColor] is specified.
  final Widget? indicator;

  /// Widget to display while running.
  ///
  /// Null by default.
  final Widget? executingIcon;

  /// The icon to display inside the button.
  ///
  /// This property must not be null.
  final Widget icon;

  @override
  _AwaitableIconButtonState<R> createState() => _AwaitableIconButtonState<R>();
}

class _AwaitableIconButtonState<R> extends State<AwaitableIconButton<R>> {
  var _isExecuting = false;

  @override
  Widget build(BuildContext context) {
    final indicator = widget.indicator ??
        Indicator(
          color: widget.indicatorColor ?? Theme.of(context).colorScheme.primary,
        );
    final executingIcon = widget.executingIcon;
    return IconButton(
      onPressed: widget.onPressed == null ? null : _onPressed,
      iconSize: widget.iconSize,
      icon: AnimatedSwitcher(
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
            : widget.icon,
      ),
    );
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
    } on Exception catch (e, s) {
      widget.onError?.call(e, s);
    } finally {
      // Check for presence before execution in case you come back
      // from a screen transition, etc.
      if (mounted) {
        setState(() => _isExecuting = false);
      }
    }
  }
}
