/// مدل یک ارز دیجیتال مجازی داخل بازی.
///
/// تمام قیمت‌ها، موجودی‌ها و تغییرات این مدل صرفاً مربوط به
/// اقتصاد شبیه‌سازی‌شدهٔ بازی هستند و ارزش واقعی مالی ندارند.
class Currency {
  const Currency({
    required this.id,
    required this.symbol,
    required this.name,
    required this.description,
    required this.virtualPriceUsd,
    required this.previousPriceUsd,
    required this.priceChange24hPercent,
    required this.isMineable,
    required this.isStablecoin,
    required this.decimalPlaces,
    required this.marketRank,
    required this.iconAsset,
  });

  /// شناسهٔ یکتا.
  final String id;

  /// نماد ارز؛ مانند BTC، ETH یا TON.
  final String symbol;

  /// نام کامل ارز.
  final String name;

  /// توضیح آموزشی ارز.
  final String description;

  /// قیمت مجازی فعلی بر حسب USD.
  final double virtualPriceUsd;

  /// قیمت مجازی قبلی برای محاسبهٔ تغییرات.
  final double previousPriceUsd;

  /// درصد تغییر قیمت مجازی در بازهٔ 24 ساعته.
  final double priceChange24hPercent;

  /// آیا این ارز در منطق بازی قابل استخراج است؟
  final bool isMineable;

  /// آیا ارز از نوع Stablecoin محسوب می‌شود؟
  final bool isStablecoin;

  /// تعداد رقم اعشار قابل نمایش/نگهداری.
  final int decimalPlaces;

  /// رتبهٔ نمایشی در فهرست بازار شبیه‌سازی‌شده.
  final int marketRank;

  /// مسیر آیکون محلی ارز.
  final String iconAsset;

  /// آیا قیمت نسبت به مقدار قبلی افزایش داشته است؟
  bool get isPriceUp => priceChange24hPercent > 0;

  /// آیا قیمت نسبت به مقدار قبلی کاهش داشته است؟
  bool get isPriceDown => priceChange24hPercent < 0;

  /// آیا قیمت تغییری نداشته است؟
  bool get isPriceUnchanged => priceChange24hPercent == 0;

  /// تغییر مطلق قیمت نسبت به قیمت قبلی.
  double get priceChangeUsd =>
      virtualPriceUsd - previousPriceUsd;

  /// مقدار قیمت قبلی معتبر است؟
  bool get hasPreviousPrice => previousPriceUsd > 0;

  /// درصد تغییر محاسبه‌شده از قیمت فعلی و قبلی.
  ///
  /// در صورت نبود قیمت قبلی معتبر، صفر برمی‌گرداند.
  double get calculatedPriceChangePercent {
    if (!hasPreviousPrice) {
      return 0;
    }

    return ((virtualPriceUsd - previousPriceUsd) /
            previousPriceUsd) *
        100;
  }

  /// ارزش مجازی [amount] واحد از این ارز.
  double valueOf(double amount) {
    if (!amount.isFinite || amount < 0) {
      return 0;
    }

    final double value = amount * virtualPriceUsd;

    if (!value.isFinite) {
      return 0;
    }

    return value;
  }

  /// ایجاد Currency از Map.
  factory Currency.fromMap(Map<String, dynamic> map) {
    return Currency(
      id: _readRequiredString(map, 'id'),
      symbol: _readRequiredString(map, 'symbol'),
      name: _readRequiredString(map, 'name'),
      description: _readRequiredString(map, 'description'),
      virtualPriceUsd:
          _readDouble(map, 'virtualPriceUsd'),
      previousPriceUsd:
          _readDouble(map, 'previousPriceUsd'),
      priceChange24hPercent:
          _readDouble(map, 'priceChange24hPercent'),
      isMineable:
          _readBool(map, 'isMineable'),
      isStablecoin:
          _readBool(map, 'isStablecoin'),
      decimalPlaces:
          _readInt(map, 'decimalPlaces'),
      marketRank:
          _readInt(map, 'marketRank'),
      iconAsset:
          _readRequiredString(map, 'iconAsset'),
    );
  }

  /// تبدیل Currency به Map قابل ذخیره‌سازی.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'symbol': symbol,
      'name': name,
      'description': description,
      'virtualPriceUsd': virtualPriceUsd,
      'previousPriceUsd': previousPriceUsd,
      'priceChange24hPercent': priceChange24hPercent,
      'isMineable': isMineable,
      'isStablecoin': isStablecoin,
      'decimalPlaces': decimalPlaces,
      'marketRank': marketRank,
      'iconAsset': iconAsset,
    };
  }

  /// ساخت یک Currency جدید با تغییر فیلدهای موردنظر.
  Currency copyWith({
    String? id,
    String? symbol,
    String? name,
    String? description,
    double? virtualPriceUsd,
    double? previousPriceUsd,
    double? priceChange24hPercent,
    bool? isMineable,
    bool? isStablecoin,
    int? decimalPlaces,
    int? marketRank,
    String? iconAsset,
  }) {
    return Currency(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
      description: description ?? this.description,
      virtualPriceUsd:
          virtualPriceUsd ?? this.virtualPriceUsd,
      previousPriceUsd:
          previousPriceUsd ?? this.previousPriceUsd,
      priceChange24hPercent:
          priceChange24hPercent ??
              this.priceChange24hPercent,
      isMineable:
          isMineable ?? this.isMineable,
      isStablecoin:
          isStablecoin ?? this.isStablecoin,
      decimalPlaces:
          decimalPlaces ?? this.decimalPlaces,
      marketRank:
          marketRank ?? this.marketRank,
      iconAsset:
          iconAsset ?? this.iconAsset,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is Currency &&
        other.id == id &&
        other.symbol == symbol &&
        other.name == name &&
        other.description == description &&
        other.virtualPriceUsd == virtualPriceUsd &&
        other.previousPriceUsd == previousPriceUsd &&
        other.priceChange24hPercent ==
            priceChange24hPercent &&
        other.isMineable == isMineable &&
        other.isStablecoin == isStablecoin &&
        other.decimalPlaces == decimalPlaces &&
        other.marketRank == marketRank &&
        other.iconAsset == iconAsset;
  }

  @override
  int get hashCode => Object.hash(
        id,
        symbol,
        name,
        description,
        virtualPriceUsd,
        previousPriceUsd,
        priceChange24hPercent,
        isMineable,
        isStablecoin,
        decimalPlaces,
        marketRank,
        iconAsset,
      );

  @override
  String toString() {
    return 'Currency('
        'id: $id, '
        'symbol: $symbol, '
        'name: $name, '
        'virtualPriceUsd: $virtualPriceUsd, '
        'previousPriceUsd: $previousPriceUsd, '
        'priceChange24hPercent: $priceChange24hPercent, '
        'isMineable: $isMineable, '
        'isStablecoin: $isStablecoin, '
        'decimalPlaces: $decimalPlaces, '
        'marketRank: $marketRank'
        ')';
  }

  static String _readRequiredString(
    Map<String, dynamic> map,
    String key,
  ) {
    final dynamic value = map[key];

    if (value is! String || value.trim().isEmpty) {
      throw FormatException(
        'Currency field "$key" must be a non-empty string.',
      );
    }

    return value;
  }

  static double _readDouble(
    Map<String, dynamic> map,
    String key,
  ) {
    final dynamic value = map[key];

    if (value is num) {
      final double result = value.toDouble();

      if (result.isFinite) {
        return result;
      }
    }

    throw FormatException(
      'Currency field "$key" must be a finite number.',
    );
  }

  static int _readInt(
    Map<String, dynamic> map,
    String key,
  ) {
    final dynamic value = map[key];

    if (value is int) {
      return value;
    }

    if (value is num && value == value.toInt()) {
      return value.toInt();
    }

    throw FormatException(
      'Currency field "$key" must be an integer.',
    );
  }

  static bool _readBool(
    Map<String, dynamic> map,
    String key,
  ) {
    final dynamic value = map[key];

    if (value is bool) {
      return value;
    }

    throw FormatException(
      'Currency field "$key" must be a boolean.',
    );
  }
}