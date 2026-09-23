/// Application-wide constants.
///
/// This file contains constants that describe the application itself,
/// its supported platforms, UI defaults, localization settings, and
/// general application limits.
///
/// Game-specific values belong in `game_constants.dart`.
abstract final class AppConstants {
  AppConstants._();

  // ---------------------------------------------------------------------------
  // Application identity
  // ---------------------------------------------------------------------------

  static const String appName = 'Crypto Miner Simulator';

  static const String appShortName = 'Crypto Miner';

  static const String appVersion = '1.0.0';

  static const int buildNumber = 1;

  // ---------------------------------------------------------------------------
  // Application description
  // ---------------------------------------------------------------------------

  static const String appDescription =
      'An educational cryptocurrency mining simulator game.';

  static const String virtualEconomyNotice =
      'All currencies, prices, balances, mining rewards, and transactions '
      'in this application are virtual and have no real monetary value.';

  // ---------------------------------------------------------------------------
  // Supported languages
  // ---------------------------------------------------------------------------

  static const String defaultLanguageCode = 'fa';

  static const String englishLanguageCode = 'en';

  static const String persianLanguageCode = 'fa';

  static const String arabicLanguageCode = 'ar';

  static const List<String> supportedLanguageCodes = <String>[
    persianLanguageCode,
    englishLanguageCode,
    arabicLanguageCode,
  ];

  // ---------------------------------------------------------------------------
  // Supported platforms
  // ---------------------------------------------------------------------------

  static const String androidPlatform = 'android';

  static const String iosPlatform = 'ios';

  static const String windowsPlatform = 'windows';

  // ---------------------------------------------------------------------------
  // UI defaults
  // ---------------------------------------------------------------------------

  /// Default number of items displayed in a list before pagination/load-more
  /// logic is considered.
  static const int defaultPageSize = 20;

  /// Maximum number of items that should normally be rendered in a compact
  /// horizontal list.
  static const int compactListLimit = 10;

  /// Default animation duration used by application-level UI components.
  static const Duration defaultAnimationDuration =
      Duration(milliseconds: 250);

  /// Duration used for short visual feedback animations.
  static const Duration shortAnimationDuration =
      Duration(milliseconds: 150);

  /// Duration used for longer page or panel transitions.
  static const Duration longAnimationDuration =
      Duration(milliseconds: 400);

  // ---------------------------------------------------------------------------
  // Layout
  // ---------------------------------------------------------------------------

  static const double pageHorizontalPadding = 16.0;

  static const double pageVerticalPadding = 16.0;

  static const double cardRadius = 16.0;

  static const double buttonRadius = 14.0;

  static const double dialogRadius = 20.0;

  static const double smallSpacing = 8.0;

  static const double mediumSpacing = 12.0;

  static const double largeSpacing = 16.0;

  static const double extraLargeSpacing = 24.0;

  // ---------------------------------------------------------------------------
  // Number formatting
  // ---------------------------------------------------------------------------

  /// Maximum number of decimal places used when displaying ordinary
  /// virtual-asset values.
  static const int defaultDecimalDigits = 2;

  /// Decimal precision for very small cryptocurrency-like virtual balances.
  static const int cryptoDecimalDigits = 8;

  /// Decimal precision for virtual USD values.
  static const int usdDecimalDigits = 2;

  // ---------------------------------------------------------------------------
  // Charts
  // ---------------------------------------------------------------------------

  static const int defaultChartPointCount = 24;

  static const int detailedChartPointCount = 48;

  // ---------------------------------------------------------------------------
  // User input limits
  // ---------------------------------------------------------------------------

  static const int minimumPlayerNameLength = 2;

  static const int maximumPlayerNameLength = 30;

  static const int maximumTextInputLength = 500;

  // ---------------------------------------------------------------------------
  // Local storage
  // ---------------------------------------------------------------------------

  /// Current storage schema version.
  ///
  /// Increase this value whenever the persistent data structure changes
  /// in a way that requires migration.
  static const int storageSchemaVersion = 1;

  // ---------------------------------------------------------------------------
  // Safety / validation
  // ---------------------------------------------------------------------------

  /// Maximum amount of offline time that can generate virtual mining rewards.
  ///
  /// This is an application-level safety limit. The actual mining calculation
  /// belongs to `offline_mining_engine.dart`.
  static const Duration maximumOfflineRewardDuration =
      Duration(hours: 24);

  /// Maximum duration that the application considers for a single timer
  /// calculation.
  static const Duration maximumCalculationDuration =
      Duration(days: 30);

  // ---------------------------------------------------------------------------
  // Accessibility
  // ---------------------------------------------------------------------------

  /// Minimum recommended touch target size according to common mobile
  /// accessibility practices.
  static const double minimumTouchTargetSize = 48.0;

  // ---------------------------------------------------------------------------
  // Feature flags
  // ---------------------------------------------------------------------------

  /// Whether educational content is enabled.
  static const bool educationEnabled = true;

  /// Whether achievements are enabled.
  static const bool achievementsEnabled = true;

  /// Whether missions are enabled.
  static const bool missionsEnabled = true;

  /// Whether daily rewards are enabled.
  static const bool dailyRewardsEnabled = true;

  /// Whether mystery boxes are enabled.
  static const bool mysteryBoxesEnabled = true;

  /// Whether virtual currency conversion is enabled.
  static const bool currencyConversionEnabled = true;

  // ---------------------------------------------------------------------------
  // Privacy / legal
  // ---------------------------------------------------------------------------

  /// The application does not perform real cryptocurrency mining.
  static const bool realMiningEnabled = false;

  /// The application does not connect to real cryptocurrency exchanges.
  static const bool realExchangeEnabled = false;

  /// The application does not perform real cryptocurrency transactions.
  static const bool realTransactionsEnabled = false;

  /// The application's economy is entirely virtual.
  static const bool virtualEconomyOnly = true;
}