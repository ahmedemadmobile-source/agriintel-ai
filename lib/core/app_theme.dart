import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  static const Color primary = Color(0xFF1B8A4B);
  static const Color primaryDeep = Color(0xFF0E5C31);
  static const Color leaf = Color(0xFF4CAF50);
  static const Color sun = Color(0xFFEFA53B);
  static const Color sky = Color(0xFF2E86C1);
  static const Color danger = Color(0xFFD24B3E);
  static const Color warning = Color(0xFFE08E0B);

  static const Color bgLight = Color(0xFFF4F7F3);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color borderLight = Color(0xFFE2E8E1);
  static const Color textSubtleLight = Color(0xFF5D6B62);

  static const Color bgDark = Color(0xFF0F1512);
  static const Color cardDark = Color(0xFF18201C);
  static const Color borderDark = Color(0xFF27312B);
  static const Color textSubtleDark = Color(0xFF9BAAA1);
}

class AppTheme {
  const AppTheme._();

  static ThemeData light() => _build(Brightness.light);

  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final bool isDark = brightness == Brightness.dark;
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: brightness,
    );
    final Color background = isDark ? AppColors.bgDark : AppColors.bgLight;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: isDark ? Colors.white : const Color(0xFF15211A),
        ),
        iconTheme: IconThemeData(
          color: isDark ? Colors.white : const Color(0xFF15211A),
        ),
      ),
      dividerColor: isDark ? AppColors.borderDark : AppColors.borderLight,
      splashFactory: InkRipple.splashFactory,
    );
  }
}

/// Surface colours the design uses everywhere, resolved per brightness.
extension AppSurfaces on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
  Color get cardBg => isDark ? AppColors.cardDark : AppColors.cardLight;
  Color get borderColor => isDark ? AppColors.borderDark : AppColors.borderLight;
  Color get subtleText =>
      isDark ? AppColors.textSubtleDark : AppColors.textSubtleLight;
  Color get strongText => isDark ? Colors.white : const Color(0xFF15211A);
}
