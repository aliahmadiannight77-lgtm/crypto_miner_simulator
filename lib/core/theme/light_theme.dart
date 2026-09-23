import 'package:flutter/material.dart';

/// Default light theme for Crypto Miner Simulator.
///
/// Design goals:
/// - Clean white/light-blue visual identity.
/// - Suitable for both educational and game-oriented screens.
/// - Strong readability and accessible contrast.
/// - Material 3 compatible.
/// - No external fonts or packages required.
/// - Centralized colors so the rest of the application can rely
///   on ThemeData instead of hard-coded UI colors.
abstract final class LightTheme {
  LightTheme._();

  // ---------------------------------------------------------------------------
  // Brand colors
  // ---------------------------------------------------------------------------

  static const Color primaryBlue = Color(0xFF1976D2);
  static const Color brightBlue = Color(0xFF2196F3);
  static const Color lightBlue = Color(0xFF42A5F5);
  static const Color paleBlue = Color(0xFFEAF5FF);

  static const Color secondaryBlue = Color(0xFF0288D1);
  static const Color tertiaryBlue = Color(0xFF1565C0);

  // ---------------------------------------------------------------------------
  // Surface colors
  // ---------------------------------------------------------------------------

  static const Color pageBackground = Color(0xFFF6FAFF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceSoft = Color(0xFFF8FBFF);
  static const Color surfaceBlue = Color(0xFFF0F7FF);

  // ---------------------------------------------------------------------------
  // Semantic colors
  // ---------------------------------------------------------------------------

  static const Color success = Color(0xFF168A4A);
  static const Color successContainer = Color(0xFFE4F7EC);

  static const Color warning = Color(0xFFB76E00);
  static const Color warningContainer = Color(0xFFFFF3D9);

  static const Color error = Color(0xFFD32F2F);
  static const Color errorContainer = Color(0xFFFFE8E8);

  static const Color info = Color(0xFF1976D2);
  static const Color infoContainer = Color(0xFFE6F2FF);

  // ---------------------------------------------------------------------------
  // Text colors
  // ---------------------------------------------------------------------------

  static const Color textPrimary = Color(0xFF102033);
  static const Color textSecondary = Color(0xFF526477);
  static const Color textMuted = Color(0xFF748496);

  // ---------------------------------------------------------------------------
  // Border / divider colors
  // ---------------------------------------------------------------------------

  static const Color border = Color(0xFFD9E5F0);
  static const Color borderStrong = Color(0xFFC4D5E5);
  static const Color divider = Color(0xFFE5EDF4);

  // ---------------------------------------------------------------------------
  // Color scheme
  // ---------------------------------------------------------------------------

  static final ColorScheme colorScheme = ColorScheme(
    brightness: Brightness.light,

    primary: primaryBlue,
    onPrimary: Colors.white,
    primaryContainer: Color(0xFFDCEEFF),
    onPrimaryContainer: Color(0xFF003258),

    secondary: secondaryBlue,
    onSecondary: Colors.white,
    secondaryContainer: Color(0xFFD9F1FF),
    onSecondaryContainer: Color(0xFF00344D),

    tertiary: tertiaryBlue,
    onTertiary: Colors.white,
    tertiaryContainer: Color(0xFFDDE9FF),
    onTertiaryContainer: Color(0xFF002C61),

    error: error,
    onError: Colors.white,
    errorContainer: errorContainer,
    onErrorContainer: Color(0xFF5C0000),

    surface: surface,
    onSurface: textPrimary,

    surfaceContainerHighest: Color(0xFFE9F1F8),
    onSurfaceVariant: textSecondary,

    outline: borderStrong,
    outlineVariant: border,

    shadow: Color(0x22000000),
    scrim: Color(0x66000000),

    inverseSurface: Color(0xFF263746),
    onInverseSurface: Colors.white,
    inversePrimary: Color(0xFF90C8FF),
  );

  // ---------------------------------------------------------------------------
  // Theme data
  // ---------------------------------------------------------------------------

  static ThemeData get data {
    final ThemeData base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,

      scaffoldBackgroundColor: pageBackground,
      canvasColor: pageBackground,

      visualDensity: VisualDensity.standard,

      materialTapTargetSize: MaterialTapTargetSize.padded,

      splashFactory: InkSparkle.splash,

      // -----------------------------------------------------------------------
      // Typography
      // -----------------------------------------------------------------------

      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 57,
          height: 1.12,
          fontWeight: FontWeight.w700,
          color: textPrimary,
        ),
        displayMedium: TextStyle(
          fontSize: 45,
          height: 1.16,
          fontWeight: FontWeight.w700,
          color: textPrimary,
        ),
        displaySmall: TextStyle(
          fontSize: 36,
          height: 1.20,
          fontWeight: FontWeight.w700,
          color: textPrimary,
        ),
        headlineLarge: TextStyle(
          fontSize: 32,
          height: 1.25,
          fontWeight: FontWeight.w700,
          color: textPrimary,
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          height: 1.28,
          fontWeight: FontWeight.w700,
          color: textPrimary,
        ),
        headlineSmall: TextStyle(
          fontSize: 24,
          height: 1.30,
          fontWeight: FontWeight.w700,
          color: textPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          height: 1.30,
          fontWeight: FontWeight.w700,
          color: textPrimary,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          height: 1.40,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          height: 1.40,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          height: 1.50,
          fontWeight: FontWeight.w400,
          color: textPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          height: 1.50,
          fontWeight: FontWeight.w400,
          color: textSecondary,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          height: 1.45,
          fontWeight: FontWeight.w400,
          color: textMuted,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          height: 1.40,
          fontWeight: FontWeight.w700,
          color: textPrimary,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          height: 1.30,
          fontWeight: FontWeight.w600,
          color: textSecondary,
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          height: 1.30,
          fontWeight: FontWeight.w600,
          color: textMuted,
        ),
      ),

      // -----------------------------------------------------------------------
      // App bar
      // -----------------------------------------------------------------------

      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: textPrimary,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 1,
        centerTitle: false,
        titleSpacing: 16,
        iconTheme: IconThemeData(
          color: textPrimary,
          size: 24,
        ),
      ),

      // -----------------------------------------------------------------------
      // Cards
      // -----------------------------------------------------------------------

      cardTheme: const CardThemeData(
        color: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          side: BorderSide(
            color: border,
            width: 1,
          ),
        ),
      ),

      // -----------------------------------------------------------------------
      // Dialog
      // -----------------------------------------------------------------------

      dialogTheme: const DialogThemeData(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        titleTextStyle: TextStyle(
          fontSize: 22,
          height: 1.30,
          fontWeight: FontWeight.w700,
          color: textPrimary,
        ),
        contentTextStyle: TextStyle(
          fontSize: 15,
          height: 1.50,
          fontWeight: FontWeight.w400,
          color: textSecondary,
        ),
      ),

      // -----------------------------------------------------------------------
      // Input fields
      // -----------------------------------------------------------------------

      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,

        contentPadding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
          borderSide: BorderSide(
            color: border,
            width: 1,
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
          borderSide: BorderSide(
            color: border,
            width: 1,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
          borderSide: BorderSide(
            color: primaryBlue,
            width: 2,
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
          borderSide: BorderSide(
            color: error,
            width: 1,
          ),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
          borderSide: BorderSide(
            color: error,
            width: 2,
          ),
        ),

        hintStyle: TextStyle(
          color: textMuted,
          fontSize: 14,
        ),

        labelStyle: TextStyle(
          color: textSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),

        floatingLabelStyle: TextStyle(
          color: primaryBlue,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),

        prefixIconColor: textSecondary,
        suffixIconColor: textSecondary,

        errorStyle: TextStyle(
          color: error,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),

      // -----------------------------------------------------------------------
      // Chips
      // -----------------------------------------------------------------------

      chipTheme: ChipThemeData(
        backgroundColor: surfaceBlue,
        disabledColor: Color(0xFFF0F3F6),
        selectedColor: primaryBlue,
        secondarySelectedColor: primaryBlue,
        labelStyle: const TextStyle(
          color: textPrimary,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        secondaryLabelStyle: const TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        ),
        side: const BorderSide(
          color: border,
          width: 1,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),

      // -----------------------------------------------------------------------
      // Icons
      // -----------------------------------------------------------------------

      iconTheme: const IconThemeData(
        color: textSecondary,
        size: 24,
      ),

      // -----------------------------------------------------------------------
      // Divider
      // -----------------------------------------------------------------------

      dividerTheme: const DividerThemeData(
        color: divider,
        thickness: 1,
        space: 1,
      ),

      // -----------------------------------------------------------------------
      // Progress indicators
      // -----------------------------------------------------------------------

      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: primaryBlue,
        linearTrackColor: Color(0xFFDDEAF6),
        circularTrackColor: Color(0xFFDDEAF6),
        linearMinHeight: 6,
      ),

      // -----------------------------------------------------------------------
      // Selection
      // -----------------------------------------------------------------------

      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: primaryBlue,
        selectionColor: Color(0x5533A7FF),
        selectionHandleColor: primaryBlue,
      ),

      // -----------------------------------------------------------------------
      // Navigation
      // -----------------------------------------------------------------------

      navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 2,
        height: 72,
        indicatorColor: Color(0xFFDCEEFF),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        iconTheme: WidgetStatePropertyAll(
          IconThemeData(size: 24),
        ),
      ),

      // -----------------------------------------------------------------------
      // Bottom sheets
      // -----------------------------------------------------------------------

      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 8,
        modalElevation: 12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
      ),

      // -----------------------------------------------------------------------
      // Popup menus
      // -----------------------------------------------------------------------

      popupMenuTheme: const PopupMenuThemeData(
        color: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
        ),
      ),

      // -----------------------------------------------------------------------
      // Floating action button
      // -----------------------------------------------------------------------

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
        elevation: 4,
        focusElevation: 6,
        hoverElevation: 6,
        highlightElevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(18)),
        ),
      ),

      // -----------------------------------------------------------------------
      // List tiles
      // -----------------------------------------------------------------------

      listTileTheme: const ListTileThemeData(
        tileColor: Colors.transparent,
        iconColor: textSecondary,
        textColor: textPrimary,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 4,
        ),
        minLeadingWidth: 24,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
        ),
      ),

      // -----------------------------------------------------------------------
      // Tab bar
      // -----------------------------------------------------------------------

      tabBarTheme: const TabBarThemeData(
        labelColor: primaryBlue,
        unselectedLabelColor: textMuted,
        indicatorColor: primaryBlue,
        dividerColor: divider,
        labelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),

      // -----------------------------------------------------------------------
      // Buttons
      // -----------------------------------------------------------------------

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primaryBlue,
          foregroundColor: Colors.white,
          disabledBackgroundColor: const Color(0xFFD8E2EB),
          disabledForegroundColor: textMuted,
          elevation: 0,
          minimumSize: const Size(48, 48),
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 13,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(14)),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: primaryBlue,
          elevation: 1,
          minimumSize: const Size(48, 48),
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 13,
          ),
          side: const BorderSide(
            color: border,
            width: 1,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(14)),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryBlue,
          minimumSize: const Size(48, 48),
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 13,
          ),
          side: const BorderSide(
            color: primaryBlue,
            width: 1,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(14)),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryBlue,
          minimumSize: const Size(48, 48),
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 10,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: textSecondary,
          minimumSize: const Size(48, 48),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(14)),
          ),
        ),
      ),
    );

    return dataWithAccessibility(base);
  }

  /// Applies a few global accessibility-oriented text defaults.
  static ThemeData dataWithAccessibility(ThemeData theme) {
    return theme.copyWith(
      applyElevationOverlayColor: false,
      highlightColor: const Color(0x141976D2),
      hoverColor: const Color(0x0D1976D2),
      focusColor: const Color(0x1A1976D2),
      splashColor: const Color(0x1A1976D2),
    );
  }
}