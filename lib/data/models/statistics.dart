/// Represents aggregated gameplay statistics.
///
/// This model contains statistical data only.
/// Calculations and updates belong to the domain layer.
class Statistics {
  final int totalMiningActions;
  final double totalMinedAmount;
  final int totalMiningSeconds;
  final double totalMiningPower;
  final int totalConversions;
  final double totalConvertedUsdt;
  final double totalUpgradeCost;
  final int totalUpgrades;
  final int totalLessonsCompleted;
  final int totalQuizzesCompleted;
  final int totalMissionsCompleted;
  final int totalAchievementsUnlocked;
  final int totalRewardsClaimed;
  final int totalBoostsUsed;
  final int highestMinerLevel;
  final double highestMiningPower;
  final int highestLevel;
  final int longestStreak;
  final DateTime? firstActivityAt;
  final DateTime? lastActivityAt;
  final DateTime updatedAt;

  const Statistics({
    required this.totalMiningActions,
    required this.totalMinedAmount,
    required this.totalMiningSeconds,
    required this.totalMiningPower,
    required this.totalConversions,
    required this.totalConvertedUsdt,
    required this.totalUpgradeCost,
    required this.totalUpgrades,
    required this.totalLessonsCompleted,
    required this.totalQuizzesCompleted,
    required this.totalMissionsCompleted,
    required this.totalAchievementsUnlocked,
    required this.totalRewardsClaimed,
    required this.totalBoostsUsed,
    required this.highestMinerLevel,
    required this.highestMiningPower,
    required this.highestLevel,
    required this.longestStreak,
    required this.firstActivityAt,
    required this.lastActivityAt,
    required this.updatedAt,
  });

  /// Whether the player has performed any mining action.
  bool get hasMiningActivity =>
      totalMiningActions > 0;

  /// Whether the player has converted any virtual currency.
  bool get hasConversionActivity =>
      totalConversions > 0;

  /// Whether the player has any educational activity.
  bool get hasEducationActivity =>
      totalLessonsCompleted > 0 ||
      totalQuizzesCompleted > 0;

  /// Whether the player has completed any mission.
  bool get hasMissionActivity =>
      totalMissionsCompleted > 0;

  /// Total active gameplay time in minutes.
  double get totalMiningMinutes {
    return totalMiningSeconds / Duration.secondsPerMinute;
  }

  /// Total active gameplay time in hours.
  double get totalMiningHours {
    return totalMiningSeconds / Duration.secondsPerHour;
  }

  /// Average mined amount per mining action.
  double get averageMinedPerAction {
    if (totalMiningActions <= 0) {
      return 0;
    }

    return totalMinedAmount / totalMiningActions;
  }

  /// Average mining power across recorded mining activity.
  double get averageMiningPower {
    if (totalMiningActions <= 0) {
      return 0;
    }

    return totalMiningPower / totalMiningActions;
  }

  Statistics copyWith({
    int? totalMiningActions,
    double? totalMinedAmount,
    int? totalMiningSeconds,
    double? totalMiningPower,
    int? totalConversions,
    double? totalConvertedUsdt,
    double? totalUpgradeCost,
    int? totalUpgrades,
    int? totalLessonsCompleted,
    int? totalQuizzesCompleted,
    int? totalMissionsCompleted,
    int? totalAchievementsUnlocked,
    int? totalRewardsClaimed,
    int? totalBoostsUsed,
    int? highestMinerLevel,
    double? highestMiningPower,
    int? highestLevel,
    int? longestStreak,
    DateTime? firstActivityAt,
    DateTime? lastActivityAt,
    DateTime? updatedAt,
  }) {
    return Statistics(
      totalMiningActions:
          totalMiningActions ?? this.totalMiningActions,
      totalMinedAmount:
          totalMinedAmount ?? this.totalMinedAmount,
      totalMiningSeconds:
          totalMiningSeconds ?? this.totalMiningSeconds,
      totalMiningPower:
          totalMiningPower ?? this.totalMiningPower,
      totalConversions:
          totalConversions ?? this.totalConversions,
      totalConvertedUsdt:
          totalConvertedUsdt ?? this.totalConvertedUsdt,
      totalUpgradeCost:
          totalUpgradeCost ?? this.totalUpgradeCost,
      totalUpgrades:
          totalUpgrades ?? this.totalUpgrades,
      totalLessonsCompleted:
          totalLessonsCompleted ??
              this.totalLessonsCompleted,
      totalQuizzesCompleted:
          totalQuizzesCompleted ??
              this.totalQuizzesCompleted,
      totalMissionsCompleted:
          totalMissionsCompleted ??
              this.totalMissionsCompleted,
      totalAchievementsUnlocked:
          totalAchievementsUnlocked ??
              this.totalAchievementsUnlocked,
      totalRewardsClaimed:
          totalRewardsClaimed ??
              this.totalRewardsClaimed,
      totalBoostsUsed:
          totalBoostsUsed ?? this.totalBoostsUsed,
      highestMinerLevel:
          highestMinerLevel ?? this.highestMinerLevel,
      highestMiningPower:
          highestMiningPower ?? this.highestMiningPower,
      highestLevel:
          highestLevel ?? this.highestLevel,
      longestStreak:
          longestStreak ?? this.longestStreak,
      firstActivityAt:
          firstActivityAt ?? this.firstActivityAt,
      lastActivityAt:
          lastActivityAt ?? this.lastActivityAt,
      updatedAt:
          updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'totalMiningActions': totalMiningActions,
      'totalMinedAmount': totalMinedAmount,
      'totalMiningSeconds': totalMiningSeconds,
      'totalMiningPower': totalMiningPower,
      'totalConversions': totalConversions,
      'totalConvertedUsdt': totalConvertedUsdt,
      'totalUpgradeCost': totalUpgradeCost,
      'totalUpgrades': totalUpgrades,
      'totalLessonsCompleted': totalLessonsCompleted,
      'totalQuizzesCompleted': totalQuizzesCompleted,
      'totalMissionsCompleted': totalMissionsCompleted,
      'totalAchievementsUnlocked':
          totalAchievementsUnlocked,
      'totalRewardsClaimed': totalRewardsClaimed,
      'totalBoostsUsed': totalBoostsUsed,
      'highestMinerLevel': highestMinerLevel,
      'highestMiningPower': highestMiningPower,
      'highestLevel': highestLevel,
      'longestStreak': longestStreak,
      'firstActivityAt':
          firstActivityAt?.toUtc().toIso8601String(),
      'lastActivityAt':
          lastActivityAt?.toUtc().toIso8601String(),
      'updatedAt': updatedAt.toUtc().toIso8601String(),
    };
  }

  factory Statistics.fromMap(
    Map<String, dynamic> map,
  ) {
    final totalMiningActions =
        _readInt(map, 'totalMiningActions');

    final totalMinedAmount =
        _readDouble(map, 'totalMinedAmount');

    final totalMiningSeconds =
        _readInt(map, 'totalMiningSeconds');

    final totalMiningPower =
        _readDouble(map, 'totalMiningPower');

    final totalConversions =
        _readInt(map, 'totalConversions');

    final totalConvertedUsdt =
        _readDouble(map, 'totalConvertedUsdt');

    final totalUpgradeCost =
        _readDouble(map, 'totalUpgradeCost');

    final totalUpgrades =
        _readInt(map, 'totalUpgrades');

    final totalLessonsCompleted =
        _readInt(map, 'totalLessonsCompleted');

    final totalQuizzesCompleted =
        _readInt(map, 'totalQuizzesCompleted');

    final totalMissionsCompleted =
        _readInt(map, 'totalMissionsCompleted');

    final totalAchievementsUnlocked =
        _readInt(
          map,
          'totalAchievementsUnlocked',
        );

    final totalRewardsClaimed =
        _readInt(map, 'totalRewardsClaimed');

    final totalBoostsUsed =
        _readInt(map, 'totalBoostsUsed');

    final highestMinerLevel =
        _readInt(map, 'highestMinerLevel');

    final highestMiningPower =
        _readDouble(map, 'highestMiningPower');

    final highestLevel =
        _readInt(map, 'highestLevel');

    final longestStreak =
        _readInt(map, 'longestStreak');

    final firstActivityAt =
        _readNullableDateTime(
      map,
      'firstActivityAt',
    );

    final lastActivityAt =
        _readNullableDateTime(
      map,
      'lastActivityAt',
    );

    final updatedAt =
        _readDateTime(map, 'updatedAt');

    final integerValues = <String, int>{
      'totalMiningActions': totalMiningActions,
      'totalMiningSeconds': totalMiningSeconds,
      'totalConversions': totalConversions,
      'totalUpgrades': totalUpgrades,
      'totalLessonsCompleted':
          totalLessonsCompleted,
      'totalQuizzesCompleted':
          totalQuizzesCompleted,
      'totalMissionsCompleted':
          totalMissionsCompleted,
      'totalAchievementsUnlocked':
          totalAchievementsUnlocked,
      'totalRewardsClaimed':
          totalRewardsClaimed,
      'totalBoostsUsed': totalBoostsUsed,
      'highestMinerLevel': highestMinerLevel,
      'highestLevel': highestLevel,
      'longestStreak': longestStreak,
    };

    for (final entry in integerValues.entries) {
      if (entry.value < 0) {
        throw FormatException(
          '${entry.key} cannot be negative.',
        );
      }
    }

    final doubleValues = <String, double>{
      'totalMinedAmount': totalMinedAmount,
      'totalMiningPower': totalMiningPower,
      'totalConvertedUsdt':
          totalConvertedUsdt,
      'totalUpgradeCost':
          totalUpgradeCost,
      'highestMiningPower':
          highestMiningPower,
    };

    for (final entry in doubleValues.entries) {
      if (entry.value < 0) {
        throw FormatException(
          '${entry.key} cannot be negative.',
        );
      }
    }

    if (firstActivityAt != null &&
        lastActivityAt != null &&
        lastActivityAt.isBefore(firstActivityAt)) {
      throw FormatException(
        'Last activity cannot be before first activity.',
      );
    }

    return Statistics(
      totalMiningActions: totalMiningActions,
      totalMinedAmount: totalMinedAmount,
      totalMiningSeconds: totalMiningSeconds,
      totalMiningPower: totalMiningPower,
      totalConversions: totalConversions,
      totalConvertedUsdt: totalConvertedUsdt,
      totalUpgradeCost: totalUpgradeCost,
      totalUpgrades: totalUpgrades,
      totalLessonsCompleted:
          totalLessonsCompleted,
      totalQuizzesCompleted:
          totalQuizzesCompleted,
      totalMissionsCompleted:
          totalMissionsCompleted,
      totalAchievementsUnlocked:
          totalAchievementsUnlocked,
      totalRewardsClaimed:
          totalRewardsClaimed,
      totalBoostsUsed: totalBoostsUsed,
      highestMinerLevel: highestMinerLevel,
      highestMiningPower: highestMiningPower,
      highestLevel: highestLevel,
      longestStreak: longestStreak,
      firstActivityAt: firstActivityAt,
      lastActivityAt: lastActivityAt,
      updatedAt: updatedAt,
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
      if (value.isFinite &&
          value == value.toInt()) {
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

      if (result != null &&
          result.isFinite) {
        return result;
      }
    }

    throw FormatException(
      'Field "$key" must contain a valid number.',
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

    if (other is! Statistics) {
      return false;
    }

    return totalMiningActions ==
            other.totalMiningActions &&
        totalMinedAmount ==
            other.totalMinedAmount &&
        totalMiningSeconds ==
            other.totalMiningSeconds &&
        totalMiningPower ==
            other.totalMiningPower &&
        totalConversions ==
            other.totalConversions &&
        totalConvertedUsdt ==
            other.totalConvertedUsdt &&
        totalUpgradeCost ==
            other.totalUpgradeCost &&
        totalUpgrades ==
            other.totalUpgrades &&
        totalLessonsCompleted ==
            other.totalLessonsCompleted &&
        totalQuizzesCompleted ==
            other.totalQuizzesCompleted &&
        totalMissionsCompleted ==
            other.totalMissionsCompleted &&
        totalAchievementsUnlocked ==
            other.totalAchievementsUnlocked &&
        totalRewardsClaimed ==
            other.totalRewardsClaimed &&
        totalBoostsUsed ==
            other.totalBoostsUsed &&
        highestMinerLevel ==
            other.highestMinerLevel &&
        highestMiningPower ==
            other.highestMiningPower &&
        highestLevel ==
            other.highestLevel &&
        longestStreak ==
            other.longestStreak &&
        firstActivityAt ==
            other.firstActivityAt &&
        lastActivityAt ==
            other.lastActivityAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    return Object.hash(
      totalMiningActions,
      totalMinedAmount,
      totalMiningSeconds,
      totalMiningPower,
      totalConversions,
      totalConvertedUsdt,
      totalUpgradeCost,
      totalUpgrades,
      totalLessonsCompleted,
      totalQuizzesCompleted,
      totalMissionsCompleted,
      totalAchievementsUnlocked,
      totalRewardsClaimed,
      totalBoostsUsed,
      highestMinerLevel,
      highestMiningPower,
      highestLevel,
      longestStreak,
      firstActivityAt,
      lastActivityAt,
      updatedAt,
    );
  }

  @override
  String toString() {
    return 'Statistics('
        'totalMiningActions: $totalMiningActions, '
        'totalMinedAmount: $totalMinedAmount, '
        'totalMiningSeconds: $totalMiningSeconds, '
        'totalMiningPower: $totalMiningPower, '
        'totalConversions: $totalConversions, '
        'totalConvertedUsdt: $totalConvertedUsdt, '
        'totalUpgradeCost: $totalUpgradeCost, '
        'totalUpgrades: $totalUpgrades, '
        'totalLessonsCompleted: $totalLessonsCompleted, '
        'totalQuizzesCompleted: $totalQuizzesCompleted, '
        'totalMissionsCompleted: $totalMissionsCompleted, '
        'totalAchievementsUnlocked: $totalAchievementsUnlocked, '
        'totalRewardsClaimed: $totalRewardsClaimed, '
        'totalBoostsUsed: $totalBoostsUsed, '
        'highestMinerLevel: $highestMinerLevel, '
        'highestMiningPower: $highestMiningPower, '
        'highestLevel: $highestLevel, '
        'longestStreak: $longestStreak, '
        'firstActivityAt: $firstActivityAt, '
        'lastActivityAt: $lastActivityAt, '
        'updatedAt: $updatedAt'
        ')';
  }
}