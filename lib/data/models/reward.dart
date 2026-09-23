/// Represents a virtual reward in the game.
///
/// Rewards have no real-world monetary value.
/// They are used by missions, achievements, daily rewards,
/// mystery boxes and other game systems.
class Reward {
  final String id;
  final String type;
  final String title;
  final String description;
  final int xpAmount;
  final double usdtAmount;
  final String? itemId;
  final int quantity;
  final DateTime createdAt;
  final bool isClaimed;
  final DateTime? claimedAt;

  const Reward({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.xpAmount,
    required this.usdtAmount,
    required this.itemId,
    required this.quantity,
    required this.createdAt,
    required this.isClaimed,
    required this.claimedAt,
  });

  bool get hasXp => xpAmount > 0;

  bool get hasUsdt => usdtAmount > 0;

  bool get hasItem =>
      itemId != null && quantity > 0;

  bool get hasAnyValue =>
      hasXp || hasUsdt || hasItem;

  bool get isPending => !isClaimed;

  bool get hasClaimDate => claimedAt != null;

  Reward copyWith({
    String? id,
    String? type,
    String? title,
    String? description,
    int? xpAmount,
    double? usdtAmount,
    String? itemId,
    int? quantity,
    DateTime? createdAt,
    bool? isClaimed,
    DateTime? claimedAt,
  }) {
    return Reward(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      xpAmount: xpAmount ?? this.xpAmount,
      usdtAmount: usdtAmount ?? this.usdtAmount,
      itemId: itemId ?? this.itemId,
      quantity: quantity ?? this.quantity,
      createdAt: createdAt ?? this.createdAt,
      isClaimed: isClaimed ?? this.isClaimed,
      claimedAt: claimedAt ?? this.claimedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'description': description,
      'xpAmount': xpAmount,
      'usdtAmount': usdtAmount,
      'itemId': itemId,
      'quantity': quantity,
      'createdAt': createdAt.toUtc().toIso8601String(),
      'isClaimed': isClaimed,
      'claimedAt':
          claimedAt?.toUtc().toIso8601String(),
    };
  }

  factory Reward.fromMap(
    Map<String, dynamic> map,
  ) {
    final id =
        _readRequiredString(map, 'id');

    final type =
        _readRequiredString(map, 'type');

    final title =
        _readRequiredString(map, 'title');

    final description =
        _readRequiredString(map, 'description');

    final xpAmount =
        _readInt(map, 'xpAmount');

    final usdtAmount =
        _readDouble(map, 'usdtAmount');

    final itemId =
        _readNullableString(map, 'itemId');

    final quantity =
        _readInt(map, 'quantity');

    final createdAt =
        _readDateTime(map, 'createdAt');

    final isClaimed =
        _readBool(map, 'isClaimed');

    final claimedAt =
        _readNullableDateTime(
      map,
      'claimedAt',
    );

    if (xpAmount < 0) {
      throw FormatException(
        'Reward XP amount cannot be negative.',
      );
    }

    if (usdtAmount < 0) {
      throw FormatException(
        'Reward USDT amount cannot be negative.',
      );
    }

    if (quantity < 0) {
      throw FormatException(
        'Reward quantity cannot be negative.',
      );
    }

    if (itemId != null && quantity <= 0) {
      throw FormatException(
        'Reward item quantity must be greater than zero.',
      );
    }

    if (itemId == null && quantity != 0) {
      throw FormatException(
        'Reward quantity must be zero when there is no item.',
      );
    }

    if (!isClaimed && claimedAt != null) {
      throw FormatException(
        'Unclaimed reward cannot have a claim date.',
      );
    }

    if (isClaimed && claimedAt == null) {
      throw FormatException(
        'Claimed reward must have a claim date.',
      );
    }

    if (xpAmount == 0 &&
        usdtAmount == 0 &&
        itemId == null) {
      throw FormatException(
        'Reward must contain at least one reward value.',
      );
    }

    return Reward(
      id: id,
      type: type,
      title: title,
      description: description,
      xpAmount: xpAmount,
      usdtAmount: usdtAmount,
      itemId: itemId,
      quantity: quantity,
      createdAt: createdAt,
      isClaimed: isClaimed,
      claimedAt: claimedAt,
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

  static String? _readNullableString(
    Map<String, dynamic> map,
    String key,
  ) {
    final value = map[key];

    if (value == null) {
      return null;
    }

    if (value is String &&
        value.trim().isNotEmpty) {
      return value.trim();
    }

    throw FormatException(
      'Field "$key" must contain a non-empty string '
      'or null.',
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

  static bool _readBool(
    Map<String, dynamic> map,
    String key,
  ) {
    final value = map[key];

    if (value is bool) {
      return value;
    }

    if (value is String) {
      final normalized =
          value.trim().toLowerCase();

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

    if (other is! Reward) {
      return false;
    }

    return id == other.id &&
        type == other.type &&
        title == other.title &&
        description == other.description &&
        xpAmount == other.xpAmount &&
        usdtAmount == other.usdtAmount &&
        itemId == other.itemId &&
        quantity == other.quantity &&
        createdAt == other.createdAt &&
        isClaimed == other.isClaimed &&
        claimedAt == other.claimedAt;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      type,
      title,
      description,
      xpAmount,
      usdtAmount,
      itemId,
      quantity,
      createdAt,
      isClaimed,
      claimedAt,
    );
  }

  @override
  String toString() {
    return 'Reward('
        'id: $id, '
        'type: $type, '
        'title: $title, '
        'description: $description, '
        'xpAmount: $xpAmount, '
        'usdtAmount: $usdtAmount, '
        'itemId: $itemId, '
        'quantity: $quantity, '
        'createdAt: $createdAt, '
        'isClaimed: $isClaimed, '
        'claimedAt: $claimedAt'
        ')';
  }
}