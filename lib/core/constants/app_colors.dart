import 'package:flutter/material.dart';

/// Semantic Design Tokens for Kiddora based on DESIGN.md
class AppColors {
  AppColors._();

  // Brand Primaries & Subjects
  static const Color brandPrimary = Color(0xFF4648D4);    // Playful Indigo: Mental Math & Main Actions
  static const Color brandIndigoLight = Color(0xFF6366F1); // Lighter Indigo accent
  static const Color brandSecondary = Color(0xFFF59E0B);  // Joyful Amber: Stars, Streaks & Live Buzzer
  static const Color brandAmberLight = Color(0xFFFBBF24); // Sunny glow
  static const Color brandTertiary = Color(0xFFEC4899);   // Bubblegum Pink: STEM Discovery & Labs
  static const Color brandPinkLight = Color(0xFFF472B6);
  static const Color brandMint = Color(0xFF10B981);       // Meadow Mint: Success & Live Active
  static const Color brandMintLight = Color(0xFF34D399);
  static const Color brandSky = Color(0xFF0EA5E9);        // Sky Blue: Info badges & Classmates

  // Surfaces & Backgrounds
  static const Color surface = Color(0xFFFCF8FF);         // Warm Porcelain Canvas
  static const Color surfaceCanvas = Color(0xFFF8FAFC);
  static const Color surfaceContainer = Color(0xFFFFFFFF); // Pure White Clay Card
  static const Color surfaceRaised = Color(0xFFECEBF0);   // Inset recessed track
  static const Color surfaceContainerHigh = Color(0xFFE9E5FF);

  // Text & Inks
  static const Color textPrimary = Color(0xFF0D0C22);     // Deep Ink (Contrast > 15:1)
  static const Color textSecondary = Color(0xFF6E6D7A);   // Slate Neutral
  static const Color textTertiary = Color(0xFF060318);    // Tabular Black
  static const Color textInverse = Color(0xFFFFFFFF);

  // Borders & Feedback
  static const Color borderDefault = Color(0xFFE2E8F0);
  static const Color borderFocus = Color(0xFF6366F1);     // WCAG 3px Focus Ring
  static const Color feedbackError = Color(0xFFBA1A1A);   // Gentle Coral Alert
}
