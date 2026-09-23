import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/app_constants.dart';
import '../../core/constants/storage_keys.dart';
import '../../core/errors/app_exception.dart';
import 'settings_storage.dart';

/// مرکزی‌ترین لایهٔ ذخیره‌سازی محلی برنامه.
///
/// در نسخهٔ فعلی، داده‌ها با SharedPreferences نگهداری می‌شوند.
/// این کلاس مسئول:
/// - مقداردهی اولیهٔ storage
/// - بررسی نسخهٔ schema
/// - در اختیار قرار دادن SettingsStorage
/// - reload کردن داده‌های محلی
/// - مدیریت lifecycle لایهٔ storage
///
/// توجه:
/// این کلاس دیتابیس SQL نیست. نام Database برای این است که
/// یک abstraction مرکزی برای persistence محلی پروژه فراهم کند.
class AppDatabase {
  AppDatabase._({
    required SharedPreferences preferences,
  })  : _preferences = preferences,
        _settings = SettingsStorage(preferences: preferences);

  final SharedPreferences _preferences;
  final SettingsStorage _settings;

  bool _initialized = false;

  /// ساخت و مقداردهی اولیهٔ AppDatabase.
  static Future<AppDatabase> create() async {
    try {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();

      final AppDatabase database = AppDatabase._(
        preferences: preferences,
      );

      await database.initialize();

      return database;
    } catch (error, stackTrace) {
      if (error is AppException) {
        rethrow;
      }

      throw StorageException(
        code: 'database_initialization_failed',
        message: 'Failed to initialize local database.',
        userMessage: 'راه‌اندازی ذخیره‌سازی محلی برنامه با خطا مواجه شد.',
        cause: error,
        stackTrace: stackTrace,
      );
    }
  }

  /// آیا storage با موفقیت مقداردهی اولیه شده است؟
  bool get isInitialized => _initialized;

  /// دسترسی به SharedPreferences خام.
  ///
  /// استفادهٔ مستقیم از این property باید محدود باشد.
  /// برای تنظیمات ترجیحاً از SettingsStorage استفاده شود.
  SharedPreferences get preferences => _preferences;

  /// لایهٔ ذخیره‌سازی تنظیمات برنامه.
  SettingsStorage get settings => _settings;

  /// نسخهٔ فعلی schema داده‌های برنامه.
  int get currentSchemaVersion => AppConstants.storageSchemaVersion;

  /// نسخهٔ ذخیره‌شدهٔ schema.
  int get storedSchemaVersion => _settings.getSchemaVersion();

  /// مقداردهی اولیهٔ database.
  Future<void> initialize() async {
    if (_initialized) {
      return;
    }

    try {
      final bool hasStoredSchema =
          _preferences.containsKey(StorageKeys.schemaVersion);

      if (!hasStoredSchema) {
        await _settings.setSchemaVersion(currentSchemaVersion);
      } else {
        final int storedVersion = _settings.getSchemaVersion();

        if (storedVersion < 1) {
          throw StorageException(
            code: 'invalid_stored_schema_version',
            message:
                'Stored schema version is invalid: $storedVersion.',
            userMessage: 'نسخهٔ داده‌های ذخیره‌شده نامعتبر است.',
          );
        }

        if (storedVersion > currentSchemaVersion) {
          throw ConfigurationException(
            code: 'unsupported_schema_version',
            message:
                'Stored schema version $storedVersion is newer than '
                'the supported version $currentSchemaVersion.',
            userMessage:
                'داده‌های ذخیره‌شده متعلق به نسخهٔ جدیدتری از برنامه هستند.',
          );
        }

        if (storedVersion < currentSchemaVersion) {
          await _migrate(
            fromVersion: storedVersion,
            toVersion: currentSchemaVersion,
          );
        }
      }

      _initialized = true;
    } catch (error, stackTrace) {
      if (error is AppException) {
        rethrow;
      }

      throw StorageException(
        code: 'database_initialize_failed',
        message: 'Failed to initialize application storage.',
        userMessage:
            'راه‌اندازی ذخیره‌سازی برنامه با خطا مواجه شد.',
        cause: error,
        stackTrace: stackTrace,
      );
    }
  }

  /// اجرای migration بین نسخه‌های مختلف schema.
  ///
  /// فعلاً schema نسخهٔ 1 است و migration عملی دیگری وجود ندارد.
  /// ساختار این متد برای نسخه‌های آینده حفظ شده است تا تغییر schema
  /// بدون دستکاری مستقیم سایر بخش‌های برنامه انجام شود.
  Future<void> _migrate({
    required int fromVersion,
    required int toVersion,
  }) async {
    if (fromVersion >= toVersion) {
      return;
    }

    int version = fromVersion;

    while (version < toVersion) {
      final int nextVersion = version + 1;

      await _migrateVersion(
        fromVersion: version,
        toVersion: nextVersion,
      );

      version = nextVersion;
    }

    await _settings.setSchemaVersion(toVersion);
  }

  /// migration مربوط به یک نسخه.
  ///
  /// برای اضافه شدن schema جدید، migration همان نسخه در این متد
  /// پیاده‌سازی خواهد شد.
  Future<void> _migrateVersion({
    required int fromVersion,
    required int toVersion,
  }) async {
    if (fromVersion < 1 || toVersion < 1) {
      throw StorageException(
        code: 'invalid_migration_version',
        message:
            'Invalid migration: $fromVersion -> $toVersion.',
        userMessage: 'انتقال نسخهٔ داده‌ها نامعتبر است.',
      );
    }

    // Schema فعلی نسخهٔ 1 است.
    //
    // در آینده migrationهای مشخص می‌توانند به این ساختار اضافه شوند:
    //
    // if (fromVersion == 1 && toVersion == 2) {
    //   ...
    // }
  }

  /// تازه‌سازی مقادیر SharedPreferences.
  ///
  /// برای مواقعی مفید است که داده‌ها ممکن است خارج از instance
  /// فعلی تغییر کرده باشند.
  Future<void> reload() async {
    try {
      await _preferences.reload();
    } catch (error, stackTrace) {
      throw StorageException(
        code: 'database_reload_failed',
        message: 'Failed to reload local storage.',
        userMessage:
            'به‌روزرسانی داده‌های ذخیره‌شده با خطا مواجه شد.',
        cause: error,
        stackTrace: stackTrace,
      );
    }
  }

  /// بررسی وجود یک کلید در storage.
  bool containsKey(String key) {
    if (key.trim().isEmpty) {
      throw ValidationException(
        code: 'empty_storage_key',
        message: 'Storage key cannot be empty.',
        userMessage: 'کلید ذخیره‌سازی نمی‌تواند خالی باشد.',
      );
    }

    return _preferences.containsKey(key);
  }

  /// حذف یک مقدار مشخص از storage.
  Future<void> remove(String key) async {
    if (key.trim().isEmpty) {
      throw ValidationException(
        code: 'empty_storage_key',
        message: 'Storage key cannot be empty.',
        userMessage: 'کلید ذخیره‌سازی نمی‌تواند خالی باشد.',
      );
    }

    try {
      final bool success = await _preferences.remove(key);

      if (!success) {
        throw StorageException(
          code: 'storage_remove_failed',
          message: 'Failed to remove storage key: $key',
          userMessage: 'حذف دادهٔ ذخیره‌شده با خطا مواجه شد.',
        );
      }
    } catch (error, stackTrace) {
      if (error is AppException) {
        rethrow;
      }

      throw StorageException(
        code: 'storage_remove_failed',
        message: 'Failed to remove storage key: $key',
        userMessage: 'حذف دادهٔ ذخیره‌شده با خطا مواجه شد.',
        cause: error,
        stackTrace: stackTrace,
      );
    }
  }

  /// پاک‌سازی کامل storage.
  ///
  /// هشدار:
  /// این متد تمام داده‌های محلی برنامه، از جمله تنظیمات و در آینده
  /// game state را حذف می‌کند.
  ///
  /// استفاده از آن باید فقط در جریان reset کامل برنامه باشد.
  Future<void> clearAll() async {
    try {
      final bool success = await _preferences.clear();

      if (!success) {
        throw StorageException(
          code: 'database_clear_failed',
          message: 'Failed to clear application storage.',
          userMessage:
              'پاک‌سازی کامل داده‌های برنامه با خطا مواجه شد.',
        );
      }

      _initialized = false;
    } catch (error, stackTrace) {
      if (error is AppException) {
        rethrow;
      }

      throw StorageException(
        code: 'database_clear_failed',
        message: 'Failed to clear application storage.',
        userMessage:
            'پاک‌سازی کامل داده‌های برنامه با خطا مواجه شد.',
        cause: error,
        stackTrace: stackTrace,
      );
    }
  }

  /// بستن database.
  ///
  /// SharedPreferences نیاز به close واقعی ندارد؛
  /// این متد برای یکپارچگی lifecycle و امکان تغییر backend
  /// در آینده نگه داشته شده است.
  Future<void> close() async {
    _initialized = false;
  }
}