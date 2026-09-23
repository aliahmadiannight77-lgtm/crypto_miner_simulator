/// Central theme configuration for Crypto Miner Simulator.
///
/// This file provides the application's public theme API and connects
/// the individual theme definitions into one consistent design system.
///
/// Available themes:
/// - Light
/// - Dark
/// - Neon
/// - Premium
///
/// Theme-specific color definitions live in:
/// - light_theme.dart
/// - dark_theme.dart
/// - neon_theme.dart
/// - premium_theme.dart
///
/// The rest of the application should depend on [AppTheme] rather than
/// directly constructing ThemeData in individual widgets.
library;

import 'package:flutter/material.dart';

import 'dark_theme.dart';
import 'light_theme.dart';
import 'neon_theme.dart';
import 'premium_theme.dart';

/// Available visual themes for the application.
enum AppThemeType {
  /// Default clean white/light-blue theme.
  light,

  /// Dark professional theme.
  dark,

  /// High-energy crypto/mining inspired theme.
  neon,

  /// Premium modern theme.
  premium;

  /// Converts a persisted string into an [AppThemeType].
  ///
  /// Unknown values safely fall back to [AppThemeType.light].
  static AppThemeType fromString(String? value) {
    switch (value?.trim().toLowerCase()) {
      case 'dark':
        return AppThemeType.dark;

      case 'neon':
        return AppThemeType.neon;

      case 'premium':
        return AppThemeType.premium;

      case 'light':
      default:
        return AppThemeType.light;
    }
  }

  /// Stable value used for local persistence.
  String get storageValue {
    switch (this) {
      case AppThemeType.light:
        return 'light';
      case AppThemeType.dark:
        return 'dark';
      case AppThemeType.neon:
        return 'neon';
      case AppThemeType.premium:
        return 'premium';
    }
  }

  /// Whether this theme is the default application theme.
  bool get isDefault => this == AppThemeType.light;
}

/// Central application theme manager.
abstract final class AppTheme {
  AppTheme._();

  /// Default application theme.
  ///
  /// The simulator intentionally starts with a clean white/light-blue
  /// appearance because it provides strong readability and a neutral
  /// educational interface.
  static ThemeData get light => LightTheme.data;

  /// Dark application theme.
  static ThemeData get dark => DarkTheme.data;

  /// Neon crypto/mining theme.
  static ThemeData get neon => NeonTheme.data;

  /// Premium application theme.
  static ThemeData get premium => PremiumTheme.data;

  /// Returns the appropriate [ThemeData] for [type].
  static ThemeData fromType(AppThemeType type) {
    switch (type) {
      case AppThemeType.light:
        return light;

      case AppThemeType.dark:
        return dark;

      case AppThemeType.neon:
        return neon;

      case AppThemeType.premium:
        return premium;
    }
  }

  /// Returns the theme represented by a persisted string.
  static ThemeData fromStorageValue(String? value) {
    return fromType(
      AppThemeType.fromString(value),
    );
  }

  /// Returns the default theme type.
  static AppThemeType get defaultType => AppThemeType.light;

  /// Returns all available theme types.
  static const List<AppThemeType> availableTypes =
      <AppThemeType>[
    AppThemeType.light,
    AppThemeType.dark,
    AppThemeType.neon,
    AppThemeType.premium,
  ];

  /// Returns the Material color scheme associated with [type].
  ///
  /// Keeping this accessible is useful for widgets that need semantic
  /// colors without depending on theme-specific implementation files.
  static ColorScheme colorSchemeFor(
    AppThemeType type,
  ) {
    return fromType(type).colorScheme;
  }

  /// Applies application-wide visual defaults to a base theme.
  ///
  /// Theme-specific files already provide their own configuration, while
  /// this method guarantees common interaction and component behavior.
  static ThemeData normalize(ThemeData theme) {
    final ColorScheme scheme = theme.colorScheme;

    return theme.copyWith(
      useMaterial3: true,

      visualDensity: VisualDensity.standard,

      materialTapTargetSize: MaterialTapTargetSize.padded,

      splashFactory: InkSparkle.splashFactory,

      scaffoldBackgroundColor:
          theme.scaffoldBackgroundColor,

      colorScheme: scheme,

      dividerTheme: DividerThemeData(
        color: scheme.outlineVariant,
        thickness: 1,
        space: 1,
      ),

      popupMenuTheme: PopupMenuThemeData(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        color: scheme.surface,
      ),

      dialogTheme: DialogThemeData(
        elevation: 10,
        backgroundColor: scheme.surface,
        surfaceTintColor: scheme.surfaceTint,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        titleTextStyle: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w700,
          color: scheme.onSurface,
        ),
        contentTextStyle: theme.textTheme.bodyMedium?.copyWith(
          color: scheme.onSurfaceVariant,
        ),
      ),

      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: scheme.surface,
        surfaceTintColor: scheme.surfaceTint,
        elevation: 12,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
      ),

      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        elevation: 6,
        backgroundColor: scheme.inverseSurface,
        contentTextStyle: theme.textTheme.bodyMedium?.copyWith(
          color: scheme.onInverseSurface,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),

      tooltipTheme: TooltipThemeData(
        waitDuration: const Duration(milliseconds: 500),
        showDuration: const Duration(seconds: 3),
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: scheme.inverseSurface,
          borderRadius: BorderRadius.circular(10),
        ),
        textStyle: TextStyle(
          color: scheme.onInverseSurface,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surfaceContainerHighest,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: scheme.outline,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: scheme.outline,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: scheme.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: scheme.error,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: scheme.error,
            width: 2,
          ),
        ),
        labelStyle: TextStyle(
          color: scheme.onSurfaceVariant,
          fontWeight: FontWeight.w500,
        ),
        hintStyle: TextStyle(
          color: scheme.onSurfaceVariant.withValues(
            alpha: 0.75,
          ),
        ),
      ),

      cardTheme: CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        color: scheme.surfaceContainerLow,
        surfaceTintColor: scheme.surfaceTint,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 4,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        iconColor: scheme.onSurfaceVariant,
        textColor: scheme.onSurface,
        titleTextStyle: theme.textTheme.titleMedium?.copyWith(
          color: scheme.onSurface,
          fontWeight: FontWeight.w600,
        ),
        subtitleTextStyle: theme.textTheme.bodySmall?.copyWith(
          color: scheme.onSurfaceVariant,
        ),
      ),

      navigationBarTheme: NavigationBarThemeData(
        elevation: 3,
        height: 72,
        backgroundColor: scheme.surface,
        indicatorColor: scheme.primaryContainer,
        surfaceTintColor: scheme.surfaceTint,
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) {
            final bool selected =
                states.contains(WidgetState.selected);

            return TextStyle(
              fontSize: 12,
              fontWeight:
                  selected ? FontWeight.w700 : FontWeight.w500,
              color: selected
                  ? scheme.onSurface
                  : scheme.onSurfaceVariant,
            );
          },
        ),
        iconTheme: WidgetStateProperty.resolveWith(
          (states) {
            final bool selected =
                states.contains(WidgetState.selected);

            return IconThemeData(
              size: 24,
              color: selected
                  ? scheme.onPrimaryContainer
                  : scheme.onSurfaceVariant,
            );
          },
        ),
      ),

      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: scheme.surface,
        selectedIconTheme: IconThemeData(
          color: scheme.onPrimaryContainer,
        ),
        unselectedIconTheme: IconThemeData(
          color: scheme.onSurfaceVariant,
        ),
        selectedLabelTextStyle:
            theme.textTheme.labelMedium?.copyWith(
          color: scheme.onSurface,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelTextStyle:
            theme.textTheme.labelMedium?.copyWith(
          color: scheme.onSurfaceVariant,
          fontWeight: FontWeight.w500,
        ),
      ),

      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: theme.textTheme.titleLarge?.copyWith(
          color: scheme.onSurface,
          fontWeight: FontWeight.w700,
        ),
      ),

      tabBarTheme: TabBarThemeData(
        labelColor: scheme.primary,
        unselectedLabelColor: scheme.onSurfaceVariant,
        indicatorColor: scheme.primary,
        indicatorSize: TabBarIndicatorSize.label,
        labelStyle: theme.textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelStyle:
            theme.textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),

      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: scheme.primary,
        linearTrackColor: scheme.surfaceContainerHighest,
        circularTrackColor: scheme.surfaceContainerHighest,
      ),

      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        side: BorderSide(
          color: scheme.outline,
          width: 1.5,
        ),
      ),

      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (states) {
            if (states.contains(WidgetState.selected)) {
              return scheme.primary;
            }

            return scheme.outline;
          },
        ),
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) {
            if (states.contains(WidgetState.selected)) {
              return scheme.onPrimary;
            }

            return scheme.outline;
          },
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (states) {
            if (states.contains(WidgetState.selected)) {
              return scheme.primary;
            }

            return scheme.surfaceContainerHighest;
          },
        ),
      ),

      sliderTheme: SliderThemeData(
        activeTrackColor: scheme.primary,
        inactiveTrackColor: scheme.surfaceContainerHighest,
        thumbColor: scheme.primary,
        overlayColor: scheme.primary.withValues(
          alpha: 0.12,
        ),
        trackHeight: 5,
      ),

      floatingActionButtonTheme:
          FloatingActionButtonThemeData(
        elevation: 4,
        focusElevation: 6,
        hoverElevation: 6,
        highlightElevation: 8,
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(48, 48),
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 13,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(48, 48),
          elevation: 1,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 13,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(48, 48),
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 13,
          ),
          side: BorderSide(
            color: scheme.outline,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: const Size(48, 48),
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 10,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          minimumSize: const Size(48, 48),
          maximumSize: const Size(56, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }

  /// Returns the final production theme for [type].
  ///
  /// Every individual theme passes through [normalize] so shared component
  /// behavior remains consistent across all four visual styles.
  static ThemeData build(AppThemeType type) {
    return normalize(
      fromType(type),
    );
  }

  /// The final default theme used by the application.
  static ThemeData get defaultTheme {
    return build(AppThemeType.light);
  }

  /// Returns the theme mode equivalent used by Material where applicable.
  ///
  /// This is intentionally based on the application's explicit theme choice
  /// rather than the operating system preference.
  static ThemeMode materialModeFor(AppThemeType type) {
    switch (type) {
      case AppThemeType.light:
        return ThemeMode.light;

      case AppThemeType.dark:
      case AppThemeType.neon:
      case AppThemeType.premium:
        return ThemeMode.dark;
    }
  }
}