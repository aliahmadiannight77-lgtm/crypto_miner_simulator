/// Represents an achievement in the virtual game.
///
/// Achievements reward the player for reaching specific milestones.
/// Rewards are entirely virtual and have no real-world monetary value.
class Achievement {
  final String id;
  final String title;
  final String description;

  /// Identifier used by the achievement engine to evaluate progress.
  final String type;

  /// Target value required to unlock the achievement.
  final double target;

  /// Virtual XP reward granted when unlocked.
  final int xpReward;

  /// Optional virtual USDT reward.
  final double usdtReward;

  /// Current progress toward the target.
  final double progress;

  /// Whether the achievement has been unlocked.
  final bool isUnlocked;

  /// Time when the achievement was unlocked.
  final DateTime? unlockedAt;

  const Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.target,
    required this.xpReward,
    required this.usdtReward,
    required this.progress,
    required this.isUnlocked,
    required this.unlockedAt,
  });

  /// Returns the remaining progress required to unlock.
  double get remainingProgress {
    final remaining = target - progress;

    if (remaining <= 0) {
      return 0;
    }

    return remaining;
  }

  /// Returns progress as a percentage from 0 to 100.
  double get progressPercent {
    if (target <= 0) {
      return isUnlocked ? 100 : 0;
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

  /// Returns true when the target has been reached.
  bool get isCompleted {
    return isUnlocked || progress >= target;
  }

  /// Returns true when the achievement still has progress remaining.
  bool get hasRemainingProgress {
    return !isCompleted && remainingProgress > 0;
  }

  Achievement copyWith({
    String? id,
    String? title,
    String? description,
    String? type,
    double? target,
    int? xpReward,
    double? usdtReward,
    double? progress,
    bool? isUnlocked,
    DateTime? unlockedAt,
  }) {
    return Achievement(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      target: target ?? this.target,
      xpReward: xpReward ?? this.xpReward,
      usdtReward: usdtReward ?? this.usdtReward,
      progress: progress ?? this.progress,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      unlockedAt: unlockedAt ?? this.unlockedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'type': type,
      'target': target,
      'xpReward': xpReward,
      'usdtReward': usdtReward,
      'progress': progress,
      'isUnlocked': isUnlocked,
      'unlockedAt': unlockedAt?.toUtc().toIso8601String(),
    };
  }

  factory Achievement.fromMap(Map<String, dynamic> map) {
    final id = _readRequiredString(
      map,
      'id',
    );

    final title = _readRequiredString(
      map,
      'title',
    );

    final description = _readRequiredString(
      map,
      'description',
    );

    final type = _readRequiredString(
      map,
      'type',
    );

    final target = _readDouble(
      map,
      'target',
    );

    final xpReward = _readInt(
      map,
      'xpReward',
    );

    final usdtReward = _readDouble(
      map,
      'usdtReward',
    );

    final progress = _readDouble(
      map,
      'progress',
    );

    final isUnlocked = _readBool(
      map,
      'isUnlocked',
    );

    final unlockedAt = _readNullableDateTime(
      map,
      'unlockedAt',
    );

    if (target < 0) {
      throw FormatException(
        'Achievement target cannot be negative.',
      );
    }

    if (xpReward < 0) {
      throw FormatException(
        'Achievement XP reward cannot be negative.',
      );
    }

    if (usdtReward < 0) {
      throw FormatException(
        'Achievement USDT reward cannot be negative.',
      );
    }

    if (progress < 0) {
      throw FormatException(
        'Achievement progress cannot be negative.',
      );
    }

    if (isUnlocked && unlockedAt == null) {
      throw FormatException(
        'Unlocked achievement must have an unlock date.',
      );
    }

    if (!isUnlocked && unlockedAt != null) {
      throw FormatException(
        'Locked achievement cannot have an unlock date.',
      );
    }

    return Achievement(
      id: id,
      title: title,
      description: description,
      type: type,
      target: target,
      xpReward: xpReward,
      usdtReward: usdtReward,
      progress: progress,
      isUnlocked: isUnlocked,
      unlockedAt: unlockedAt,
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

    if (other is! Achievement) {
      return false;
    }

    return id == other.id &&
        title == other.title &&
        description == other.description &&
        type == other.type &&
        target == other.target &&
        xpReward == other.xpReward &&
        usdtReward == other.usdtReward &&
        progress == other.progress &&
        isUnlocked == other.isUnlocked &&
        unlockedAt == other.unlockedAt;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      title,
      description,
      type,
      target,
      xpReward,
      usdtReward,
      progress,
      isUnlocked,
      unlockedAt,
    );
  }

  @override
  String toString() {
    return 'Achievement('
        'id: $id, '
        'title: $title, '
        'description: $description, '
        'type: $type, '
        'target: $target, '
        'xpReward: $xpReward, '
        'usdtReward: $usdtReward, '
        'progress: $progress, '
        'isUnlocked: $isUnlocked, '
        'unlockedAt: $unlockedAt'
        ')';
  }
}