import 'package:flutter/material.dart';

/// Premium visual theme for Crypto Miner Simulator.
///
/// Design direction:
/// - Deep charcoal background.
/// - Refined gold/champagne accent.
/// - Warm neutral surfaces.
/// - High-end financial/dashboard appearance.
/// - Suitable for premium progression, achievements and statistics.
/// - Uses Material 3.
/// - No external dependencies.
abstract final class PremiumTheme {
  PremiumTheme._();

  // ---------------------------------------------------------------------------
  // Brand colors
  // ---------------------------------------------------------------------------

  static const Color gold = Color(0xFFD6A84F);
  static const Color brightGold = Color(0xFFE7C16B);
  static const Color champagne = Color(0xFFF0D79A);

  static const Color premiumBlue = Color(0xFF7FA8D8);
  static const Color premiumPurple = Color(0xFF9A8BC7);

  // ---------------------------------------------------------------------------
  // Background / surfaces
  // ---------------------------------------------------------------------------

  static const Color background = Color(0xFF101113);
  static const Color surface = Color(0xFF17191C);
  static const Color surfaceElevated = Color(0xFF1E2125);
  static const Color surfaceHighest = Color(0xFF282C31);

  static const Color surfaceGold = Color(0xFF211D14);

  // ---------------------------------------------------------------------------
  // Semantic colors
  // ---------------------------------------------------------------------------

  static const Color success = Color(0xFF69C995);
  static const Color successContainer = Color(0xFF123426);

  static const Color warning = Color(0xFFE6B85C);
  static const Color warningContainer = Color(0xFF3A2F16);

  static const Color error = Color(0xFFE98080);
  static const Color errorContainer = Color(0xFF421B1B);

  static const Color info = premiumBlue;
  static const Color infoContainer = Color(0xFF17293D);

  // ---------------------------------------------------------------------------
  // Text
  // ---------------------------------------------------------------------------

  static const Color textPrimary = Color(0xFFF7F4EC);
  static const Color textSecondary = Color(0xFFC6C1B7);
  static const Color textMuted = Color(0xFF918C82);

  // ---------------------------------------------------------------------------
  // Borders / dividers
  // ---------------------------------------------------------------------------

  static const Color border = Color(0xFF34363A);
  static const Color borderStrong = Color(0xFF4A4A4A);
  static const Color goldBorder = Color(0xFF66502A);
  static const Color divider = Color(0xFF2B2D30);

  // ---------------------------------------------------------------------------
  // Color scheme
  // ---------------------------------------------------------------------------

  static final ColorScheme colorScheme = ColorScheme(
    brightness: Brightness.dark,

    primary: gold,
    onPrimary: Color(0xFF2E2105),
    primaryContainer: Color(0xFF5B471D),
    onPrimaryContainer: Color(0xFFFFEFC3),

    secondary: premiumBlue,
    onSecondary: Color(0xFF142235),
    secondaryContainer: Color(0xFF304C6D),
    onSecondaryContainer: Color(0xFFD7E8FF),

    tertiary: premiumPurple,
    onTertiary: Color(0xFF241A3A),
    tertiaryContainer: Color(0xFF51466C),
    onTertiaryContainer: Color(0xFFEDE5FF),

    error: error,
    onError: Color(0xFF3B0808),
    errorContainer: errorContainer,
    onErrorContainer: Color(0xFFFFDAD7),

    surface: surface,
    onSurface: textPrimary,

    surfaceContainerHighest: surfaceHighest,
    onSurfaceVariant: textSecondary,

    outline: borderStrong,
    outlineVariant: border,

    shadow: Colors.black,
    scrim: Colors.black,

    inverseSurface: Color(0xFFF4F1E9),
    onInverseSurface: Color(0xFF20201D),
    inversePrimary: Color(0xFF8D6A22),
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
            color: gold,
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
          color: gold,
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
        backgroundColor: surfaceGold,
        disabledColor: Color(0xFF292A2B),
        selectedColor: Color(0xFF66502A),
        secondarySelectedColor: Color(0xFF4B5360),
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
        color: gold,
        linearTrackColor: Color(0xFF39352C),
        circularTrackColor: Color(0xFF39352C),
        linearMinHeight: 6,
      ),

      // -----------------------------------------------------------------------
      // Selection
      // -----------------------------------------------------------------------

      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: gold,
        selectionColor: Color(0x55D6A84F),
        selectionHandleColor: gold,
      ),

      // -----------------------------------------------------------------------
      // Navigation
      // -----------------------------------------------------------------------

      navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: surface,
        surfaceTintColor: Colors.transparent,
        elevation: 2,
        height: 72,
        indicatorColor: Color(0xFF4C3B1D),
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
        backgroundColor: gold,
        foregroundColor: Color(0xFF2E2105),
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
      // Tabs
      // -----------------------------------------------------------------------

      tabBarTheme: const TabBarThemeData(
        labelColor: gold,
        unselectedLabelColor: textMuted,
        indicatorColor: gold,
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
          backgroundColor: gold,
          foregroundColor: Color(0xFF2E2105),
          disabledBackgroundColor: Color(0xFF343331),
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
          foregroundColor: gold,
          elevation: 1,
          minimumSize: const Size(48, 48),
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 13,
          ),
          side: const BorderSide(
            color: goldBorder,
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
          foregroundColor: gold,
          minimumSize: const Size(48, 48),
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 13,
          ),
          side: const BorderSide(
            color: gold,
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
          foregroundColor: gold,
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

  /// Keeps premium interactions subtle and refined.
  static ThemeData dataWithAccessibility(ThemeData theme) {
    return theme.copyWith(
      applyElevationOverlayColor: false,
      highlightColor: const Color(0x14D6A84F),
      hoverColor: const Color(0x0DD6A84F),
      focusColor: const Color(0x1AD6A84F),
      splashColor: const Color(0x1AD6A84F),
    );
  }
}