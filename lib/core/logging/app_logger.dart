import 'dart:developer' as developer;

enum LogLevel { debug, info, warning, error }

/// Logging abstraction so features never depend on a concrete logger.
abstract interface class AppLogger {
  void log(
    LogLevel level,
    String message, {
    Object? error,
    StackTrace? stackTrace,
  });
}

extension AppLoggerX on AppLogger {
  void debug(String message) => log(LogLevel.debug, message);

  void info(String message) => log(LogLevel.info, message);

  void warning(String message, {Object? error}) =>
      log(LogLevel.warning, message, error: error);

  void error(String message, {Object? error, StackTrace? stackTrace}) =>
      log(LogLevel.error, message, error: error, stackTrace: stackTrace);
}

/// Writes to `dart:developer`, visible in DevTools and `flutter run` output.
/// No data leaves the device (ADR-018).
final class DeveloperLogger implements AppLogger {
  const DeveloperLogger({this.name = 'terrace_garden'});

  final String name;

  @override
  void log(
    LogLevel level,
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    developer.log(
      message,
      name: name,
      level: _severity(level),
      error: error,
      stackTrace: stackTrace,
    );
  }

  // Values follow package:logging levels, which DevTools understands.
  static int _severity(LogLevel level) => switch (level) {
    LogLevel.debug => 500,
    LogLevel.info => 800,
    LogLevel.warning => 900,
    LogLevel.error => 1000,
  };
}
