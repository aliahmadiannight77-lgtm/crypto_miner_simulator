import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/storage_keys.dart';
import '../../core/errors/app_exception.dart';

/// لایهٔ ذخیره‌سازی وضعیت بازی.
///
/// مسئولیت این کلاس:
/// - ذخیرهٔ Game State به‌صورت JSON
/// - بازیابی Game State
/// - حذف Game State
/// - بررسی وجود دادهٔ بازی
/// - نگهداری داده‌های بازی مستقل از تنظیمات برنامه
///
/// این کلاس هیچ منطق Gameplay ندارد.
/// محاسبات Mining، Upgrade، XP و Conversion باید در Domain انجام شوند.
class GameStorage {
  GameStorage({
    required SharedPreferences preferences,
  }) : _preferences = preferences;

  final SharedPreferences _preferences;

  /// آیا Game State ذخیره‌شده وجود دارد؟
  bool get hasGameState {
    return _preferences.containsKey(StorageKeys.gameState);
  }

  /// ذخیرهٔ Game State به‌صورت JSON.
  ///
  /// [gameState] باید یک Map قابل تبدیل به JSON باشد.
  Future<void> saveGameState(
    Map<String, dynamic> gameState,
  ) async {
    if (gameState.isEmpty) {
      throw ValidationException(
        code: 'empty_game_state',
        message: 'Game state cannot be empty.',
        userMessage: 'وضعیت بازی نمی‌تواند خالی باشد.',
      );
    }

    try {
      final String encoded = jsonEncode(gameState);

      final bool success = await _preferences.setString(
        StorageKeys.gameState,
        encoded,
      );

      if (!success) {
        throw StorageException(
          code: 'game_state_save_failed',
          message: 'Failed to save game state.',
          userMessage: 'ذخیره وضعیت بازی با خطا مواجه شد.',
        );
      }
    } catch (error, stackTrace) {
      if (error is AppException) {
        rethrow;
      }

      throw StorageException(
        code: 'game_state_save_failed',
        message: 'Failed to encode or save game state.',
        userMessage: 'ذخیره وضعیت بازی با خطا مواجه شد.',
        cause: error,
        stackTrace: stackTrace,
      );
    }
  }

  /// بازیابی Game State.
  ///
  /// اگر Game State وجود نداشته باشد، null برمی‌گرداند.
  Future<Map<String, dynamic>?> loadGameState() async {
    try {
      final String? encoded = _preferences.getString(
        StorageKeys.gameState,
      );

      if (encoded == null || encoded.trim().isEmpty) {
        return null;
      }

      final dynamic decoded = jsonDecode(encoded);

      if (decoded is! Map) {
        throw DataFormatException(
          code: 'invalid_game_state_format',
          message: 'Stored game state is not a JSON object.',
          userMessage: 'ساختار اطلاعات بازی نامعتبر است.',
        );
      }

      return Map<String, dynamic>.from(decoded);
    } on AppException {
      rethrow;
    } on FormatException catch (error, stackTrace) {
      throw DataFormatException(
        code: 'game_state_decode_failed',
        message: 'Failed to decode stored game state.',
        userMessage: 'خواندن اطلاعات بازی با خطا مواجه شد.',
        cause: error,
        stackTrace: stackTrace,
      );
    } catch (error, stackTrace) {
      throw StorageException(
        code: 'game_state_load_failed',
        message: 'Failed to load game state.',
        userMessage: 'بازیابی اطلاعات بازی با خطا مواجه شد.',
        cause: error,
        stackTrace: stackTrace,
      );
    }
  }

  /// حذف کامل Game State.
  Future<void> deleteGameState() async {
    try {
      final bool success = await _preferences.remove(
        StorageKeys.gameState,
      );

      if (!success) {
        throw StorageException(
          code: 'game_state_delete_failed',
          message: 'Failed to delete game state.',
          userMessage: 'حذف اطلاعات بازی با خطا مواجه شد.',
        );
      }
    } catch (error, stackTrace) {
      if (error is AppException) {
        rethrow;
      }

      throw StorageException(
        code: 'game_state_delete_failed',
        message: 'Failed to delete game state.',
        userMessage: 'حذف اطلاعات بازی با خطا مواجه شد.',
        cause: error,
        stackTrace: stackTrace,
      );
    }
  }

  /// ذخیرهٔ یک مقدار JSON عمومی برای بخش‌های Gameplay.
  ///
  /// این متد برای داده‌هایی استفاده می‌شود که هنوز مدل مستقل
  /// ندارند یا در مراحل بعدی به مدل تبدیل خواهند شد.
  Future<void> saveJson(
    String key,
    Map<String, dynamic> value,
  ) async {
    _validateKey(key);

    if (value.isEmpty) {
      throw ValidationException(
        code: 'empty_json_value',
        message: 'JSON value cannot be empty.',
        userMessage: 'داده موردنظر نمی‌تواند خالی باشد.',
      );
    }

    try {
      final String encoded = jsonEncode(value);

      final bool success = await _preferences.setString(
        key,
        encoded,
      );

      if (!success) {
        throw StorageException(
          code: 'json_save_failed',
          message: 'Failed to save JSON data for key: $key',
          userMessage: 'ذخیره اطلاعات با خطا مواجه شد.',
        );
      }
    } catch (error, stackTrace) {
      if (error is AppException) {
        rethrow;
      }

      throw StorageException(
        code: 'json_save_failed',
        message: 'Failed to encode JSON data for key: $key',
        userMessage: 'ذخیره اطلاعات با خطا مواجه شد.',
        cause: error,
        stackTrace: stackTrace,
      );
    }
  }

  /// بازیابی یک Map ذخیره‌شده به‌صورت JSON.
  Future<Map<String, dynamic>?> loadJson(String key) async {
    _validateKey(key);

    try {
      final String? encoded = _preferences.getString(key);

      if (encoded == null || encoded.trim().isEmpty) {
        return null;
      }

      final dynamic decoded = jsonDecode(encoded);

      if (decoded is! Map) {
        throw DataFormatException(
          code: 'invalid_json_object',
          message: 'Stored JSON value is not an object: $key',
          userMessage: 'ساختار داده ذخیره‌شده نامعتبر است.',
        );
      }

      return Map<String, dynamic>.from(decoded);
    } on AppException {
      rethrow;
    } on FormatException catch (error, stackTrace) {
      throw DataFormatException(
        code: 'json_decode_failed',
        message: 'Failed to decode JSON for key: $key',
        userMessage: 'خواندن داده ذخیره‌شده با خطا مواجه شد.',
        cause: error,
        stackTrace: stackTrace,
      );
    } catch (error, stackTrace) {
      throw StorageException(
        code: 'json_load_failed',
        message: 'Failed to load JSON for key: $key',
        userMessage: 'بازیابی داده با خطا مواجه شد.',
        cause: error,
        stackTrace: stackTrace,
      );
    }
  }

  /// ذخیرهٔ لیست JSON.
  Future<void> saveJsonList(
    String key,
    List<Map<String, dynamic>> values,
  ) async {
    _validateKey(key);

    try {
      final String encoded = jsonEncode(values);

      final bool success = await _preferences.setString(
        key,
        encoded,
      );

      if (!success) {
        throw StorageException(
          code: 'json_list_save_failed',
          message: 'Failed to save JSON list for key: $key',
          userMessage: 'ذخیره فهرست اطلاعات با خطا مواجه شد.',
        );
      }
    } catch (error, stackTrace) {
      if (error is AppException) {
        rethrow;
      }

      throw StorageException(
        code: 'json_list_save_failed',
        message: 'Failed to encode JSON list for key: $key',
        userMessage: 'ذخیره فهرست اطلاعات با خطا مواجه شد.',
        cause: error,
        stackTrace: stackTrace,
      );
    }
  }

  /// بازیابی لیست JSON.
  Future<List<Map<String, dynamic>>?> loadJsonList(
    String key,
  ) async {
    _validateKey(key);

    try {
      final String? encoded = _preferences.getString(key);

      if (encoded == null || encoded.trim().isEmpty) {
        return null;
      }

      final dynamic decoded = jsonDecode(encoded);

      if (decoded is! List) {
        throw DataFormatException(
          code: 'invalid_json_list',
          message: 'Stored JSON value is not a list: $key',
          userMessage: 'ساختار فهرست ذخیره‌شده نامعتبر است.',
        );
      }

      final List<Map<String, dynamic>> result =
          <Map<String, dynamic>>[];

      for (final dynamic item in decoded) {
        if (item is! Map) {
          throw DataFormatException(
            code: 'invalid_json_list_item',
            message:
                'JSON list contains a non-object item: $key',
            userMessage: 'یکی از داده‌های فهرست نامعتبر است.',
          );
        }

        result.add(Map<String, dynamic>.from(item));
      }

      return result;
    } on AppException {
      rethrow;
    } on FormatException catch (error, stackTrace) {
      throw DataFormatException(
        code: 'json_list_decode_failed',
        message: 'Failed to decode JSON list for key: $key',
        userMessage: 'خواندن فهرست اطلاعات با خطا مواجه شد.',
        cause: error,
        stackTrace: stackTrace,
      );
    } catch (error, stackTrace) {
      throw StorageException(
        code: 'json_list_load_failed',
        message: 'Failed to load JSON list for key: $key',
        userMessage: 'بازیابی فهرست اطلاعات با خطا مواجه شد.',
        cause: error,
        stackTrace: stackTrace,
      );
    }
  }

  /// ذخیرهٔ مقدار عددی.
  Future<void> saveDouble(
    String key,
    double value,
  ) async {
    _validateKey(key);

    if (!value.isFinite) {
      throw ValidationException(
        code: 'invalid_numeric_value',
        message: 'Numeric value must be finite.',
        userMessage: 'مقدار عددی نامعتبر است.',
      );
    }

    try {
      final bool success = await _preferences.setDouble(
        key,
        value,
      );

      if (!success) {
        throw StorageException(
          code: 'double_save_failed',
          message: 'Failed to save numeric value for key: $key',
          userMessage: 'ذخیره مقدار عددی با خطا مواجه شد.',
        );
      }
    } catch (error, stackTrace) {
      if (error is AppException) {
        rethrow;
      }

      throw StorageException(
        code: 'double_save_failed',
        message: 'Failed to save numeric value for key: $key',
        userMessage: 'ذخیره مقدار عددی با خطا مواجه شد.',
        cause: error,
        stackTrace: stackTrace,
      );
    }
  }

  /// خواندن مقدار عددی.
  double? loadDouble(String key) {
    _validateKey(key);

    final double? value = _preferences.getDouble(key);

    if (value != null && !value.isFinite) {
      throw DataFormatException(
        code: 'invalid_stored_double',
        message: 'Stored numeric value is not finite: $key',
        userMessage: 'مقدار عددی ذخیره‌شده نامعتبر است.',
      );
    }

    return value;
  }

  /// ذخیرهٔ مقدار صحیح.
  Future<void> saveInt(
    String key,
    int value,
  ) async {
    _validateKey(key);

    try {
      final bool success = await _preferences.setInt(
        key,
        value,
      );

      if (!success) {
        throw StorageException(
          code: 'integer_save_failed',
          message: 'Failed to save integer for key: $key',
          userMessage: 'ذخیره مقدار عددی با خطا مواجه شد.',
        );
      }
    } catch (error, stackTrace) {
      if (error is AppException) {
        rethrow;
      }

      throw StorageException(
        code: 'integer_save_failed',
        message: 'Failed to save integer for key: $key',
        userMessage: 'ذخیره مقدار عددی با خطا مواجه شد.',
        cause: error,
        stackTrace: stackTrace,
      );
    }
  }

  /// خواندن مقدار صحیح.
  int? loadInt(String key) {
    _validateKey(key);
    return _preferences.getInt(key);
  }

  /// ذخیرهٔ مقدار Boolean.
  Future<void> saveBool(
    String key,
    bool value,
  ) async {
    _validateKey(key);

    try {
      final bool success = await _preferences.setBool(
        key,
        value,
      );

      if (!success) {
        throw StorageException(
          code: 'boolean_save_failed',
          message: 'Failed to save boolean for key: $key',
          userMessage: 'ذخیره مقدار با خطا مواجه شد.',
        );
      }
    } catch (error, stackTrace) {
      if (error is AppException) {
        rethrow;
      }

      throw StorageException(
        code: 'boolean_save_failed',
        message: 'Failed to save boolean for key: $key',
        userMessage: 'ذخیره مقدار با خطا مواجه شد.',
        cause: error,
        stackTrace: stackTrace,
      );
    }
  }

  /// خواندن مقدار Boolean.
  bool? loadBool(String key) {
    _validateKey(key);
    return _preferences.getBool(key);
  }

  /// حذف دادهٔ مربوط به یک کلید.
  Future<void> delete(String key) async {
    _validateKey(key);

    try {
      final bool success = await _preferences.remove(key);

      if (!success) {
        throw StorageException(
          code: 'data_delete_failed',
          message: 'Failed to delete data for key: $key',
          userMessage: 'حذف داده با خطا مواجه شد.',
        );
      }
    } catch (error, stackTrace) {
      if (error is AppException) {
        rethrow;
      }

      throw StorageException(
        code: 'data_delete_failed',
        message: 'Failed to delete data for key: $key',
        userMessage: 'حذف داده با خطا مواجه شد.',
        cause: error,
        stackTrace: stackTrace,
      );
    }
  }

  /// اعتبارسنجی کلید storage.
  void _validateKey(String key) {
    if (key.trim().isEmpty) {
      throw ValidationException(
        code: 'empty_storage_key',
        message: 'Storage key cannot be empty.',
        userMessage: 'کلید ذخیره‌سازی نمی‌تواند خالی باشد.',
      );
    }
  }
}