import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/app_constants.dart';
import '../../core/constants/storage_keys.dart';
import '../../core/errors/app_exception.dart';
import '../../core/theme/app_theme.dart';

/// Local persistence layer for application settings.
///
/// This class is intentionally limited to user/application preferences.
/// Game state and gameplay data belong to their own storage layer.
class SettingsStorage {
  SettingsStorage({
    required SharedPreferences preferences,
  }) : _preferences = preferences;

  final SharedPreferences _preferences;

  // ---------------------------------------------------------------------------
  // Language
  // ---------------------------------------------------------------------------

  String getLanguageCode() {
    final String? stored = _preferences.getString(StorageKeys.languageCode);

    if (stored == null || stored.isEmpty) {
      return AppConstants.defaultLanguageCode;
    }

    if (!AppConstants.supportedLanguageCodes.contains(stored)) {
      return AppConstants.defaultLanguageCode;
    }

    return stored;
  }

  Future<void> setLanguageCode(String languageCode) async {
    if (!AppConstants.supportedLanguageCodes.contains(languageCode)) {
      throw ValidationException(
        code: 'invalid_language',
        message: 'Unsupported language code: $languageCode',
        userMessage: 'زبان انتخاب‌شده پشتیبانی نمی‌شود.',
      );
    }

    final bool success = await _preferences.setString(
      StorageKeys.languageCode,
      languageCode,
    );

    if (!success) {
      throw StorageException(
        code: 'language_save_failed',
        message: 'Failed to save language preference.',
        userMessage: 'ذخیره زبان با خطا مواجه شد.',
      );
    }
  }

  // ---------------------------------------------------------------------------
  // Theme
  // ---------------------------------------------------------------------------

  AppThemeType getThemeType() {
    final String? stored = _preferences.getString(StorageKeys.themeMode);

    return AppTheme.fromStorageValue(stored);
  }

  Future<void> setThemeType(AppThemeType themeType) async {
    final bool success = await _preferences.setString(
      StorageKeys.themeMode,
      themeType.storageValue,
    );

    if (!success) {
      throw StorageException(
        code: 'theme_save_failed',
        message: 'Failed to save theme preference.',
        userMessage: 'ذخیره تم برنامه با خطا مواجه شد.',
      );
    }
  }

  // ---------------------------------------------------------------------------
  // Sound
  // ---------------------------------------------------------------------------

  bool getSoundEnabled() {
    return _preferences.getBool(StorageKeys.soundEnabled) ?? true;
  }

  Future<void> setSoundEnabled(bool enabled) async {
    final bool success = await _preferences.setBool(
      StorageKeys.soundEnabled,
      enabled,
    );

    if (!success) {
      throw StorageException(
        code: 'sound_setting_save_failed',
        message: 'Failed to save sound setting.',
        userMessage: 'ذخیره تنظیم صدای برنامه با خطا مواجه شد.',
      );
    }
  }

  // ---------------------------------------------------------------------------
  // Haptic feedback
  // ---------------------------------------------------------------------------

  bool getHapticFeedbackEnabled() {
    return _preferences.getBool(
          StorageKeys.hapticFeedbackEnabled,
        ) ??
        true;
  }

  Future<void> setHapticFeedbackEnabled(bool enabled) async {
    final bool success = await _preferences.setBool(
      StorageKeys.hapticFeedbackEnabled,
      enabled,
    );

    if (!success) {
      throw StorageException(
        code: 'haptic_setting_save_failed',
        message: 'Failed to save haptic feedback setting.',
        userMessage: 'ذخیره تنظیم لرزش با خطا مواجه شد.',
      );
    }
  }

  // ---------------------------------------------------------------------------
  // Notifications
  // ---------------------------------------------------------------------------

  bool getNotificationsEnabled() {
    return _preferences.getBool(
          StorageKeys.notificationsEnabled,
        ) ??
        true;
  }

  Future<void> setNotificationsEnabled(bool enabled) async {
    final bool success = await _preferences.setBool(
      StorageKeys.notificationsEnabled,
      enabled,
    );

    if (!success) {
      throw StorageException(
        code: 'notification_setting_save_failed',
        message: 'Failed to save notification setting.',
        userMessage: 'ذخیره تنظیم اعلان‌ها با خطا مواجه شد.',
      );
    }
  }

  // ---------------------------------------------------------------------------
  // Onboarding
  // ---------------------------------------------------------------------------

  bool isOnboardingCompleted() {
    return _preferences.getBool(
          StorageKeys.onboardingCompleted,
        ) ??
        false;
  }

  Future<void> setOnboardingCompleted(bool completed) async {
    final bool success = await _preferences.setBool(
      StorageKeys.onboardingCompleted,
      completed,
    );

    if (!success) {
      throw StorageException(
        code: 'onboarding_save_failed',
        message: 'Failed to save onboarding state.',
        userMessage: 'ذخیره وضعیت شروع برنامه با خطا مواجه شد.',
      );
    }
  }

  // ---------------------------------------------------------------------------
  // Disclaimer
  // ---------------------------------------------------------------------------

  bool isDisclaimerAcknowledged() {
    return _preferences.getBool(
          StorageKeys.disclaimerAcknowledged,
        ) ??
        false;
  }

  Future<void> setDisclaimerAcknowledged(bool acknowledged) async {
    final bool success = await _preferences.setBool(
      StorageKeys.disclaimerAcknowledged,
      acknowledged,
    );

    if (!success) {
      throw StorageException(
        code: 'disclaimer_save_failed',
        message: 'Failed to save disclaimer state.',
        userMessage: 'ذخیره وضعیت تأیید اطلاعیه با خطا مواجه شد.',
      );
    }
  }

  // ---------------------------------------------------------------------------
  // Generic preference helpers
  // ---------------------------------------------------------------------------

  String? getString(String key) {
    return _preferences.getString(key);
  }

  int? getInt(String key) {
    return _preferences.getInt(key);
  }

  double? getDouble(String key) {
    return _preferences.getDouble(key);
  }

  bool? getBool(String key) {
    return _preferences.getBool(key);
  }

  List<String>? getStringList(String key) {
    return _preferences.getStringList(key);
  }

  Future<void> setString(String key, String value) async {
    final bool success = await _preferences.setString(key, value);

    if (!success) {
      throw StorageException(
        code: 'string_save_failed',
        message: 'Failed to save string preference: $key',
        userMessage: 'ذخیره تنظیمات با خطا مواجه شد.',
      );
    }
  }

  Future<void> setInt(String key, int value) async {
    final bool success = await _preferences.setInt(key, value);

    if (!success) {
      throw StorageException(
        code: 'integer_save_failed',
        message: 'Failed to save integer preference: $key',
        userMessage: 'ذخیره تنظیمات با خطا مواجه شد.',
      );
    }
  }

  Future<void> setDouble(String key, double value) async {
    final bool success = await _preferences.setDouble(key, value);

    if (!success) {
      throw StorageException(
        code: 'double_save_failed',
        message: 'Failed to save numeric preference: $key',
        userMessage: 'ذخیره تنظیمات با خطا مواجه شد.',
      );
    }
  }

  Future<void> setBool(String key, bool value) async {
    final bool success = await _preferences.setBool(key, value);

    if (!success) {
      throw StorageException(
        code: 'boolean_save_failed',
        message: 'Failed to save boolean preference: $key',
        userMessage: 'ذخیره تنظیمات با خطا مواجه شد.',
      );
    }
  }

  Future<void> setStringList(
    String key,
    List<String> value,
  ) async {
    final bool success = await _preferences.setStringList(
      key,
      value,
    );

    if (!success) {
      throw StorageException(
        code: 'string_list_save_failed',
        message: 'Failed to save string list preference: $key',
        userMessage: 'ذخیره تنظیمات با خطا مواجه شد.',
      );
    }
  }

  // ---------------------------------------------------------------------------
  // Storage metadata
  // ---------------------------------------------------------------------------

  int getSchemaVersion() {
    return _preferences.getInt(StorageKeys.schemaVersion) ??
        AppConstants.storageSchemaVersion;
  }

  Future<void> setSchemaVersion(int version) async {
    if (version < 1) {
      throw ValidationException(
        code: 'invalid_schema_version',
        message: 'Schema version must be greater than zero.',
        userMessage: 'نسخه ذخیره‌سازی نامعتبر است.',
      );
    }

    final bool success = await _preferences.setInt(
      StorageKeys.schemaVersion,
      version,
    );

    if (!success) {
      throw StorageException(
        code: 'schema_version_save_failed',
        message: 'Failed to save storage schema version.',
        userMessage: 'ذخیره نسخه داده‌ها با خطا مواجه شد.',
      );
    }
  }

  bool isDataSeeded() {
    return _preferences.getBool(StorageKeys.dataSeeded) ?? false;
  }

  Future<void> setDataSeeded(bool seeded) async {
    final bool success = await _preferences.setBool(
      StorageKeys.dataSeeded,
      seeded,
    );

    if (!success) {
      throw StorageException(
        code: 'seed_state_save_failed',
        message: 'Failed to save data seed state.',
        userMessage: 'ذخیره وضعیت داده‌های اولیه با خطا مواجه شد.',
      );
    }
  }

  // ---------------------------------------------------------------------------
  // Backup / import metadata
  // ---------------------------------------------------------------------------

  String? getLastBackupAt() {
    return _preferences.getString(StorageKeys.lastBackupAt);
  }

  Future<void> setLastBackupAt(String timestamp) async {
    final bool success = await _preferences.setString(
      StorageKeys.lastBackupAt,
      timestamp,
    );

    if (!success) {
      throw StorageException(
        code: 'backup_timestamp_save_failed',
        message: 'Failed to save last backup timestamp.',
        userMessage: 'ذخیره زمان آخرین پشتیبان با خطا مواجه شد.',
      );
    }
  }

  String? getLastImportAt() {
    return _preferences.getString(StorageKeys.lastImportAt);
  }

  Future<void> setLastImportAt(String timestamp) async {
    final bool success = await _preferences.setString(
      StorageKeys.lastImportAt,
      timestamp,
    );

    if (!success) {
      throw StorageException(
        code: 'import_timestamp_save_failed',
        message: 'Failed to save last import timestamp.',
        userMessage: 'ذخیره زمان آخرین ورود داده با خطا مواجه شد.',
      );
    }
  }

  int getExportFormatVersion() {
    return _preferences.getInt(StorageKeys.exportFormatVersion) ?? 1;
  }

  Future<void> setExportFormatVersion(int version) async {
    if (version < 1) {
      throw ValidationException(
        code: 'invalid_export_format_version',
        message: 'Export format version must be greater than zero.',
        userMessage: 'نسخه فرمت خروجی نامعتبر است.',
      );
    }

    final bool success = await _preferences.setInt(
      StorageKeys.exportFormatVersion,
      version,
    );

    if (!success) {
      throw StorageException(
        code: 'export_format_version_save_failed',
        message: 'Failed to save export format version.',
        userMessage: 'ذخیره نسخه فرمت خروجی با خطا مواجه شد.',
      );
    }
  }

  // ---------------------------------------------------------------------------
  // Clear
  // ---------------------------------------------------------------------------

  Future<void> clearAllSettings() async {
    final bool success = await _preferences.clear();

    if (!success) {
      throw StorageException(
        code: 'settings_clear_failed',
        message: 'Failed to clear local settings.',
        userMessage: 'پاک‌سازی تنظیمات با خطا مواجه شد.',
      );
    }
  }
}