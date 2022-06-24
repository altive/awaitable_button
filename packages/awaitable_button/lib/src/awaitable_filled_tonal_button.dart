import 'awaitable_button.dart';
import 'button_type.dart';

/// Button with indicator display during processing to prevent consecutive hits.
///
/// Setting an asynchronous function to [onPressed] will display an indicator
/// during execution and prevent pressing.
/// [whenComplete] is executed when [onPressed] completes
/// without throwing an exception
/// [child] specifies the string to be displayed on the button
/// If [executingChild] is specified, the string can be displayed
/// with the running indicator.
///
/// Since `FilledTonalButton` is not yet implemented in Flutter,
/// an `ElevatedButtonThemeData` adjusted to
/// look like a `FilledTonalButton` will be used internally.
/// https://github.com/flutter/flutter/issues/99022#issuecomment-1102992302
class AwaitableFilledTonalButton<R> extends AwaitableButton<R> {
  /// Create an AwaitableFilledTonalButton.
  ///
  /// [onPressed] and [child] arguments must not be null.
  /// If [indicator] is specified,
  /// [indicatorColor] and [indicatorSize] cannot be specified.
  /// If both [indicator] and [indicatorSize] are null,
  /// the size of the Indicator is `Size.square(24)`.
  const AwaitableFilledTonalButton({
    super.key,
    required super.onPressed,
    super.whenComplete,
    super.onError,
    super.buttonStyle,
    super.indicatorColor,
    super.indicatorSize,
    super.indicator,
    super.executingChild,
    required super.child,
  }) : super(
          buttonType: ButtonType.filledTonal,
        );
}
