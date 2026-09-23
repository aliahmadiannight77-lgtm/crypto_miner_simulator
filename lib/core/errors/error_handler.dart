/// Centralized application error handling.
///
/// This file converts technical exceptions into safe, predictable
/// application-level error information.
///
/// Important principles:
/// - User-facing messages must not expose internal implementation details.
/// - Expected [AppException] instances retain their original error code.
/// - Unexpected exceptions are normalized into a generic application error.
/// - Stack traces are preserved for diagnostics.
/// - No sensitive information should be written to user-facing messages.
library;

import 'dart:async';

import 'app_exception.dart';

/// A normalized representation of an error.
///
/// [AppError] is intentionally separate from [AppException]:
/// - [AppException] represents the original application failure.
/// - [AppError] represents the information the UI/error boundary needs.
///
/// This keeps UI code independent from the exact exception hierarchy.
final class AppError {
  const AppError({
    required this.code,
    required this.message,
    required this.userMessage,
    required this.isExpected,
    this.originalError,
    this.stackTrace,
  });

  /// Stable machine-readable error code.
  final String code;

  /// Technical error message.
  ///
  /// Intended for logs and diagnostics, not direct UI display.
  final String message;

  /// Safe message intended for the user.
  final String userMessage;

  /// Whether the error belongs to the expected application exception
  /// hierarchy.
  final bool isExpected;

  /// Original error object, when available.
  final Object? originalError;

  /// Stack trace associated with the error.
  final StackTrace? stackTrace;

  /// Creates a user-safe [AppError] from an arbitrary error.
  factory AppError.from(
    Object error, {
    StackTrace? stackTrace,
    String? fallbackUserMessage,
  }) {
    if (error is AppException) {
      return AppError(
        code: error.code,
        message: error.message,
        userMessage: error.displayMessage,
        isExpected: true,
        originalError: error,
        stackTrace: stackTrace ?? error.stackTrace,
      );
    }

    return AppError(
      code: 'UNEXPECTED_ERROR',
      message: error.toString(),
      userMessage:
          fallbackUserMessage ??
          ErrorHandler.defaultUnexpectedUserMessage,
      isExpected: false,
      originalError: error,
      stackTrace: stackTrace,
    );
  }

  /// Returns a concise representation suitable for diagnostics.
  @override
  String toString() {
    return 'AppError('
        'code: $code, '
        'expected: $isExpected, '
        'message: $message'
        ')';
  }
}

/// Centralized error handling utilities.
abstract final class ErrorHandler {
  ErrorHandler._();

  /// Default safe message used for unexpected failures.
  static const String defaultUnexpectedUserMessage =
      'Something went wrong. Please try again.';

  /// Safe Persian fallback for unexpected failures.
  static const String defaultUnexpectedPersianUserMessage =
      'خطایی غیرمنتظره رخ داد. لطفاً دوباره تلاش کنید.';

  /// Converts any error into a normalized [AppError].
  ///
  /// This method never throws while processing the supplied error.
  static AppError normalize(
    Object error, {
    StackTrace? stackTrace,
    String? fallbackUserMessage,
  }) {
    try {
      return AppError.from(
        error,
        stackTrace: stackTrace,
        fallbackUserMessage: fallbackUserMessage,
      );
    } catch (_) {
      // Error handling itself must never become the source of another
      // unhandled application failure.
      return AppError(
        code: 'ERROR_HANDLER_FAILURE',
        message: 'Failed to normalize an application error.',
        userMessage:
            fallbackUserMessage ??
            defaultUnexpectedUserMessage,
        isExpected: false,
        originalError: error,
        stackTrace: stackTrace,
      );
    }
  }

  /// Returns the safest user-facing message for an error.
  static String userMessage(
    Object error, {
    StackTrace? stackTrace,
    String? fallback,
  }) {
    return normalize(
      error,
      stackTrace: stackTrace,
      fallbackUserMessage: fallback,
    ).userMessage;
  }

  /// Returns the stable error code for an error.
  static String errorCode(
    Object error, {
    StackTrace? stackTrace,
  }) {
    return normalize(
      error,
      stackTrace: stackTrace,
    ).code;
  }

  /// Determines whether an error is an expected application failure.
  static bool isExpected(Object error) {
    return error is AppException;
  }

  /// Determines whether an error should be treated as unexpected.
  static bool isUnexpected(Object error) {
    return !isExpected(error);
  }

  /// Converts common low-level errors into application exceptions.
  ///
  /// This is intentionally conservative. Unknown errors are not guessed
  /// into a specific category because doing so can hide the actual cause.
  static AppException toAppException(
    Object error, {
    StackTrace? stackTrace,
    String? userMessage,
  }) {
    if (error is AppException) {
      return error;
    }

    if (error is FormatException) {
      return DataFormatException(
        message: error.message,
        userMessage: userMessage ?? 'داده دریافت‌شده معتبر نیست.',
        details: error.source,
        cause: error,
        stackTrace: stackTrace,
      );
    }

    if (error is TimeoutException) {
      return GenericAppException(
        code: 'TIMEOUT',
        message: error.message ?? 'The operation timed out.',
        userMessage:
            userMessage ??
            'عملیات بیش از حد طول کشید. لطفاً دوباره تلاش کنید.',
        cause: error,
        stackTrace: stackTrace,
      );
    }

    return GenericAppException(
      code: 'UNEXPECTED_ERROR',
      message: error.toString(),
      userMessage:
          userMessage ??
          defaultUnexpectedUserMessage,
      cause: error,
      stackTrace: stackTrace,
    );
  }

  /// Executes [operation] and converts unexpected failures into
  /// [AppException].
  ///
  /// Existing [AppException] instances are preserved without wrapping.
  static Future<T> runGuarded<T>(
    Future<T> Function() operation, {
    String? userMessage,
  }) async {
    try {
      return await operation();
    } catch (error, stackTrace) {
      throw toAppException(
        error,
        stackTrace: stackTrace,
        userMessage: userMessage,
      );
    }
  }

  /// Synchronous equivalent of [runGuarded].
  static T runGuardedSync<T>(
    T Function() operation, {
    String? userMessage,
  }) {
    try {
      return operation();
    } catch (error, stackTrace) {
      throw toAppException(
        error,
        stackTrace: stackTrace,
        userMessage: userMessage,
      );
    }
  }

  /// Executes an asynchronous operation and returns either its result or
  /// a normalized error.
  ///
  /// This is useful for repository/controller layers that prefer explicit
  /// result handling over throwing exceptions.
  static Future<({T? value, AppError? error})> tryRun<T>(
    Future<T> Function() operation, {
    String? fallbackUserMessage,
  }) async {
    try {
      final value = await operation();

      return (
        value: value,
        error: null,
      );
    } catch (error, stackTrace) {
      return (
        value: null,
        error: normalize(
          error,
          stackTrace: stackTrace,
          fallbackUserMessage: fallbackUserMessage,
        ),
      );
    }
  }

  /// Synchronous version of [tryRun].
  static ({T? value, AppError? error}) tryRunSync<T>(
    T Function() operation, {
    String? fallbackUserMessage,
  }) {
    try {
      final value = operation();

      return (
        value: value,
        error: null,
      );
    } catch (error, stackTrace) {
      return (
        value: null,
        error: normalize(
          error,
          stackTrace: stackTrace,
          fallbackUserMessage: fallbackUserMessage,
        ),
      );
    }
  }

  /// Produces a diagnostic string for developers.
  ///
  /// This must never be shown directly to normal users because it may contain
  /// implementation details.
  static String diagnosticMessage(
    Object error, {
    StackTrace? stackTrace,
  }) {
    final normalized = normalize(
      error,
      stackTrace: stackTrace,
    );

    final buffer = StringBuffer()
      ..writeln('Error code: ${normalized.code}')
      ..writeln('Expected: ${normalized.isExpected}')
      ..writeln('Message: ${normalized.message}');

    if (normalized.originalError != null &&
        normalized.originalError != error) {
      buffer
        ..writeln('Original error: ${normalized.originalError}');
    }

    if (normalized.stackTrace != null) {
      buffer
        ..writeln('Stack trace:')
        ..writeln(normalized.stackTrace);
    }

    return buffer.toString();
  }
}