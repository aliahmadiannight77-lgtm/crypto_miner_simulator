/// Represents the user's virtual holding of a single cryptocurrency.
///
/// This model contains only portfolio/balance data.
/// UI preferences such as favorites or display settings should not be stored here.
///
/// All values in this model belong to the game's virtual economy and have
/// no real-world monetary value.
class Holding {
  final String currencyId;
  final double amount;

  /// Average virtual acquisition price per unit in USD.
  final double averageAcquisitionPriceUsd;

  /// Total virtual acquisition cost in USD.
  final double totalAcquisitionCostUsd;

  /// Last time this holding was modified.
  final DateTime updatedAt;

  const Holding({
    required this.currencyId,
    required this.amount,
    required this.averageAcquisitionPriceUsd,
    required this.totalAcquisitionCostUsd,
    required this.updatedAt,
  });

  /// Returns true when the holding has no balance.
  bool get isEmpty => amount == 0;

  /// Returns true when the holding has a positive balance.
  bool get isPositive => amount > 0;

  /// Returns the current virtual USD value of this holding.
  double valueAt(double virtualPriceUsd) {
    if (!virtualPriceUsd.isFinite || virtualPriceUsd < 0) {
      throw ArgumentError.value(
        virtualPriceUsd,
        'virtualPriceUsd',
        'Virtual price must be a finite non-negative number.',
      );
    }

    return amount * virtualPriceUsd;
  }

  /// Returns the virtual profit or loss at the specified price.
  double profitLossAt(double virtualPriceUsd) {
    return valueAt(virtualPriceUsd) - totalAcquisitionCostUsd;
  }

  /// Returns the virtual profit or loss percentage.
  ///
  /// Returns 0 when there is no acquisition cost.
  double profitLossPercentAt(double virtualPriceUsd) {
    if (totalAcquisitionCostUsd <= 0) {
      return 0;
    }

    return (profitLossAt(virtualPriceUsd) /
            totalAcquisitionCostUsd) *
        100;
  }

  Holding copyWith({
    String? currencyId,
    double? amount,
    double? averageAcquisitionPriceUsd,
    double? totalAcquisitionCostUsd,
    DateTime? updatedAt,
  }) {
    return Holding(
      currencyId: currencyId ?? this.currencyId,
      amount: amount ?? this.amount,
      averageAcquisitionPriceUsd:
          averageAcquisitionPriceUsd ??
              this.averageAcquisitionPriceUsd,
      totalAcquisitionCostUsd:
          totalAcquisitionCostUsd ??
              this.totalAcquisitionCostUsd,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'currencyId': currencyId,
      'amount': amount,
      'averageAcquisitionPriceUsd':
          averageAcquisitionPriceUsd,
      'totalAcquisitionCostUsd':
          totalAcquisitionCostUsd,
      'updatedAt': updatedAt.toUtc().toIso8601String(),
    };
  }

  factory Holding.fromMap(Map<String, dynamic> map) {
    final currencyId = _readRequiredString(
      map,
      'currencyId',
    );

    final amount = _readDouble(
      map,
      'amount',
    );

    final averageAcquisitionPriceUsd = _readDouble(
      map,
      'averageAcquisitionPriceUsd',
    );

    final totalAcquisitionCostUsd = _readDouble(
      map,
      'totalAcquisitionCostUsd',
    );

    final updatedAt = _readDateTime(
      map,
      'updatedAt',
    );

    if (amount < 0) {
      throw FormatException(
        'Holding amount cannot be negative.',
      );
    }

    if (averageAcquisitionPriceUsd < 0) {
      throw FormatException(
        'Average acquisition price cannot be negative.',
      );
    }

    if (totalAcquisitionCostUsd < 0) {
      throw FormatException(
        'Total acquisition cost cannot be negative.',
      );
    }

    return Holding(
      currencyId: currencyId,
      amount: amount,
      averageAcquisitionPriceUsd:
          averageAcquisitionPriceUsd,
      totalAcquisitionCostUsd:
          totalAcquisitionCostUsd,
      updatedAt: updatedAt,
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

      if (!result.isFinite) {
        throw FormatException(
          'Field "$key" must contain a finite number.',
        );
      }

      return result;
    }

    if (value is String) {
      final result = double.tryParse(value);

      if (result != null && result.isFinite) {
        return result;
      }
    }

    throw FormatException(
      'Field "$key" must be a valid number.',
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

    if (other is! Holding) {
      return false;
    }

    return currencyId == other.currencyId &&
        amount == other.amount &&
        averageAcquisitionPriceUsd ==
            other.averageAcquisitionPriceUsd &&
        totalAcquisitionCostUsd ==
            other.totalAcquisitionCostUsd &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    return Object.hash(
      currencyId,
      amount,
      averageAcquisitionPriceUsd,
      totalAcquisitionCostUsd,
      updatedAt,
    );
  }

  @override
  String toString() {
    return 'Holding('
        'currencyId: $currencyId, '
        'amount: $amount, '
        'averageAcquisitionPriceUsd: '
        '$averageAcquisitionPriceUsd, '
        'totalAcquisitionCostUsd: '
        '$totalAcquisitionCostUsd, '
        'updatedAt: $updatedAt'
        ')';
  }
}