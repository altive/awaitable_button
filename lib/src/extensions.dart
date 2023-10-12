/// `onPressed` callback type.
typedef OnPressed<R> = Future<R> Function()?;

/// `whenComplete` callback type.
typedef WhenComplete<R> = void Function(R)?;

/// `onError` callback type.
typedef OnError = void Function(Exception, StackTrace)?;
