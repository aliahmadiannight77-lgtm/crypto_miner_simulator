/// Application localization infrastructure.
///
/// Supported languages:
/// - Persian (fa)
/// - English (en)
/// - Arabic (ar)
///
/// The localization layer is intentionally lightweight and independent
/// from third-party localization packages so the application can keep
/// deterministic offline behavior.
library;

import 'package:flutter/widgets.dart';

import 'ar.dart';
import 'en.dart';
import 'fa.dart';

/// Supported application locale codes.
enum AppLanguage {
  persian('fa'),
  english('en'),
  arabic('ar');

  const AppLanguage(this.code);

  /// ISO-style language code used by the application.
  final String code;

  /// Converts a language code into [AppLanguage].
  ///
  /// Unknown or unsupported values fall back to Persian.
  static AppLanguage fromCode(String? code) {
    switch (code?.toLowerCase()) {
      case 'en':
      case 'en_us':
      case 'en-us':
      case 'en_gb':
      case 'en-gb':
        return AppLanguage.english;

      case 'ar':
      case 'ar_sa':
      case 'ar-sa':
      case 'ar_ae':
      case 'ar-ae':
        return AppLanguage.arabic;

      case 'fa':
      case 'fa_ir':
      case 'fa-ir':
      default:
        return AppLanguage.persian;
    }
  }

  /// Converts this language to a Flutter [Locale].
  Locale get locale => Locale(code);

  /// Returns whether the language uses a right-to-left writing direction.
  bool get isRtl =>
      this == AppLanguage.persian ||
      this == AppLanguage.arabic;

  /// Display name of the language in its own language.
  String get nativeName {
    switch (this) {
      case AppLanguage.persian:
        return 'فارسی';
      case AppLanguage.english:
        return 'English';
      case AppLanguage.arabic:
        return 'العربية';
    }
  }
}

/// Application localization delegate.
class AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLanguage.fromCode(locale.languageCode).code ==
        locale.languageCode;
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(
      AppLanguage.fromCode(locale.languageCode),
    );
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}

/// Main localization class.
///
/// All UI text should eventually be accessed through this class instead
/// of hard-coding user-facing strings inside widgets.
class AppLocalizations {
  AppLocalizations(this.language);

  /// Current application language.
  final AppLanguage language;

  /// Current Flutter locale.
  Locale get locale => language.locale;

  /// Whether the current language is right-to-left.
  bool get isRtl => language.isRtl;

  /// Returns the localized string identified by [key].
  ///
  /// This method is useful when a translation key is required dynamically.
  String text(String key) {
    final translations = _translationsFor(language);

    return translations[key] ??
        _translationsFor(AppLanguage.english)[key] ??
        key;
  }

  /// Retrieves the localized text and interpolates named parameters.
  ///
  /// Example:
  /// `tr('welcome_user', {'name': 'Ali'})`
  ///
  /// Translation strings can contain placeholders such as `{name}`.
  String tr(
    String key, [
    Map<String, Object?> parameters = const <String, Object?>{},
  ]) {
    var value = text(key);

    for (final entry in parameters.entries) {
      value = value.replaceAll(
        '{${entry.key}}',
        '${entry.value ?? ''}',
      );
    }

    return value;
  }

  /// Returns the translated application name.
  String get appName => text('app_name');

  /// Navigation labels.
  String get home => text('home');
  String get boost => text('boost');
  String get currencies => text('currencies');
  String get settings => text('settings');

  /// Common actions.
  String get confirm => text('confirm');
  String get cancel => text('cancel');
  String get close => text('close');
  String get save => text('save');
  String get delete => text('delete');
  String get edit => text('edit');
  String get retry => text('retry');
  String get continueText => text('continue');
  String get back => text('back');
  String get next => text('next');
  String get done => text('done');
  String get start => text('start');
  String get claim => text('claim');
  String get upgrade => text('upgrade');
  String get convert => text('convert');
  String get learn => text('learn');

  /// Home / mining.
  String get mining => text('mining');
  String get mine => text('mine');
  String get miningPower => text('mining_power');
  String get miningRate => text('mining_rate');
  String get balance => text('balance');
  String get totalEarnings => text('total_earnings');
  String get collected => text('collected');
  String get miner => text('miner');
  String get minerLevel => text('miner_level');
  String get hashPower => text('hash_power');
  String get miningNow => text('mining_now');
  String get miningStopped => text('mining_stopped');

  /// Offline mining.
  String get offlineMining => text('offline_mining');
  String get offlineReward => text('offline_reward');
  String get welcomeBack => text('welcome_back');
  String get timeAway => text('time_away');

  /// Currencies.
  String get currency => text('currency');
  String get price => text('price');
  String get holdings => text('holdings');
  String get value => text('value');
  String get totalAssets => text('total_assets');
  String get priceChange => text('price_change');
  String get conversion => text('conversion');
  String get from => text('from');
  String get to => text('to');
  String get amount => text('amount');
  String get currentPrice => text('current_price');

  /// Miner upgrades.
  String get upgrades => text('upgrades');
  String get cpu => text('cpu');
  String get gpu => text('gpu');
  String get cooling => text('cooling');
  String get storage => text('storage');
  String get upgradeCost => text('upgrade_cost');
  String get powerIncrease => text('power_increase');
  String get maximumLevel => text('maximum_level');

  /// Progression.
  String get level => text('level');
  String get experience => text('experience');
  String get xp => text('xp');
  String get missions => text('missions');
  String get achievements => text('achievements');
  String get rewards => text('rewards');
  String get dailyReward => text('daily_reward');
  String get mysteryBox => text('mystery_box');
  String get streak => text('streak');

  /// Education.
  String get education => text('education');
  String get lessons => text('lessons');
  String get quiz => text('quiz');
  String get question => text('question');
  String get correct => text('correct');
  String get incorrect => text('incorrect');
  String get score => text('score');
  String get learnAndEarn => text('learn_and_earn');

  /// Statistics.
  String get statistics => text('statistics');
  String get totalPlayTime => text('total_play_time');
  String get totalSessions => text('total_sessions');
  String get totalActiveDays => text('total_active_days');

  /// Settings.
  String get language => text('language');
  String get theme => text('theme');
  String get sound => text('sound');
  String get hapticFeedback => text('haptic_feedback');
  String get notifications => text('notifications');
  String get privacy => text('privacy');
  String get about => text('about');

  /// Error messages.
  String get unexpectedError => text('unexpected_error');
  String get invalidData => text('invalid_data');
  String get storageError => text('storage_error');
  String get operationFailed => text('operation_failed');
  String get insufficientBalance => text('insufficient_balance');
  String get invalidAmount => text('invalid_amount');
  String get maximumLevelReached => text('maximum_level_reached');

  /// Legal / simulation notice.
  String get virtualEconomyNotice => text('virtual_economy_notice');
  String get educationalSimulation => text('educational_simulation');
  String get noRealValue => text('no_real_value');
  String get noRealMining => text('no_real_mining');
  String get noRealTransactions => text('no_real_transactions');

  /// Returns the translation map for a language.
  Map<String, String> _translationsFor(AppLanguage language) {
    switch (language) {
      case AppLanguage.persian:
        return faTranslations;

      case AppLanguage.english:
        return enTranslations;

      case AppLanguage.arabic:
        return arTranslations;
    }
  }

  /// Flutter's standard localization delegates.
  static const List<LocalizationsDelegate<AppLocalizations>> delegates =
      <LocalizationsDelegate<AppLocalizations>>[
    AppLocalizationsDelegate(),
  ];

  /// All locales supported by the application.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('fa'),
    Locale('en'),
    Locale('ar'),
  ];
}

/// Convenience extension for accessing [AppLocalizations] from [BuildContext].
extension AppLocalizationsContext on BuildContext {
  /// Returns the current application localization.
  AppLocalizations get l10n {
    final localization = Localizations.of<AppLocalizations>(
      this,
      AppLocalizations,
    );

    if (localization == null) {
      // This should only happen when the widget is used outside the
      // application's localization tree.
      return AppLocalizations(AppLanguage.persian);
    }

    return localization;
  }
}