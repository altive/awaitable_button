import 'package:flutter/material.dart';

/// Indicator to be displayed during execution of asynchronous processing.
class Indicator extends StatelessWidget {
  /// Create an Indicator.
  const Indicator({
    super.key,
    this.color,
    this.size,
    this.strokeWidth,
  });

  /// CircularProgressIndicator color.
  final Color? color;

  /// CircularProgressIndicator size.
  final Size? size;

  /// CircularProgressIndicator strokeWidth.
  final double? strokeWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: size ?? const Size.square(24),
      child: CircularProgressIndicator.adaptive(
        valueColor: color == null ? null : AlwaysStoppedAnimation(color),
        strokeWidth: strokeWidth ?? 4,
      ),
    );
  }
}
