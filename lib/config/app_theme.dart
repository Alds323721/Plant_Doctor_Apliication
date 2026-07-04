import 'package:flutter/material.dart';

class AppTheme {
  // Color Palette based on Design.md
  static const Color primaryGreen = Color(0xFF2E7D32); // Hijau Zamrud
  static const Color lightGreen = Color(0xFF4CAF50); // Hijau Daun
  static const Color backgroundColor = Color(0xFFFFFFFF); // Putih bersihh
  static const Color offWhiteBackground = Color(0xFFF9F9F9); // Off-white
  static const Color accentYellow = Color(0xFFFFC107); // Kuning cerah
  static const Color accentOrange = Color(0xFFFFB74D); // Orange pastel
  static const Color textDark = Color(0xFF333333); // Abu-abu gelap
  static const Color textLight = Color(0xFF666666); // Abu-abu medium
  static const Color errorRed = Color(0xFFD32F2F); // Merah untuk penyakit parah
  static const Color warningYellow = Color(0xFFFFA726); // Kuning untuk penyakit ringan
  static const Color successGreen = Color(0xFF388E3C); // Hijau untuk sehat

  // Text Styles
  static const TextStyle headingLarge = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: textDark,
  );

  static const TextStyle headingMedium = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: textDark,
  );

  static const TextStyle headingSmall = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: textDark,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: textDark,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: textDark,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: textLight,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  // Card Style
  static BoxDecoration cardDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.05),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ],
  );

  // Theme Data
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryGreen,
        primary: primaryGreen,
        secondary: lightGreen,
        surface: backgroundColor,
        error: errorRed,
      ),
      scaffoldBackgroundColor: offWhiteBackground,
      
      // AppBar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),

      // Card Theme
      cardTheme: CardTheme(
        color: Colors.white,
        elevation: 2,
        shadowColor: Colors.black.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      // FloatingActionButton Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        elevation: 4,
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryGreen, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),

      // Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGreen,
          foregroundColor: Colors.white,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: buttonText,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryGreen,
          side: const BorderSide(color: primaryGreen, width: 2),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: buttonText.copyWith(color: primaryGreen),
        ),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: primaryGreen,
        size: 24,
      ),

      // Text Theme
      textTheme: const TextTheme(
        headlineLarge: headingLarge,
        headlineMedium: headingMedium,
        headlineSmall: headingSmall,
        bodyLarge: bodyLarge,
        bodyMedium: bodyMedium,
        bodySmall: bodySmall,
      ),
    );
  }

  // Helper method to get severity color
  static Color getSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'severe':
      case 'parah':
        return errorRed;
      case 'moderate':
      case 'sedang':
        return warningYellow;
      case 'mild':
      case 'ringan':
        return accentOrange;
      case 'healthy':
      case 'sehat':
        return successGreen;
      default:
        return textLight;
    }
  }

  // Helper method to get accuracy badge color
  static Color getAccuracyColor(double accuracy) {
    if (accuracy >= 0.8) {
      return successGreen;
    } else if (accuracy >= 0.6) {
      return warningYellow;
    } else {
      return errorRed;
    }
  }
}
