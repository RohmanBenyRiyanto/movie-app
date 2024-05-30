import 'package:logger/logger.dart';

/// A helper class for logging messages with different severity levels using
/// the `logger` package. This class provides static methods to log messages
/// as debug, info, warning, error, verbose, and WTF (What a Terrible Failure).
class Print {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: false,
    ),
  );

  /// Logs a debug message.
  ///
  ///* [message]: The message to log.
  static void debug(String message) {
    _logger.d(message);
  }

  /// Logs an informational message.
  ///
  ///* [message]: The message to log.
  static void info(String message) {
    _logger.i(message);
  }

  /// Logs a warning message.
  ///
  ///* [message]: The message to log.
  static void warning(String message) {
    _logger.w(message);
  }

  /// Logs an error message.
  ///
  ///* [message]: The message to log.
  ///* [error]: An optional error object associated with this log entry.
  ///* [stackTrace]: An optional stack trace associated with this log entry.
  static void error(String message, {Object? error, StackTrace? stackTrace}) {
    _logger.e(
      message,
      time: DateTime.now(),
      error: error,
      stackTrace: stackTrace,
    );
  }
}
