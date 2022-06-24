import 'package:flutter/material.dart';

/// Indicator to be displayed during execution of asynchronous processing.
class Indicator extends StatelessWidget {
  /// Create an Indicator.
  const Indicator({
    super.key,
    this.color,
    this.size,
  });

  /// CircularProgressIndicator color.
  final Color? color;

  /// CircularProgressIndicator size.
  final Size? size;

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: size,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(color),
        strokeWidth: 2,
      ),
    );
  }
}
