import 'package:flutter/material.dart';

/// Neon crypto/mining theme.
///
/// Visual direction:
/// - Deep navy background.
/// - Electric blue as the primary brand color.
/// - Cyan and purple accents.
/// - High-contrast cards and controls.
/// - Designed specifically for mining, boosts, upgrades and statistics.
/// - No gradients are hard-coded here; individual widgets may add them later
///   where appropriate.
abstract final class NeonTheme {
  NeonTheme._();

  // ---------------------------------------------------------------------------
  // Brand colors
  // ---------------------------------------------------------------------------

  static const Color electricBlue = Color(0xFF00A8FF);
  static const Color cyan = Color(0xFF00E5FF);
  static const Color purple = Color(0xFF8B5CF6);
  static const Color violet = Color(0xFFA855F7);

  // ---------------------------------------------------------------------------
  // Background / surfaces
  // ---------------------------------------------------------------------------

  static const Color background = Color(0xFF050816);
  static const Color surface = Color(0xFF0A1020);
  static const Color surfaceElevated = Color(0xFF101A2E);
  static const Color surfaceHighest = Color(0xFF17243B);
  static const Color surfaceBlue = Color(0xFF081D31);
  static const Color surfacePurple = Color(0xFF17112E);

  // ---------------------------------------------------------------------------
  // Semantic colors
  // ---------------------------------------------------------------------------

  static const Color success = Color(0xFF00E676);
  static const Color successContainer = Color(0xFF073C29);

  static const Color warning = Color(0xFFFFC107);
  static const Color warningContainer = Color(0xFF40330A);

  static const Color error = Color(0xFFFF5252);
  static const Color errorContainer = Color(0xFF45121A);

  static const Color info = electricBlue;
  static const Color infoContainer = Color(0xFF082D49);

  // ---------------------------------------------------------------------------
  // Text
  // ---------------------------------------------------------------------------

  static const Color textPrimary = Color(0xFFF5FAFF);
  static const Color textSecondary = Color(0xFFB8C7DA);
  static const Color textMuted = Color(0xFF74849A);

  // ---------------------------------------------------------------------------
  // Borders / dividers
  // ---------------------------------------------------------------------------

  static const Color border = Color(0xFF1C3450);
  static const Color borderStrong = Color(0xFF285171);
  static const Color divider = Color(0xFF172A42);

  // ---------------------------------------------------------------------------
  // Color scheme
  // ---------------------------------------------------------------------------

  static final ColorScheme colorScheme = ColorScheme(
    brightness: Brightness.dark,

    primary: electricBlue,
    onPrimary: Color(0xFF001A29),
    primaryContainer: Color(0xFF064F78),
    onPrimaryContainer: Color(0xFFBFEFFF),

    secondary: cyan,
    onSecondary: Color(0xFF00252B),
    secondaryContainer: Color(0xFF075A67),
    onSecondaryContainer: Color(0xFFB8F8FF),

    tertiary: purple,
    onTertiary: Color(0xFF20004F),
    tertiaryContainer: Color(0xFF4A277F),
    onTertiaryContainer: Color(0xFFEADBFF),

    error: error,
    onError: Color(0xFF3B0005),
    errorContainer: errorContainer,
    onErrorContainer: Color(0xFFFFDAD9),

    surface: surface,
    onSurface: textPrimary,

    surfaceContainerHighest: surfaceHighest,
    onSurfaceVariant: textSecondary,

    outline: borderStrong,
    outlineVariant: border,

    shadow: Colors.black,
    scrim: Colors.black,

    inverseSurface: Color(0xFFEAF8FF),
    onInverseSurface: Color(0xFF07111C),
    inversePrimary: Color(0xFF00699F),
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
          fontWeight: FontWeight.w800,
          color: textPrimary,
        ),
        displayMedium: TextStyle(
          fontSize: 45,
          height: 1.16,
          fontWeight: FontWeight.w800,
          color: textPrimary,
        ),
        displaySmall: TextStyle(
          fontSize: 36,
          height: 1.20,
          fontWeight: FontWeight.w800,
          color: textPrimary,
        ),
        headlineLarge: TextStyle(
          fontSize: 32,
          height: 1.25,
          fontWeight: FontWeight.w800,
          color: textPrimary,
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          height: 1.28,
          fontWeight: FontWeight.w800,
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
          fontWeight: FontWeight.w700,
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
      // Dialog
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
          fontWeight: FontWeight.w800,
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
            color: electricBlue,
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
          color: electricBlue,
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
        disabledColor: Color(0xFF182131),
        selectedColor: Color(0xFF07577F),
        secondarySelectedColor: Color(0xFF4A277F),
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
        color: electricBlue,
        linearTrackColor: Color(0xFF18344B),
        circularTrackColor: Color(0xFF18344B),
        linearMinHeight: 6,
      ),

      // -----------------------------------------------------------------------
      // Selection
      // -----------------------------------------------------------------------

      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: electricBlue,
        selectionColor: Color(0x5500A8FF),
        selectionHandleColor: electricBlue,
      ),

      // -----------------------------------------------------------------------
      // Navigation
      // -----------------------------------------------------------------------

      navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: surface,
        surfaceTintColor: Colors.transparent,
        elevation: 3,
        height: 72,
        indicatorColor: Color(0xFF07577F),
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
        elevation: 12,
        modalElevation: 16,
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
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
        ),
      ),

      // -----------------------------------------------------------------------
      // Floating action button
      // -----------------------------------------------------------------------

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: electricBlue,
        foregroundColor: Color(0xFF001A29),
        elevation: 5,
        focusElevation: 7,
        hoverElevation: 7,
        highlightElevation: 9,
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
      // Tabs
      // -----------------------------------------------------------------------

      tabBarTheme: const TabBarThemeData(
        labelColor: electricBlue,
        unselectedLabelColor: textMuted,
        indicatorColor: electricBlue,
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
      // Filled buttons
      // -----------------------------------------------------------------------

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: electricBlue,
          foregroundColor: Color(0xFF001A29),
          disabledBackgroundColor: Color(0xFF273342),
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

      // -----------------------------------------------------------------------
      // Elevated buttons
      // -----------------------------------------------------------------------

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: surfaceElevated,
          foregroundColor: electricBlue,
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

      // -----------------------------------------------------------------------
      // Outlined buttons
      // -----------------------------------------------------------------------

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: electricBlue,
          minimumSize: const Size(48, 48),
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 13,
          ),
          side: const BorderSide(
            color: electricBlue,
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

      // -----------------------------------------------------------------------
      // Text buttons
      // -----------------------------------------------------------------------

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: electricBlue,
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

      // -----------------------------------------------------------------------
      // Icon buttons
      // -----------------------------------------------------------------------

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

  /// Keeps interaction feedback visible on the dark neon background
  /// without turning every tap into an excessive glow.
  static ThemeData dataWithAccessibility(ThemeData theme) {
    return theme.copyWith(
      applyElevationOverlayColor: false,
      highlightColor: const Color(0x1A00A8FF),
      hoverColor: const Color(0x1000A8FF),
      focusColor: const Color(0x1F00A8FF),
      splashColor: const Color(0x1F00A8FF),
    );
  }
}