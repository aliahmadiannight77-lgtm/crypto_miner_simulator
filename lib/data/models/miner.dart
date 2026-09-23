/// Represents the user's virtual mining machine.
///
/// This model describes the simulated miner and its upgrade state.
/// It does NOT perform real cryptocurrency mining.
class Miner {
  final int level;

  /// Current virtual mining power.
  final double miningPower;

  /// Virtual CPU upgrade level.
  final int cpuLevel;

  /// Virtual GPU upgrade level.
  final int gpuLevel;

  /// Virtual cooling system upgrade level.
  final int coolingLevel;

  /// Virtual storage upgrade level.
  final int storageLevel;

  /// Total virtual upgrades purchased for this miner.
  final int totalUpgrades;

  /// Last time the miner state was modified.
  final DateTime updatedAt;

  const Miner({
    required this.level,
    required this.miningPower,
    required this.cpuLevel,
    required this.gpuLevel,
    required this.coolingLevel,
    required this.storageLevel,
    required this.totalUpgrades,
    required this.updatedAt,
  });

  /// Returns true when the miner is at its minimum level.
  bool get isStarterMiner => level <= 1;

  /// Returns true when the miner has reached the maximum level.
  bool get isMaxLevel => level >= 100;

  /// Returns the combined component level.
  int get totalComponentLevel =>
      cpuLevel +
      gpuLevel +
      coolingLevel +
      storageLevel;

  /// Returns the average component level.
  double get averageComponentLevel {
    return totalComponentLevel / 4;
  }

  Miner copyWith({
    int? level,
    double? miningPower,
    int? cpuLevel,
    int? gpuLevel,
    int? coolingLevel,
    int? storageLevel,
    int? totalUpgrades,
    DateTime? updatedAt,
  }) {
    return Miner(
      level: level ?? this.level,
      miningPower: miningPower ?? this.miningPower,
      cpuLevel: cpuLevel ?? this.cpuLevel,
      gpuLevel: gpuLevel ?? this.gpuLevel,
      coolingLevel: coolingLevel ?? this.coolingLevel,
      storageLevel: storageLevel ?? this.storageLevel,
      totalUpgrades: totalUpgrades ?? this.totalUpgrades,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'level': level,
      'miningPower': miningPower,
      'cpuLevel': cpuLevel,
      'gpuLevel': gpuLevel,
      'coolingLevel': coolingLevel,
      'storageLevel': storageLevel,
      'totalUpgrades': totalUpgrades,
      'updatedAt': updatedAt.toUtc().toIso8601String(),
    };
  }

  factory Miner.fromMap(Map<String, dynamic> map) {
    final level = _readInt(map, 'level');
    final miningPower = _readDouble(map, 'miningPower');
    final cpuLevel = _readInt(map, 'cpuLevel');
    final gpuLevel = _readInt(map, 'gpuLevel');
    final coolingLevel = _readInt(map, 'coolingLevel');
    final storageLevel = _readInt(map, 'storageLevel');
    final totalUpgrades = _readInt(map, 'totalUpgrades');
    final updatedAt = _readDateTime(map, 'updatedAt');

    if (level < 1 || level > 100) {
      throw FormatException(
        'Miner level must be between 1 and 100.',
      );
    }

    if (!miningPower.isFinite || miningPower < 0) {
      throw FormatException(
        'Mining power must be a finite non-negative number.',
      );
    }

    if (cpuLevel < 1) {
      throw FormatException(
        'CPU level must be at least 1.',
      );
    }

    if (gpuLevel < 1) {
      throw FormatException(
        'GPU level must be at least 1.',
      );
    }

    if (coolingLevel < 1) {
      throw FormatException(
        'Cooling level must be at least 1.',
      );
    }

    if (storageLevel < 1) {
      throw FormatException(
        'Storage level must be at least 1.',
      );
    }

    if (totalUpgrades < 0) {
      throw FormatException(
        'Total upgrades cannot be negative.',
      );
    }

    return Miner(
      level: level,
      miningPower: miningPower,
      cpuLevel: cpuLevel,
      gpuLevel: gpuLevel,
      coolingLevel: coolingLevel,
      storageLevel: storageLevel,
      totalUpgrades: totalUpgrades,
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other is! Miner) {
      return false;
    }

    return level == other.level &&
        miningPower == other.miningPower &&
        cpuLevel == other.cpuLevel &&
        gpuLevel == other.gpuLevel &&
        coolingLevel == other.coolingLevel &&
        storageLevel == other.storageLevel &&
        totalUpgrades == other.totalUpgrades &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    return Object.hash(
      level,
      miningPower,
      cpuLevel,
      gpuLevel,
      coolingLevel,
      storageLevel,
      totalUpgrades,
      updatedAt,
    );
  }

  @override
  String toString() {
    return 'Miner('
        'level: $level, '
        'miningPower: $miningPower, '
        'cpuLevel: $cpuLevel, '
        'gpuLevel: $gpuLevel, '
        'coolingLevel: $coolingLevel, '
        'storageLevel: $storageLevel, '
        'totalUpgrades: $totalUpgrades, '
        'updatedAt: $updatedAt'
        ')';
  }
}