/// Represents a virtual mission in the game.
///
/// A mission defines a goal that the player can complete to receive
/// virtual rewards such as XP and USDT.
///
/// This model stores mission state only.
/// Mission evaluation belongs to the domain layer.
class Mission {
  final String id;
  final String title;
  final String description;
  final String type;
  final double target;
  final double progress;
  final int xpReward;
  final double usdtReward;
  final bool isCompleted;
  final DateTime? completedAt;

  const Mission({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.target,
    required this.progress,
    required this.xpReward,
    required this.usdtReward,
    required this.isCompleted,
    required this.completedAt,
  });

  /// Remaining amount needed to complete the mission.
  double get remainingProgress {
    final remaining = target - progress;
    return remaining > 0 ? remaining : 0;
  }

  /// Progress percentage from 0 to 100.
  double get progressPercent {
    if (target <= 0) {
      return 0;
    }

    final percentage = (progress / target) * 100;

    if (percentage < 0) {
      return 0;
    }

    if (percentage > 100) {
      return 100;
    }

    return percentage;
  }

  /// Whether the mission still has progress remaining.
  bool get hasRemainingProgress {
    return remainingProgress > 0;
  }

  /// Whether the mission has any progress.
  bool get hasProgress {
    return progress > 0;
  }

  /// Whether the mission provides an XP reward.
  bool get hasXpReward {
    return xpReward > 0;
  }

  /// Whether the mission provides a USDT reward.
  bool get hasUsdtReward {
    return usdtReward > 0;
  }

  /// Whether the mission has a completion timestamp.
  bool get hasCompletionDate {
    return completedAt != null;
  }

  Mission copyWith({
    String? id,
    String? title,
    String? description,
    String? type,
    double? target,
    double? progress,
    int? xpReward,
    double? usdtReward,
    bool? isCompleted,
    DateTime? completedAt,
  }) {
    return Mission(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      target: target ?? this.target,
      progress: progress ?? this.progress,
      xpReward: xpReward ?? this.xpReward,
      usdtReward: usdtReward ?? this.usdtReward,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'type': type,
      'target': target,
      'progress': progress,
      'xpReward': xpReward,
      'usdtReward': usdtReward,
      'isCompleted': isCompleted,
      'completedAt': completedAt?.toUtc().toIso8601String(),
    };
  }

  factory Mission.fromMap(Map<String, dynamic> map) {
    final id = _readRequiredString(map, 'id');
    final title = _readRequiredString(map, 'title');
    final description = _readRequiredString(map, 'description');
    final type = _readRequiredString(map, 'type');

    final target = _readDouble(map, 'target');
    final progress = _readDouble(map, 'progress');
    final xpReward = _readInt(map, 'xpReward');
    final usdtReward = _readDouble(map, 'usdtReward');

    final isCompleted = _readBool(map, 'isCompleted');
    final completedAt = _readNullableDateTime(
      map,
      'completedAt',
    );

    if (target <= 0) {
      throw FormatException(
        'Mission target must be greater than zero.',
      );
    }

    if (progress < 0) {
      throw FormatException(
        'Mission progress cannot be negative.',
      );
    }

    if (xpReward < 0) {
      throw FormatException(
        'Mission XP reward cannot be negative.',
      );
    }

    if (usdtReward < 0) {
      throw FormatException(
        'Mission USDT reward cannot be negative.',
      );
    }

    if (isCompleted && completedAt == null) {
      throw FormatException(
        'Completed mission must have a completion date.',
      );
    }

    if (!isCompleted && completedAt != null) {
      throw FormatException(
        'Incomplete mission cannot have a completion date.',
      );
    }

    if (isCompleted && progress < target) {
      throw FormatException(
        'Completed mission must reach its target.',
      );
    }

    return Mission(
      id: id,
      title: title,
      description: description,
      type: type,
      target: target,
      progress: progress,
      xpReward: xpReward,
      usdtReward: usdtReward,
      isCompleted: isCompleted,
      completedAt: completedAt,
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

    if (other is! Mission) {
      return false;
    }

    return id == other.id &&
        title == other.title &&
        description == other.description &&
        type == other.type &&
        target == other.target &&
        progress == other.progress &&
        xpReward == other.xpReward &&
        usdtReward == other.usdtReward &&
        isCompleted == other.isCompleted &&
        completedAt == other.completedAt;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      title,
      description,
      type,
      target,
      progress,
      xpReward,
      usdtReward,
      isCompleted,
      completedAt,
    );
  }

  @override
  String toString() {
    return 'Mission('
        'id: $id, '
        'title: $title, '
        'description: $description, '
        'type: $type, '
        'target: $target, '
        'progress: $progress, '
        'xpReward: $xpReward, '
        'usdtReward: $usdtReward, '
        'isCompleted: $isCompleted, '
        'completedAt: $completedAt'
        ')';
  }
}