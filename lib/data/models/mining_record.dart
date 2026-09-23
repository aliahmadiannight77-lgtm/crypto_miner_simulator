/// Represents a single virtual mining record.
///
/// This model is used for statistics, history, auditing and
/// calculating the user's simulated mining activity.
///
/// It does NOT represent real blockchain mining.
class MiningRecord {
  final String id;
  final String currencyId;

  /// Amount of virtual currency earned in this record.
  final double amount;

  /// Mining power used during this record.
  final double miningPower;

  /// Duration of the simulated mining activity.
  final Duration duration;

  /// Time when the mining activity started.
  final DateTime startedAt;

  /// Time when the mining activity ended.
  final DateTime endedAt;

  /// Indicates whether this reward was calculated from offline activity.
  final bool isOffline;

  const MiningRecord({
    required this.id,
    required this.currencyId,
    required this.amount,
    required this.miningPower,
    required this.duration,
    required this.startedAt,
    required this.endedAt,
    required this.isOffline,
  });

  /// Duration in seconds.
  int get durationInSeconds => duration.inSeconds;

  /// Duration in minutes.
  double get durationInMinutes {
    return duration.inSeconds / Duration.secondsPerMinute;
  }

  /// Duration in hours.
  double get durationInHours {
    return duration.inSeconds / Duration.secondsPerHour;
  }

  /// Returns the average virtual reward per second.
  double get rewardPerSecond {
    if (durationInSeconds <= 0) {
      return 0;
    }

    return amount / durationInSeconds;
  }

  /// Returns true when the record contains a positive reward.
  bool get hasReward => amount > 0;

  MiningRecord copyWith({
    String? id,
    String? currencyId,
    double? amount,
    double? miningPower,
    Duration? duration,
    DateTime? startedAt,
    DateTime? endedAt,
    bool? isOffline,
  }) {
    return MiningRecord(
      id: id ?? this.id,
      currencyId: currencyId ?? this.currencyId,
      amount: amount ?? this.amount,
      miningPower: miningPower ?? this.miningPower,
      duration: duration ?? this.duration,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      isOffline: isOffline ?? this.isOffline,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'currencyId': currencyId,
      'amount': amount,
      'miningPower': miningPower,
      'durationSeconds': duration.inSeconds,
      'startedAt': startedAt.toUtc().toIso8601String(),
      'endedAt': endedAt.toUtc().toIso8601String(),
      'isOffline': isOffline,
    };
  }

  factory MiningRecord.fromMap(Map<String, dynamic> map) {
    final id = _readRequiredString(
      map,
      'id',
    );

    final currencyId = _readRequiredString(
      map,
      'currencyId',
    );

    final amount = _readDouble(
      map,
      'amount',
    );

    final miningPower = _readDouble(
      map,
      'miningPower',
    );

    final durationSeconds = _readInt(
      map,
      'durationSeconds',
    );

    final startedAt = _readDateTime(
      map,
      'startedAt',
    );

    final endedAt = _readDateTime(
      map,
      'endedAt',
    );

    final isOffline = _readBool(
      map,
      'isOffline',
    );

    if (amount < 0) {
      throw FormatException(
        'Mining amount cannot be negative.',
      );
    }

    if (miningPower < 0) {
      throw FormatException(
        'Mining power cannot be negative.',
      );
    }

    if (durationSeconds < 0) {
      throw FormatException(
        'Mining duration cannot be negative.',
      );
    }

    if (endedAt.isBefore(startedAt)) {
      throw FormatException(
        'Mining end time cannot be before start time.',
      );
    }

    final actualDuration = endedAt.difference(
      startedAt,
    );

    if (actualDuration.inSeconds != durationSeconds) {
      throw FormatException(
        'Mining duration does not match '
        'start and end times.',
      );
    }

    return MiningRecord(
      id: id,
      currencyId: currencyId,
      amount: amount,
      miningPower: miningPower,
      duration: Duration(
        seconds: durationSeconds,
      ),
      startedAt: startedAt,
      endedAt: endedAt,
      isOffline: isOffline,
    );
  }

  static String _readRequiredString(
    Map<String, dynamic> map,
    String key,
  ) {
    final value = map[key];

    if (value is! String || value.trim().isEmpty) {
      throw FormatException(
        'Field "$key" must be a non-empty string.',
      );
    }

    return value.trim();
  }

  static double _readDouble(
    Map<String, dynamic> map,
    String key,
  ) {
    final value = map[key];

    if (value is num) {
      final result = value.toDouble();

      if (result.isFinite) {
        return result;
      }
    }

    if (value is String) {
      final result = double.tryParse(value);

      if (result != null && result.isFinite) {
        return result;
      }
    }

    throw FormatException(
      'Field "$key" must contain a valid number.',
    );
  }

  static int _readInt(
    Map<String, dynamic> map,
    String key,
  ) {
    final value = map[key];

    if (value is int) {
      return value;
    }

    if (value is num) {
      if (value.isFinite && value == value.toInt()) {
        return value.toInt();
      }
    }

    if (value is String) {
      final parsed = int.tryParse(value);

      if (parsed != null) {
        return parsed;
      }
    }

    throw FormatException(
      'Field "$key" must contain a valid integer.',
    );
  }

  static bool _readBool(
    Map<String, dynamic> map,
    String key,
  ) {
    final value = map[key];

    if (value is bool) {
      return value;
    }

    if (value is String) {
      final normalized = value.trim().toLowerCase();

      if (normalized == 'true') {
        return true;
      }

      if (normalized == 'false') {
        return false;
      }
    }

    throw FormatException(
      'Field "$key" must contain a valid boolean.',
    );
  }

  static DateTime _readDateTime(
    Map<String, dynamic> map,
    String key,
  ) {
    final value = map[key];

    if (value is DateTime) {
      return value.toUtc();
    }

    if (value is String) {
      final parsed = DateTime.tryParse(value);

      if (parsed != null) {
        return parsed.toUtc();
      }
    }

    throw FormatException(
      'Field "$key" must contain a valid ISO-8601 date.',
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other is! MiningRecord) {
      return false;
    }

    return id == other.id &&
        currencyId == other.currencyId &&
        amount == other.amount &&
        miningPower == other.miningPower &&
        duration == other.duration &&
        startedAt == other.startedAt &&
        endedAt == other.endedAt &&
        isOffline == other.isOffline;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      currencyId,
      amount,
      miningPower,
      duration,
      startedAt,
      endedAt,
      isOffline,
    );
  }

  @override
  String toString() {
    return 'MiningRecord('
        'id: $id, '
        'currencyId: $currencyId, '
        'amount: $amount, '
        'miningPower: $miningPower, '
        'duration: $duration, '
        'startedAt: $startedAt, '
        'endedAt: $endedAt, '
        'isOffline: $isOffline'
        ')';
  }
}