import 'dart:developer' as developer;

import '../constants/app_strings.dart';

class AppLogger {
  AppLogger._();

  static void info(String message) {
    developer.log(message, name: AppStrings.logTag);
  }

  static void error(String message, {Object? error, StackTrace? stackTrace}) {
    developer.log(message, name: AppStrings.logTag, error: error, stackTrace: stackTrace, level: 1000);
  }
}
