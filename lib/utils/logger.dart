import 'package:flutter/foundation.dart';

/// Simple logger utility for debugging
class Logger {
  static void log(String message, {String? tag}) {
    if (kDebugMode) {
      final timestamp = DateTime.now().toString().substring(11, 23);
      final logTag = tag != null ? '[$tag]' : '';
      debugPrint('[$timestamp]$logTag $message');
    }
  }

  static void error(String message, {String? tag, Object? error}) {
    if (kDebugMode) {
      final timestamp = DateTime.now().toString().substring(11, 23);
      final logTag = tag != null ? '[$tag]' : '';
      debugPrint('[$timestamp]$logTag ERROR: $message');
      if (error != null) {
        debugPrint('  └─ $error');
      }
    }
  }

  static void info(String message, {String? tag}) {
    log(message, tag: tag);
  }

  static void warning(String message, {String? tag}) {
    if (kDebugMode) {
      final timestamp = DateTime.now().toString().substring(11, 23);
      final logTag = tag != null ? '[$tag]' : '';
      debugPrint('[$timestamp]$logTag WARNING: $message');
    }
  }
}
