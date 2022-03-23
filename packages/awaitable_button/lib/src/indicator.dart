import 'package:flutter/material.dart';

/// Indicator to be displayed during execution of asynchronous processing.
class Indicator extends StatelessWidget {
  /// Create an Indicator.
  const Indicator({
    Key? key,
    this.color,
  }) : super(key: key);

  /// CircularProgressIndicator Color.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(color),
        strokeWidth: 2,
      ),
    );
  }
}
