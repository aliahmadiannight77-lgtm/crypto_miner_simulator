import 'package:flutter/material.dart';

/// Professional dark theme for Crypto Miner Simulator.
///
/// Design goals:
/// - Deep blue/charcoal surfaces instead of pure black.
/// - Comfortable contrast for long sessions.
/// - Consistent visual language with the light theme.
/// - Suitable for mining, statistics, education and settings screens.
/// - Material 3 compatible.
/// - No external dependencies.
abstract final class DarkTheme {
  DarkTheme._();

  // ---------------------------------------------------------------------------
  // Brand colors
  // ---------------------------------------------------------------------------

  static const Color primaryBlue = Color(0xFF64B5F6);
  static const Color brightBlue = Color(0xFF42A5F5);
  static const Color secondaryBlue = Color(0xFF29B6F6);
  static const Color tertiaryBlue = Color(0xFF90CAF9);

  // ---------------------------------------------------------------------------
  // Background / surface colors
  // ---------------------------------------------------------------------------

  static const Color background = Color(0xFF0B1220);
  static const Color surface = Color(0xFF111B2A);
  static const Color surfaceElevated = Color(0xFF172437);
  static const Color surfaceHighest = Color(0xFF1D2C40);
  static const Color surfaceBlue = Color(0xFF10253B);

  // ---------------------------------------------------------------------------
  // Semantic colors
  // ---------------------------------------------------------------------------

  static const Color success = Color(0xFF69D39A);
  static const Color successContainer = Color(0xFF123D2A);

  static const Color warning = Color(0xFFFFC266);
  static const Color warningContainer = Color(0xFF473416);

  static const Color error = Color(0xFFFF8A80);
  static const Color errorContainer = Color(0xFF4A171B);

  static const Color info = Color(0xFF64B5F6);
  static const Color infoContainer = Color(0xFF123452);

  // ---------------------------------------------------------------------------
  // Text colors
  // ---------------------------------------------------------------------------

  static const Color textPrimary = Color(0xFFF3F7FB);
  static const Color textSecondary = Color(0xFFB8C5D3);
  static const Color textMuted = Color(0xFF8797A8);

  // ---------------------------------------------------------------------------
  // Borders / dividers
  // ---------------------------------------------------------------------------

  static const Color border = Color(0xFF26384D);
  static const Color borderStrong = Color(0xFF344A62);
  static const Color divider = Color(0xFF223247);

  // ---------------------------------------------------------------------------
  // Color scheme
  // ---------------------------------------------------------------------------

  static final ColorScheme colorScheme = ColorScheme(
    brightness: Brightness.dark,

    primary: primaryBlue,
    onPrimary: Color(0xFF003258),
    primaryContainer: Color(0xFF124A78),
    onPrimaryContainer: Color(0xFFD5ECFF),

    secondary: secondaryBlue,
    onSecondary: Color(0xFF00344D),
    secondaryContainer: Color(0xFF104B67),
    onSecondaryContainer: Color(0xFFC9EDFF),

    tertiary: tertiaryBlue,
    onTertiary: Color(0xFF12314E),
    tertiaryContainer: Color(0xFF294D70),
    onTertiaryContainer: Color(0xFFD8ECFF),

    error: error,
    onError: Color(0xFF5C0000),
    errorContainer: errorContainer,
    onErrorContainer: Color(0xFFFFDAD6),

    surface: surface,
    onSurface: textPrimary,

    surfaceContainerHighest: surfaceHighest,
    onSurfaceVariant: textSecondary,

    outline: borderStrong,
    outlineVariant: border,

    shadow: Colors.black,
    scrim: Colors.black,

    inverseSurface: Color(0xFFEAF2F8),
    onInverseSurface: Color(0xFF17202A),
    inversePrimary: Color(0xFF1565A8),
  );

  // ---------------------------------------------------------------------------
  // Theme data
  // ---------------------------------------------------------------------------

  static ThemeData get data {
    final ThemeData base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,

      scaffoldBackgroundColor: background,
      canvasColor: background,

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
        backgroundColor: background,
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
        color: surface,
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
      // Dialogs
      // -----------------------------------------------------------------------

      dialogTheme: const DialogThemeData(
        backgroundColor: surfaceElevated,
        surfaceTintColor: Colors.transparent,
        elevation: 12,
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
        fillColor: surfaceElevated,

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

      chipTheme: const ChipThemeData(
        backgroundColor: surfaceBlue,
        disabledColor: Color(0xFF202D3B),
        selectedColor: Color(0xFF185A8E),
        secondarySelectedColor: Color(0xFF185A8E),
        labelStyle: TextStyle(
          color: textPrimary,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        secondaryLabelStyle: TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        ),
        side: BorderSide(
          color: border,
          width: 1,
        ),
        shape: RoundedRectangleBorder(
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
        linearTrackColor: Color(0xFF25384C),
        circularTrackColor: Color(0xFF25384C),
        linearMinHeight: 6,
      ),

      // -----------------------------------------------------------------------
      // Selection
      // -----------------------------------------------------------------------

      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: primaryBlue,
        selectionColor: Color(0x5564B5F6),
        selectionHandleColor: primaryBlue,
      ),

      // -----------------------------------------------------------------------
      // Navigation
      // -----------------------------------------------------------------------

      navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: surface,
        surfaceTintColor: Colors.transparent,
        elevation: 2,
        height: 72,
        indicatorColor: Color(0xFF164A72),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        iconTheme: WidgetStatePropertyAll(
          IconThemeData(size: 24),
        ),
      ),

      // -----------------------------------------------------------------------
      // Bottom sheets
      // -----------------------------------------------------------------------

      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: surfaceElevated,
        surfaceTintColor: Colors.transparent,
        elevation: 10,
        modalElevation: 14,
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
        color: surfaceElevated,
        surfaceTintColor: Colors.transparent,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
        ),
      ),

      // -----------------------------------------------------------------------
      // Floating action button
      // -----------------------------------------------------------------------

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryBlue,
        foregroundColor: Color(0xFF003258),
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
          foregroundColor: Color(0xFF003258),
          disabledBackgroundColor: Color(0xFF2A3948),
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
          backgroundColor: surfaceElevated,
          foregroundColor: primaryBlue,
          elevation: 1,
          minimumSize: const Size(48, 48),
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 13,
          ),
          side: const BorderSide(
            color: borderStrong,
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

  /// Applies subtle interaction feedback without making the dark UI noisy.
  static ThemeData dataWithAccessibility(ThemeData theme) {
    return theme.copyWith(
      applyElevationOverlayColor: false,
      highlightColor: const Color(0x1464B5F6),
      hoverColor: const Color(0x0D64B5F6),
      focusColor: const Color(0x1A64B5F6),
      splashColor: const Color(0x1A64B5F6),
    );
  }
}