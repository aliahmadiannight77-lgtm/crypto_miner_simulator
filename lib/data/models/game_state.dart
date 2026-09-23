/// Represents the complete persistent state of the virtual game.
///
/// This model contains gameplay state only.
/// It does not contain UI settings such as language or theme.
///
/// All balances, rewards and progression values are virtual and
/// have no real-world monetary value.
class GameState {
  /// Current virtual USDT balance.
  final double usdtBalance;

  /// Current player XP.
  final int xp;

  /// Current player level.
  final int level;

  /// Current mining streak in consecutive days.
  final int streak;

  /// Highest mining streak reached by the player.
  final int bestStreak;

  /// Total number of manual mining actions.
  final int totalMiningActions;

  /// Total virtual amount mined across all mining actions.
  final double totalMinedAmount;

  /// Total number of virtual conversions.
  final int totalConversions;

  /// Total virtual amount spent on upgrades.
  final double totalUpgradeCost;

  /// Timestamp of the last time the game was actively opened.
  final DateTime lastActiveAt;

  /// Timestamp of the last manual mining action.
  final DateTime? lastMiningAt;

  /// Timestamp of the last daily reward claim.
  final DateTime? lastDailyRewardAt;

  /// Timestamp of the last saved state.
  final DateTime updatedAt;

  const GameState({
    required this.usdtBalance,
    required this.xp,
    required this.level,
    required this.streak,
    required this.bestStreak,
    required this.totalMiningActions,
    required this.totalMinedAmount,
    required this.totalConversions,
    required this.totalUpgradeCost,
    required this.lastActiveAt,
    required this.lastMiningAt,
    required this.lastDailyRewardAt,
    required this.updatedAt,
  });

  /// Returns true when the player has no virtual USDT.
  bool get hasNoUsdt => usdtBalance <= 0;

  /// Returns true when the player has earned XP.
  bool get hasXp => xp > 0;

  /// Returns true when the player has an active streak.
  bool get hasActiveStreak => streak > 0;

  /// Returns true when the player has performed mining.
  bool get hasMined => totalMiningActions > 0;

  /// Returns true when the player has performed a conversion.
  bool get hasConverted => totalConversions > 0;

  GameState copyWith({
    double? usdtBalance,
    int? xp,
    int? level,
    int? streak,
    int? bestStreak,
    int? totalMiningActions,
    double? totalMinedAmount,
    int? totalConversions,
    double? totalUpgradeCost,
    DateTime? lastActiveAt,
    DateTime? lastMiningAt,
    DateTime? lastDailyRewardAt,
    DateTime? updatedAt,
  }) {
    return GameState(
      usdtBalance: usdtBalance ?? this.usdtBalance,
      xp: xp ?? this.xp,
      level: level ?? this.level,
      streak: streak ?? this.streak,
      bestStreak: bestStreak ?? this.bestStreak,
      totalMiningActions:
          totalMiningActions ?? this.totalMiningActions,
      totalMinedAmount:
          totalMinedAmount ?? this.totalMinedAmount,
      totalConversions:
          totalConversions ?? this.totalConversions,
      totalUpgradeCost:
          totalUpgradeCost ?? this.totalUpgradeCost,
      lastActiveAt:
          lastActiveAt ?? this.lastActiveAt,
      lastMiningAt:
          lastMiningAt ?? this.lastMiningAt,
      lastDailyRewardAt:
          lastDailyRewardAt ?? this.lastDailyRewardAt,
      updatedAt:
          updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'usdtBalance': usdtBalance,
      'xp': xp,
      'level': level,
      'streak': streak,
      'bestStreak': bestStreak,
      'totalMiningActions': totalMiningActions,
      'totalMinedAmount': totalMinedAmount,
      'totalConversions': totalConversions,
      'totalUpgradeCost': totalUpgradeCost,
      'lastActiveAt': lastActiveAt.toUtc().toIso8601String(),
      'lastMiningAt': lastMiningAt?.toUtc().toIso8601String(),
      'lastDailyRewardAt':
          lastDailyRewardAt?.toUtc().toIso8601String(),
      'updatedAt': updatedAt.toUtc().toIso8601String(),
    };
  }

  factory GameState.fromMap(Map<String, dynamic> map) {
    final usdtBalance = _readDouble(
      map,
      'usdtBalance',
    );

    final xp = _readInt(
      map,
      'xp',
    );

    final level = _readInt(
      map,
      'level',
    );

    final streak = _readInt(
      map,
      'streak',
    );

    final bestStreak = _readInt(
      map,
      'bestStreak',
    );

    final totalMiningActions = _readInt(
      map,
      'totalMiningActions',
    );

    final totalMinedAmount = _readDouble(
      map,
      'totalMinedAmount',
    );

    final totalConversions = _readInt(
      map,
      'totalConversions',
    );

    final totalUpgradeCost = _readDouble(
      map,
      'totalUpgradeCost',
    );

    final lastActiveAt = _readDateTime(
      map,
      'lastActiveAt',
    );

    final lastMiningAt = _readNullableDateTime(
      map,
      'lastMiningAt',
    );

    final lastDailyRewardAt = _readNullableDateTime(
      map,
      'lastDailyRewardAt',
    );

    final updatedAt = _readDateTime(
      map,
      'updatedAt',
    );

    if (usdtBalance < 0) {
      throw FormatException(
        'USDT balance cannot be negative.',
      );
    }

    if (xp < 0) {
      throw FormatException(
        'XP cannot be negative.',
      );
    }

    if (level < 1) {
      throw FormatException(
        'Player level must be at least 1.',
      );
    }

    if (streak < 0) {
      throw FormatException(
        'Streak cannot be negative.',
      );
    }

    if (bestStreak < 0) {
      throw FormatException(
        'Best streak cannot be negative.',
      );
    }

    if (bestStreak < streak) {
      throw FormatException(
        'Best streak cannot be lower than current streak.',
      );
    }

    if (totalMiningActions < 0) {
      throw FormatException(
        'Total mining actions cannot be negative.',
      );
    }

    if (totalMinedAmount < 0) {
      throw FormatException(
        'Total mined amount cannot be negative.',
      );
    }

    if (totalConversions < 0) {
      throw FormatException(
        'Total conversions cannot be negative.',
      );
    }

    if (totalUpgradeCost < 0) {
      throw FormatException(
        'Total upgrade cost cannot be negative.',
      );
    }

    return GameState(
      usdtBalance: usdtBalance,
      xp: xp,
      level: level,
      streak: streak,
      bestStreak: bestStreak,
      totalMiningActions: totalMiningActions,
      totalMinedAmount: totalMinedAmount,
      totalConversions: totalConversions,
      totalUpgradeCost: totalUpgradeCost,
      lastActiveAt: lastActiveAt,
      lastMiningAt: lastMiningAt,
      lastDailyRewardAt: lastDailyRewardAt,
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

    if (other is! GameState) {
      return false;
    }

    return usdtBalance == other.usdtBalance &&
        xp == other.xp &&
        level == other.level &&
        streak == other.streak &&
        bestStreak == other.bestStreak &&
        totalMiningActions == other.totalMiningActions &&
        totalMinedAmount == other.totalMinedAmount &&
        totalConversions == other.totalConversions &&
        totalUpgradeCost == other.totalUpgradeCost &&
        lastActiveAt == other.lastActiveAt &&
        lastMiningAt == other.lastMiningAt &&
        lastDailyRewardAt == other.lastDailyRewardAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    return Object.hash(
      usdtBalance,
      xp,
      level,
      streak,
      bestStreak,
      totalMiningActions,
      totalMinedAmount,
      totalConversions,
      totalUpgradeCost,
      lastActiveAt,
      lastMiningAt,
      lastDailyRewardAt,
      updatedAt,
    );
  }

  @override
  String toString() {
    return 'GameState('
        'usdtBalance: $usdtBalance, '
        'xp: $xp, '
        'level: $level, '
        'streak: $streak, '
        'bestStreak: $bestStreak, '
        'totalMiningActions: $totalMiningActions, '
        'totalMinedAmount: $totalMinedAmount, '
        'totalConversions: $totalConversions, '
        'totalUpgradeCost: $totalUpgradeCost, '
        'lastActiveAt: $lastActiveAt, '
        'lastMiningAt: $lastMiningAt, '
        'lastDailyRewardAt: $lastDailyRewardAt, '
        'updatedAt: $updatedAt'
        ')';
  }
}