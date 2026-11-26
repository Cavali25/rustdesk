import 'package:flutter/material.dart';

/// Paleta corporativa oficial da Atlas Soft (Atlas Desk — Light & Dark).
/// Mantida em arquivo isolado para facilitar futuros merges com o upstream do RustDesk.
class AtlasTheme {
  AtlasTheme._();

  /// Modo de build injetado via --dart-define=ATLAS_MODE=client|full
  static const String buildMode =
      String.fromEnvironment('ATLAS_MODE', defaultValue: 'full');

  static bool get isClientBuild => buildMode.toLowerCase() == 'client';

  // --- Light Mode ---
  static const Color lightPrimary = Color(0xFF263746); // Azul Marinho Institucional
  static const Color lightAccent = Color(0xFF3730A3); // Atlas Indigo CTA
  static const Color lightAccent50 = Color(0x803730A3);
  static const Color lightAccent80 = Color(0xCC3730A3);
  static const Color lightGold = Color(0xFFA79A7A); // Dourado Metalico
  static const Color lightBackground = Color(0xFFF8FAFC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightBorder = Color(0xFFD7DDE1);
  static const Color lightTextPrimary = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF69737D);
  static const Color lightOnline = Color(0xFF16A34A);
  static const Color lightError = Color(0xFFDC2626);

  // --- Dark Mode ---
  static const Color darkPrimary = Color(0xFF182230); // Header Azul Marinho Escuro
  static const Color darkAccent = Color(0xFF6366F1); // Indigo Bright CTA
  static const Color darkGold = Color(0xFFC5B692); // Dourado Champagne
  static const Color darkBackground = Color(0xFF0F172A);
  static const Color darkSurface = Color(0xFF1E293B);
  static const Color darkBorder = Color(0xFF334155);
  static const Color darkTextPrimary = Color(0xFFF8FAFC);
  static const Color darkTextSecondary = Color(0xFF94A3B8);
  static const Color darkOnline = Color(0xFF22C55E);
  static const Color darkError = Color(0xFFF87171);

  static Color primary(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? darkGold
          : lightPrimary;

  static Color accent(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? darkAccent
          : lightAccent;

  static Color gold(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkGold : lightGold;

  static Color background(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? darkBackground
          : lightBackground;

  static Color surface(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? darkSurface
          : lightSurface;

  static Color border(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? darkBorder
          : lightBorder;

  static Color textPrimary(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? darkTextPrimary
          : lightTextPrimary;

  static Color textSecondary(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? darkTextSecondary
          : lightTextSecondary;

  static Color online(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? darkOnline
          : lightOnline;

  static Color error(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkError : lightError;
}
