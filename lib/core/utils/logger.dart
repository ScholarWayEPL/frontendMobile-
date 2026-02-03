import 'dart:developer' as developer;

/// Utilitaire de journalisation simple
class Logger {
  static void debug(String message, [String tag = 'ScholarWay']) {
    developer.log(message, name: tag, level: 500);
  }

  static void info(String message, [String tag = 'ScholarWay']) {
    developer.log(message, name: tag, level: 800);
  }

  static void warning(String message, [String tag = 'ScholarWay']) {
    developer.log(message, name: tag, level: 900);
  }

  static void error(
    String message, [
    String tag = 'ScholarWay',
    Object? error,
  ]) {
    developer.log(message, name: tag, level: 1000, error: error);
  }
}
