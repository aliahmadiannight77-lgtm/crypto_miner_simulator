/// Represents a virtual currency conversion inside the game.
///
/// All conversions are simulated and have no real monetary value.
/// This model does not perform any transaction by itself.
class Conversion {
  final String id;

  /// Currency being spent.
  final String fromCurrencyId;

  /// Currency being received.
  final String toCurrencyId;

  /// Amount removed from the source currency.
  final double fromAmount;

  /// Amount received in the destination currency.
  final double toAmount;

  /// Virtual USD price of the source currency at conversion time.
  final double fromPriceUsd;

  /// Virtual USD price of the destination currency at conversion time.
  final double toPriceUsd;

  /// Virtual exchange rate used for this conversion.
  final double rate;

  /// Virtual fee charged for this conversion.
  final double fee;

  /// Time when the conversion was performed.
  final DateTime createdAt;

  const Conversion({
    required this.id,
    required this.fromCurrencyId,
    required this.toCurrencyId,
    required this.fromAmount,
    required this.toAmount,
    required this.fromPriceUsd,
    required this.toPriceUsd,
    required this.rate,
    required this.fee,
    required this.createdAt,
  });

  /// Returns true when a virtual fee was charged.
  bool get hasFee => fee > 0;

  /// Returns the total source amount including the virtual fee.
  double get totalSourceCost => fromAmount + fee;

  /// Returns true when this conversion has a positive output.
  bool get hasOutput => toAmount > 0;

  Conversion copyWith({
    String? id,
    String? fromCurrencyId,
    String? toCurrencyId,
    double? fromAmount,
    double? toAmount,
    double? fromPriceUsd,
    double? toPriceUsd,
    double? rate,
    double? fee,
    DateTime? createdAt,
  }) {
    return Conversion(
      id: id ?? this.id,
      fromCurrencyId: fromCurrencyId ?? this.fromCurrencyId,
      toCurrencyId: toCurrencyId ?? this.toCurrencyId,
      fromAmount: fromAmount ?? this.fromAmount,
      toAmount: toAmount ?? this.toAmount,
      fromPriceUsd: fromPriceUsd ?? this.fromPriceUsd,
      toPriceUsd: toPriceUsd ?? this.toPriceUsd,
      rate: rate ?? this.rate,
      fee: fee ?? this.fee,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fromCurrencyId': fromCurrencyId,
      'toCurrencyId': toCurrencyId,
      'fromAmount': fromAmount,
      'toAmount': toAmount,
      'fromPriceUsd': fromPriceUsd,
      'toPriceUsd': toPriceUsd,
      'rate': rate,
      'fee': fee,
      'createdAt': createdAt.toUtc().toIso8601String(),
    };
  }

  factory Conversion.fromMap(Map<String, dynamic> map) {
    final id = _readRequiredString(
      map,
      'id',
    );

    final fromCurrencyId = _readRequiredString(
      map,
      'fromCurrencyId',
    );

    final toCurrencyId = _readRequiredString(
      map,
      'toCurrencyId',
    );

    final fromAmount = _readDouble(
      map,
      'fromAmount',
    );

    final toAmount = _readDouble(
      map,
      'toAmount',
    );

    final fromPriceUsd = _readDouble(
      map,
      'fromPriceUsd',
    );

    final toPriceUsd = _readDouble(
      map,
      'toPriceUsd',
    );

    final rate = _readDouble(
      map,
      'rate',
    );

    final fee = _readDouble(
      map,
      'fee',
    );

    final createdAt = _readDateTime(
      map,
      'createdAt',
    );

    if (fromCurrencyId == toCurrencyId) {
      throw FormatException(
        'Source and destination currencies '
        'must be different.',
      );
    }

    if (fromAmount <= 0) {
      throw FormatException(
        'From amount must be greater than zero.',
      );
    }

    if (toAmount <= 0) {
      throw FormatException(
        'To amount must be greater than zero.',
      );
    }

    if (fromPriceUsd < 0) {
      throw FormatException(
        'Source virtual price cannot be negative.',
      );
    }

    if (toPriceUsd < 0) {
      throw FormatException(
        'Destination virtual price cannot be negative.',
      );
    }

    if (rate <= 0) {
      throw FormatException(
        'Conversion rate must be greater than zero.',
      );
    }

    if (fee < 0) {
      throw FormatException(
        'Conversion fee cannot be negative.',
      );
    }

    return Conversion(
      id: id,
      fromCurrencyId: fromCurrencyId,
      toCurrencyId: toCurrencyId,
      fromAmount: fromAmount,
      toAmount: toAmount,
      fromPriceUsd: fromPriceUsd,
      toPriceUsd: toPriceUsd,
      rate: rate,
      fee: fee,
      createdAt: createdAt,
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

    if (other is! Conversion) {
      return false;
    }

    return id == other.id &&
        fromCurrencyId == other.fromCurrencyId &&
        toCurrencyId == other.toCurrencyId &&
        fromAmount == other.fromAmount &&
        toAmount == other.toAmount &&
        fromPriceUsd == other.fromPriceUsd &&
        toPriceUsd == other.toPriceUsd &&
        rate == other.rate &&
        fee == other.fee &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      fromCurrencyId,
      toCurrencyId,
      fromAmount,
      toAmount,
      fromPriceUsd,
      toPriceUsd,
      rate,
      fee,
      createdAt,
    );
  }

  @override
  String toString() {
    return 'Conversion('
        'id: $id, '
        'fromCurrencyId: $fromCurrencyId, '
        'toCurrencyId: $toCurrencyId, '
        'fromAmount: $fromAmount, '
        'toAmount: $toAmount, '
        'fromPriceUsd: $fromPriceUsd, '
        'toPriceUsd: $toPriceUsd, '
        'rate: $rate, '
        'fee: $fee, '
        'createdAt: $createdAt'
        ')';
  }
}