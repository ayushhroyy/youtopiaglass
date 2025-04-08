import 'package:flutter/material.dart';

class AppTheme {
  // Light theme colors (Aurora inspired)
  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF6C63FF),
    onPrimary: Colors.white,
    secondary: Color(0xFF00B4D8),
    onSecondary: Colors.white,
    error: Color(0xFFE63946),
    onError: Colors.white,
    background: Color(0xFFF8F9FA),
    onBackground: Color(0xFF212529),
    surface: Color(0xFFFFFFFF),
    onSurface: Color(0xFF212529),
  );

  // Dark theme colors (Cosmic inspired)
  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF6C63FF),
    onPrimary: Colors.white,
    secondary: Color(0xFF00B4D8),
    onSecondary: Colors.white,
    error: Color(0xFFE63946),
    onError: Colors.white,
    background: Color(0xFF121212),
    onBackground: Colors.white,
    surface: Color(0xFF1E1E1E),
    onSurface: Colors.white,
  );

  // Glass effect colors
  static Color glassColor = Colors.white.withOpacity(0.1);
  static Color glassColorDark = Colors.white.withOpacity(0.05);
  static Color glassColorLight = Colors.white.withOpacity(0.15);
  
  // Glow effects
  static List<BoxShadow> getGlowingEffect(Color color, [double strength = 1.0]) {
    return [
      BoxShadow(
        color: color.withOpacity(0.3 * strength),
        blurRadius: 15.0 * strength,
        spreadRadius: 1.0 * strength,
      ),
      BoxShadow(
        color: color.withOpacity(0.2 * strength),
        blurRadius: 30.0 * strength,
        spreadRadius: 3.0 * strength,
      ),
    ];
  }

  // Gradient backgrounds
  static LinearGradient darkBackgroundGradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF0A0118),     // Deep space purple
      Color(0xFF170B3B),     // Midnight purple
      Color(0xFF1A1031),     // Dark violet
    ],
  );

  static LinearGradient lightBackgroundGradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFE6F0FF),     // Soft blue
      Color(0xFFF9F5FF),     // Light lavender
      Color(0xFFFFEEFB),     // Soft pink
    ],
  );

  // Card gradients
  static LinearGradient glassCardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.white.withOpacity(0.25),
      Colors.white.withOpacity(0.05),
    ],
  );

  // Border gradients
  static LinearGradient glowingBorderGradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF58B2DC),     // Glowing blue
      Color(0xFF9C89FF),     // Purple
      Color(0xFFFF8FB1),     // Pink
    ],
  );

  static const List<Color> auroraGradient = [
    Color(0xFF6C63FF),
    Color(0xFF00B4D8),
    Color(0xFF00F5D4),
  ];

  static const List<Color> cosmicGradient = [
    Color(0xFF1A1A2E),
    Color(0xFF16213E),
    Color(0xFF0F3460),
  ];

  static const double defaultBlur = 10.0;
  static const double defaultOpacity = 0.7;
  static const double defaultBorderRadius = 20.0;
  static const double defaultPadding = 16.0;
  static const double defaultMargin = 16.0;
}
