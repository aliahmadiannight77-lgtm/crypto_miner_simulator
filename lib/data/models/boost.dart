/// Represents a virtual mining boost.
///
/// A boost temporarily increases the effectiveness of the simulated miner.
/// It does not affect real cryptocurrency mining.
class Boost {
  final String id;
  final String name;
  final String description;

  /// Multiplier applied to virtual mining power.
  final double multiplier;

  /// Maximum number of times this boost can be activated.
  final int maxUses;

  /// Number of times this boost has already been used.
  final int usedCount;

  /// Duration of one activation.
  final Duration duration;

  /// Time when the current activation started.
  final DateTime? activatedAt;

  const Boost({
    required this.id,
    required this.name,
    required this.description,
    required this.multiplier,
    required this.maxUses,
    required this.usedCount,
    required this.duration,
    required this.activatedAt,
  });

  /// Returns true when the boost is currently active.
  bool get isActive {
    if (activatedAt == null) {
      return false;
    }

    final expiresAt = activatedAt!.add(duration);

    return DateTime.now().toUtc().isBefore(expiresAt);
  }

  /// Returns the activation expiration time.
  DateTime? get expiresAt {
    final start = activatedAt;

    if (start == null) {
      return null;
    }

    return start.add(duration);
  }

  /// Returns true when the boost has no remaining uses.
  bool get hasReachedUseLimit {
    return usedCount >= maxUses;
  }

  /// Returns the number of remaining uses.
  int get remainingUses {
    final remaining = maxUses - usedCount;

    if (remaining <= 0) {
      return 0;
    }

    return remaining;
  }

  /// Returns true when the boost can be activated.
  bool get canActivate {
    return !isActive && !hasReachedUseLimit;
  }

  /// Remaining active duration.
  ///
  /// Returns [Duration.zero] when the boost is inactive or expired.
  Duration get remainingDuration {
    final expiration = expiresAt;

    if (expiration == null) {
      return Duration.zero;
    }

    final remaining = expiration.difference(
      DateTime.now().toUtc(),
    );

    if (remaining.isNegative) {
      return Duration.zero;
    }

    return remaining;
  }

  Boost copyWith({
    String? id,
    String? name,
    String? description,
    double? multiplier,
    int? maxUses,
    int? usedCount,
    Duration? duration,
    DateTime? activatedAt,
  }) {
    return Boost(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      multiplier: multiplier ?? this.multiplier,
      maxUses: maxUses ?? this.maxUses,
      usedCount: usedCount ?? this.usedCount,
      duration: duration ?? this.duration,
      activatedAt: activatedAt ?? this.activatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'multiplier': multiplier,
      'maxUses': maxUses,
      'usedCount': usedCount,
      'durationSeconds': duration.inSeconds,
      'activatedAt': activatedAt?.toUtc().toIso8601String(),
    };
  }

  factory Boost.fromMap(Map<String, dynamic> map) {
    final id = _readRequiredString(
      map,
      'id',
    );

    final name = _readRequiredString(
      map,
      'name',
    );

    final description = _readRequiredString(
      map,
      'description',
    );

    final multiplier = _readDouble(
      map,
      'multiplier',
    );

    final maxUses = _readInt(
      map,
      'maxUses',
    );

    final usedCount = _readInt(
      map,
      'usedCount',
    );

    final durationSeconds = _readInt(
      map,
      'durationSeconds',
    );

    final activatedAt = _readNullableDateTime(
      map,
      'activatedAt',
    );

    if (multiplier <= 0) {
      throw FormatException(
        'Boost multiplier must be greater than zero.',
      );
    }

    if (maxUses <= 0) {
      throw FormatException(
        'Boost max uses must be greater than zero.',
      );
    }

    if (usedCount < 0) {
      throw FormatException(
        'Boost used count cannot be negative.',
      );
    }

    if (usedCount > maxUses) {
      throw FormatException(
        'Boost used count cannot exceed max uses.',
      );
    }

    if (durationSeconds <= 0) {
      throw FormatException(
        'Boost duration must be greater than zero.',
      );
    }

    return Boost(
      id: id,
      name: name,
      description: description,
      multiplier: multiplier,
      maxUses: maxUses,
      usedCount: usedCount,
      duration: Duration(
        seconds: durationSeconds,
      ),
      activatedAt: activatedAt,
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

  static DateTime? _readNullableDateTime(
    Map<String, dynamic> map,
    String key,
  ) {
    final value = map[key];

    if (value == null) {
      return null;
    }

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
      'Field "$key" must contain a valid ISO-8601 date '
      'or null.',
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other is! Boost) {
      return false;
    }

    return id == other.id &&
        name == other.name &&
        description == other.description &&
        multiplier == other.multiplier &&
        maxUses == other.maxUses &&
        usedCount == other.usedCount &&
        duration == other.duration &&
        activatedAt == other.activatedAt;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      name,
      description,
      multiplier,
      maxUses,
      usedCount,
      duration,
      activatedAt,
    );
  }

  @override
  String toString() {
    return 'Boost('
        'id: $id, '
        'name: $name, '
        'description: $description, '
        'multiplier: $multiplier, '
        'maxUses: $maxUses, '
        'usedCount: $usedCount, '
        'duration: $duration, '
        'activatedAt: $activatedAt'
        ')';
  }
}