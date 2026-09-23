/// Application exception hierarchy.
///
/// All expected application-level failures should use one of the exception
/// types defined in this file.
///
/// Design goals:
/// - Keep technical error details separate from user-facing messages.
/// - Provide stable error codes for logging and diagnostics.
/// - Allow callers to distinguish validation, storage, game-logic, and
///   unexpected failures.
/// - Avoid exposing sensitive implementation details to users.
///
/// This application is an offline-first educational simulator, so these
/// exceptions are intentionally independent of HTTP/network-specific errors.
library;

/// Base exception for all expected application-level failures.
abstract class AppException implements Exception {
  /// Creates an application exception.
  const AppException({
    required this.code,
    required this.message,
    this.userMessage,
    this.details,
    this.cause,
    this.stackTrace,
  });

  /// Stable machine-readable error code.
  ///
  /// This value should remain stable because it may be used by logs,
  /// diagnostics, analytics, or future migrations.
  final String code;

  /// Technical description intended primarily for developers/logging.
  final String message;

  /// Safe message suitable for displaying to the user.
  ///
  /// If null, [message] may be used by the error handler depending on
  /// application policy.
  final String? userMessage;

  /// Optional structured details about the failure.
  ///
  /// Do not put passwords, tokens, private keys, or other sensitive data here.
  final Object? details;

  /// Original exception that caused this exception, when applicable.
  final Object? cause;

  /// Stack trace associated with the original failure, when applicable.
  final StackTrace? stackTrace;

  /// Returns the safest message for user-facing presentation.
  String get displayMessage => userMessage ?? message;

  /// Creates a copy of this exception while preserving its metadata.
  ///
  /// Subclasses should override this method when they need to preserve
  /// subtype-specific fields.
  AppException copyWith({
    String? code,
    String? message,
    String? userMessage,
    Object? details,
    Object? cause,
    StackTrace? stackTrace,
  }) {
    return GenericAppException(
      code: code ?? this.code,
      message: message ?? this.message,
      userMessage: userMessage ?? this.userMessage,
      details: details ?? this.details,
      cause: cause ?? this.cause,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }

  @override
  String toString() {
    final buffer = StringBuffer()
      ..write(runtimeType)
      ..write('(')
      ..write(code)
      ..write('): ')
      ..write(message);

    if (details != null) {
      buffer
        ..write(' | details: ')
        ..write(details);
    }

    if (cause != null) {
      buffer
        ..write(' | cause: ')
        ..write(cause);
    }

    return buffer.toString();
  }
}

/// Generic application exception.
///
/// Use this when a failure is known to be an application failure but does not
/// fit one of the more specific exception categories.
final class GenericAppException extends AppException {
  const GenericAppException({
    required super.code,
    required super.message,
    super.userMessage,
    super.details,
    super.cause,
    super.stackTrace,
  });

  @override
  GenericAppException copyWith({
    String? code,
    String? message,
    String? userMessage,
    Object? details,
    Object? cause,
    StackTrace? stackTrace,
  }) {
    return GenericAppException(
      code: code ?? this.code,
      message: message ?? this.message,
      userMessage: userMessage ?? this.userMessage,
      details: details ?? this.details,
      cause: cause ?? this.cause,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }
}

/// Thrown when user-provided input is invalid.
final class ValidationException extends AppException {
  const ValidationException({
    String code = 'VALIDATION_ERROR',
    required String message,
    String? userMessage,
    Object? details,
    Object? cause,
    StackTrace? stackTrace,
  }) : super(
          code: code,
          message: message,
          userMessage: userMessage,
          details: details,
          cause: cause,
          stackTrace: stackTrace,
        );

  @override
  ValidationException copyWith({
    String? code,
    String? message,
    String? userMessage,
    Object? details,
    Object? cause,
    StackTrace? stackTrace,
  }) {
    return ValidationException(
      code: code ?? this.code,
      message: message ?? this.message,
      userMessage: userMessage ?? this.userMessage,
      details: details ?? this.details,
      cause: cause ?? this.cause,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }
}

/// Thrown when local storage cannot be read or written correctly.
final class StorageException extends AppException {
  const StorageException({
    String code = 'STORAGE_ERROR',
    required String message,
    String? userMessage,
    Object? details,
    Object? cause,
    StackTrace? stackTrace,
  }) : super(
          code: code,
          message: message,
          userMessage: userMessage,
          details: details,
          cause: cause,
          stackTrace: stackTrace,
        );

  @override
  StorageException copyWith({
    String? code,
    String? message,
    String? userMessage,
    Object? details,
    Object? cause,
    StackTrace? stackTrace,
  }) {
    return StorageException(
      code: code ?? this.code,
      message: message ?? this.message,
      userMessage: userMessage ?? this.userMessage,
      details: details ?? this.details,
      cause: cause ?? this.cause,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }
}

/// Thrown when persisted data has an invalid or incompatible structure.
final class DataFormatException extends AppException {
  const DataFormatException({
    String code = 'DATA_FORMAT_ERROR',
    required String message,
    String? userMessage,
    Object? details,
    Object? cause,
    StackTrace? stackTrace,
  }) : super(
          code: code,
          message: message,
          userMessage: userMessage,
          details: details,
          cause: cause,
          stackTrace: stackTrace,
        );

  @override
  DataFormatException copyWith({
    String? code,
    String? message,
    String? userMessage,
    Object? details,
    Object? cause,
    StackTrace? stackTrace,
  }) {
    return DataFormatException(
      code: code ?? this.code,
      message: message ?? this.message,
      userMessage: userMessage ?? this.userMessage,
      details: details ?? this.details,
      cause: cause ?? this.cause,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }
}

/// Thrown when a requested entity does not exist.
final class NotFoundException extends AppException {
  const NotFoundException({
    String code = 'NOT_FOUND',
    required String message,
    String? userMessage,
    Object? details,
    Object? cause,
    StackTrace? stackTrace,
  }) : super(
          code: code,
          message: message,
          userMessage: userMessage,
          details: details,
          cause: cause,
          stackTrace: stackTrace,
        );

  @override
  NotFoundException copyWith({
    String? code,
    String? message,
    String? userMessage,
    Object? details,
    Object? cause,
    StackTrace? stackTrace,
  }) {
    return NotFoundException(
      code: code ?? this.code,
      message: message ?? this.message,
      userMessage: userMessage ?? this.userMessage,
      details: details ?? this.details,
      cause: cause ?? this.cause,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }
}

/// Thrown when an operation violates a game rule.
final class GameRuleException extends AppException {
  const GameRuleException({
    String code = 'GAME_RULE_ERROR',
    required String message,
    String? userMessage,
    Object? details,
    Object? cause,
    StackTrace? stackTrace,
  }) : super(
          code: code,
          message: message,
          userMessage: userMessage,
          details: details,
          cause: cause,
          stackTrace: stackTrace,
        );

  @override
  GameRuleException copyWith({
    String? code,
    String? message,
    String? userMessage,
    Object? details,
    Object? cause,
    StackTrace? stackTrace,
  }) {
    return GameRuleException(
      code: code ?? this.code,
      message: message ?? this.message,
      userMessage: userMessage ?? this.userMessage,
      details: details ?? this.details,
      cause: cause ?? this.cause,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }
}

/// Thrown when a currency conversion cannot be completed.
final class ConversionException extends AppException {
  const ConversionException({
    String code = 'CONVERSION_ERROR',
    required String message,
    String? userMessage,
    Object? details,
    Object? cause,
    StackTrace? stackTrace,
  }) : super(
          code: code,
          message: message,
          userMessage: userMessage,
          details: details,
          cause: cause,
          stackTrace: stackTrace,
        );

  @override
  ConversionException copyWith({
    String? code,
    String? message,
    String? userMessage,
    Object? details,
    Object? cause,
    StackTrace? stackTrace,
  }) {
    return ConversionException(
      code: code ?? this.code,
      message: message ?? this.message,
      userMessage: userMessage ?? this.userMessage,
      details: details ?? this.details,
      cause: cause ?? this.cause,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }
}

/// Thrown when a mining operation cannot be performed safely.
final class MiningException extends AppException {
  const MiningException({
    String code = 'MINING_ERROR',
    required String message,
    String? userMessage,
    Object? details,
    Object? cause,
    StackTrace? stackTrace,
  }) : super(
          code: code,
          message: message,
          userMessage: userMessage,
          details: details,
          cause: cause,
          stackTrace: stackTrace,
        );

  @override
  MiningException copyWith({
    String? code,
    String? message,
    String? userMessage,
    Object? details,
    Object? cause,
    StackTrace? stackTrace,
  }) {
    return MiningException(
      code: code ?? this.code,
      message: message ?? this.message,
      userMessage: userMessage ?? this.userMessage,
      details: details ?? this.details,
      cause: cause ?? this.cause,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }
}

/// Thrown when a requested upgrade is not valid.
final class UpgradeException extends AppException {
  const UpgradeException({
    String code = 'UPGRADE_ERROR',
    required String message,
    String? userMessage,
    Object? details,
    Object? cause,
    StackTrace? stackTrace,
  }) : super(
          code: code,
          message: message,
          userMessage: userMessage,
          details: details,
          cause: cause,
          stackTrace: stackTrace,
        );

  @override
  UpgradeException copyWith({
    String? code,
    String? message,
    String? userMessage,
    Object? details,
    Object? cause,
    StackTrace? stackTrace,
  }) {
    return UpgradeException(
      code: code ?? this.code,
      message: message,
      userMessage: userMessage ?? this.userMessage,
      details: details ?? this.details,
      cause: cause ?? this.cause,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }
}

/// Thrown when a reward cannot be granted safely.
final class RewardException extends AppException {
  const RewardException({
    String code = 'REWARD_ERROR',
    required String message,
    String? userMessage,
    Object? details,
    Object? cause,
    StackTrace? stackTrace,
  }) : super(
          code: code,
          message: message,
          userMessage: userMessage,
          details: details,
          cause: cause,
          stackTrace: stackTrace,
        );

  @override
  RewardException copyWith({
    String? code,
    String? message,
    String? userMessage,
    Object? details,
    Object? cause,
    StackTrace? stackTrace,
  }) {
    return RewardException(
      code: code ?? this.code,
      message: message,
      userMessage: userMessage ?? this.userMessage,
      details: details ?? this.details,
      cause: cause ?? this.cause,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }
}

/// Thrown when an operation exceeds a configured application limit.
final class LimitExceededException extends AppException {
  const LimitExceededException({
    String code = 'LIMIT_EXCEEDED',
    required String message,
    String? userMessage,
    Object? details,
    Object? cause,
    StackTrace? stackTrace,
  }) : super(
          code: code,
          message: message,
          userMessage: userMessage,
          details: details,
          cause: cause,
          stackTrace: stackTrace,
        );

  @override
  LimitExceededException copyWith({
    String? code,
    String? message,
    String? userMessage,
    Object? details,
    Object? cause,
    StackTrace? stackTrace,
  }) {
    return LimitExceededException(
      code: code ?? this.code,
      message: message ?? this.message,
      userMessage: userMessage ?? this.userMessage,
      details: details ?? this.details,
      cause: cause ?? this.cause,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }
}

/// Thrown when an operation is attempted in an invalid application state.
final class StateException extends AppException {
  const StateException({
    String code = 'INVALID_STATE',
    required String message,
    String? userMessage,
    Object? details,
    Object? cause,
    StackTrace? stackTrace,
  }) : super(
          code: code,
          message: message,
          userMessage: userMessage,
          details: details,
          cause: cause,
          stackTrace: stackTrace,
        );

  @override
  StateException copyWith({
    String? code,
    String? message,
    String? userMessage,
    Object? details,
    Object? cause,
    StackTrace? stackTrace,
  }) {
    return StateException(
      code: code ?? this.code,
      message: message ?? this.message,
      userMessage: userMessage ?? this.userMessage,
      details: details ?? this.details,
      cause: cause ?? this.cause,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }
}

/// Thrown when a required application configuration is invalid or missing.
final class ConfigurationException extends AppException {
  const ConfigurationException({
    String code = 'CONFIGURATION_ERROR',
    required String message,
    String? userMessage,
    Object? details,
    Object? cause,
    StackTrace? stackTrace,
  }) : super(
          code: code,
          message: message,
          userMessage: userMessage,
          details: details,
          cause: cause,
          stackTrace: stackTrace,
        );

  @override
  ConfigurationException copyWith({
    String? code,
    String? message,
    String? userMessage,
    Object? details,
    Object? cause,
    StackTrace? stackTrace,
  }) {
    return ConfigurationException(
      code: code ?? this.code,
      message: message ?? this.message,
      userMessage: userMessage ?? this.userMessage,
      details: details ?? this.details,
      cause: cause ?? this.cause,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }
}