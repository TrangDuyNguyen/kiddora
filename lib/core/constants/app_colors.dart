import 'package:flutter/material.dart';

/// Semantic Design Tokens for Kiddora based on DESIGN.md
class AppColors {
  AppColors._();

  // Brand Primaries & Subjects
  static const Color brandPrimary =
      Color(0xFF4648D4); // Playful Indigo: Mental Math & Main Actions
  static const Color brandIndigoLight =
      Color(0xFF6366F1); // Lighter Indigo accent
  static const Color brandSecondary =
      Color(0xFFF59E0B); // Joyful Amber: Stars, Streaks & Live Buzzer
  static const Color brandAmberLight = Color(0xFFFBBF24); // Sunny glow
  static const Color brandTertiary =
      Color(0xFFEC4899); // Bubblegum Pink: STEM Discovery & Labs
  static const Color brandPinkLight = Color(0xFFF472B6);
  static const Color brandMint =
      Color(0xFF10B981); // Meadow Mint: Success & Live Active
  static const Color brandMintLight = Color(0xFF34D399);
  static const Color brandSky =
      Color(0xFF0EA5E9); // Sky Blue: Info badges & Classmates

  // Subject Containers (DESIGN.md Containers)
  static const Color brandIndigoContainer = Color(0xFFEDE9FE);
  static const Color brandAmberContainer = Color(0xFFFEF3C7);
  static const Color brandPinkContainer = Color(0xFFFCE7F3);
  static const Color brandMintContainer = Color(0xFFD1FAE5);
  static const Color brandSkyContainer = Color(0xFFE0F2FE);

  // Surfaces & Backgrounds
  static const Color surface = Color(0xFFFCF8FF); // Warm Porcelain Canvas
  static const Color surfaceCanvas = Color(0xFFF8FAFC);
  static const Color surfaceContainer =
      Color(0xFFFFFFFF); // Pure White Clay Card
  static const Color surfaceRaised = Color(0xFFECEBF0); // Inset recessed track
  static const Color surfaceContainerHigh = Color(0xFFE9E5FF);

  // Text & Inks
  static const Color textPrimary =
      Color(0xFF0D0C22); // Deep Ink (Contrast > 15:1)
  static const Color textSecondary = Color(0xFF6E6D7A); // Slate Neutral
  static const Color textTertiary = Color(0xFF060318); // Tabular Black
  static const Color textInverse = Color(0xFFFFFFFF);

  // Borders & Feedback
  static const Color borderDefault = Color(0xFFE2E8F0);
  static const Color borderFocus = Color(0xFF6366F1); // WCAG 3px Focus Ring
  static const Color feedbackError = Color(0xFFBA1A1A); // Gentle Coral Alert

  // Tactile Claymorphism Tokens (DESIGN.md Section 2.5)
  static const Color clayHighlight =
      Color(0xD9FFFFFF); // rgba(255, 255, 255, 0.85)
  static const Color clayHighlightPure =
      Color(0xFFFFFFFF); // 100% white reflection
  static const Color clayShade = Color(0x100D0C22); // rgba(13, 12, 34, 0.06)
  static const Color clayShadow = Color(0x1F6366F1); // rgba(99, 102, 241, 0.12)
  static const Color clayCardShade =
      Color(0xFFEDEAF6); // Subtle clay card depth shade
  static const Color clayExtrusionIndigo =
      Color(0xFF3133A8); // Physical 3D extrusion base for Primary
  static const Color clayExtrusionAmber =
      Color(0xFFD97706); // Physical 3D extrusion base for Amber
  static const Color clayExtrusionMint =
      Color(0xFF059669); // Physical 3D extrusion base for Mint
  static const Color clayExtrusionDisabled =
      Color(0xFFCBD5E1); // Physical base for disabled button

  // Brand Wordmark Rainbow Tokens
  static const Color wordmarkBlue = Color(0xFF2563EB);
  static const Color wordmarkIndigo = Color(0xFF4F46E5);
  static const Color wordmarkAmber = Color(0xFFF59E0B);
  static const Color wordmarkOrange = Color(0xFFF97316);
  static const Color wordmarkCyan = Color(0xFF06B6D4);
  static const Color wordmarkPink = Color(0xFFEC4899);
  static const Color wordmarkPurple = Color(0xFF7C3AED);

  // Extended Inset & Clay Illumination Tokens
  static const Color clayHighlightStrong = Color(0xF2FFFFFF); // 95% white
  static const Color clayHighlightMedium = Color(0xB3FFFFFF); // 70% white
  static const Color clayHighlightSoft = Color(0x99FFFFFF); // 60% white
  static const Color clayHighlightMuted = Color(0x80FFFFFF); // 50% white
  static const Color clayHighlightBadge = Color(0xBFFFFFFF); // 75% white

  static const Color clayShadeDeep = Color(0x1F0D0C22); // 12% dark
  static const Color clayShadeSubtle = Color(0x0A0D0C22); // 4% dark
  static const Color clayShadeBadge = Color(0x0D0D0C22); // 5% dark
  static const Color clayContactShadow =
      Color(0x140D0C22); // 8% ambient contact

  // Pressed Squish Illumination
  static const Color claySquishShade = Color(0x2E000000); // 18% black
  static const Color claySquishHighlight = Color(0x66FFFFFF); // 40% white

  // Extrusions & Surfaces
  static const Color clayExtrusionNeutral = Color(0xFFDDD8EC);
  static const Color clayCardSurfaceLight = Color(0xFFFEFDFF);
  static const Color clayCardSurfaceTint = Color(0xFFF7F5FC);
  static const Color clayCardGradMid = Color(0xFFFCFBFE);
  static const Color clayCardGradBottom = Color(0xFFF3F0FA);
  static const Color clayIndigoGradTop = Color(0xFF6B6EFA);
  static const Color clayIndigoGradBottom = Color(0xFF383AA8);
  static const Color brandIndigoIndicator = Color(0xFF818CF8);

  // Spherical Radial Gradients (ClayIconButton)
  static const Color claySphereVioletLight = Color(0xFF8B5CF6);
  static const Color claySphereVioletMid = Color(0xFF704BEA);
  static const Color claySphereVioletDark = Color(0xFF5A31DC);
  static const Color clayWhiteGradMid = Color(0xFFFAF8FD);
  static const Color clayWhiteGradBottom = Color(0xFFF0ECF8);

  // Disabled Button Tokens
  static const Color buttonDisabledBg = Color(0xFFE5E7EB);
  static const Color buttonDisabledGradTop = Color(0xFFF3F4F6);
  static const Color buttonDisabledGradBottom = Color(0xFFD1D5DB);
  static const Color buttonDisabledText = Color(0xFF9CA3AF);

  // Streak & Star Badges
  static const Color streakOrange = Color(0xFFEA580C);
  static const Color streakExtrusion = Color(0xFFC2410C);
  static const Color starExtrusion = Color(0xFFD97706);
  static const Color streakGradStart = Color(0xFFFFF7ED);
  static const Color streakGradMid = Color(0xFFFFEDD5);
  static const Color streakGradEnd = Color(0xFFFED7AA);
  static const Color starGradStart = Color(0xFFFFFBEB);
  static const Color starGradMid = Color(0xFFFEF3C7);
  static const Color starGradEnd = Color(0xFFFDE68A);

  // Home Screen Quest Tokens
  static const Color questCardBg = Color(0xFFF0FDF4);
  static const Color progressBarMintBg = Color(0xFFDCFCE7);

  // Ambient Pastel Canvas Blobs
  static const Color blobApricot = Color(0xFFFFE5D0);
  static const Color blobPeach = Color(0xFFFFEFE6);
  static const Color blobPeachFade = Color(0x00FFF9F6);
  static const Color blobPeriwinkle = Color(0xFFE5EAFF);
  static const Color blobLavender = Color(0xFFEFF2FE);
  static const Color blobLavenderFade = Color(0x00F8F9FE);
  static const Color blobSky = Color(0xFFE2EDFE);
  static const Color blobSkyMist = Color(0xFFEEF4FE);
  static const Color blobSkyFade = Color(0x00F8FBFE);
  static const Color blobViolet = Color(0xFFEBE3FD);
  static const Color blobVioletTint = Color(0xFFF3EDFE);
  static const Color blobVioletFade = Color(0x00FAF8FE);
  static const Color blobRose = Color(0xFFFCE2F4);
  static const Color blobRoseTint = Color(0xFFFDF0F9);
  static const Color blobRoseFade = Color(0x00FFF8FD);

  // Sprint 3 — Core Screens Semantic Tokens
  static const Color surfaceLoginCanvas = Color(0xFFF3EEFC);
  static const Color surfaceField = Color(0xFFF8FAFC);
  static const Color surfaceInputPill = Color(0xFFF2F2FD);
  static const Color borderInputPill = Color(0xFFECEEF8);
  static const Color borderLight = Color(0xFFE2E8F0);
  static const Color borderSubtle = Color(0xFFCBD5E1);
  static const Color borderGoalCard = Color(0xFFFDE68A);
  static const Color textSlate = Color(0xFF6E6D7A);
  static const Color textMuted = Color(0xFF94A3B8);
  static const Color textDarkIndigo = Color(0xFF1E1B4B);
  static const Color textSlateDark = Color(0xFF475569);
  static const Color shadowIndigoSubtle = Color(0x0F4F46E5);
  static const Color shadowCardAmbient = Color(0x0D0F172A);
  static const Color stateSuccessGreen = Color(0xFF10B981);
  static const Color stateWarningAmber = Color(0xFFFBBF24);
  static const Color stateWarningContainer = Color(0xFFFEF3C7);
  static const Color socialGoogleRed = Color(0xFFEA4335);
  static const Color socialGoogleBlue = Color(0xFF4285F4);
  static const Color socialGoogleGreen = Color(0xFF34A853);
  static const Color socialGoogleYellow = Color(0xFFFBBC05);
  static const Color socialAppleDark = Color(0xFF0F172A);
  static const Color socialMsOrange = Color(0xFFF25022);
  static const Color socialMsGreen = Color(0xFF7FBA00);
  static const Color socialMsBlue = Color(0xFF00A4EF);
  static const Color socialMsYellow = Color(0xFFFFB900);
  static const Color buttonGradientStart = Color(0xFF7C5DF8);
  static const Color buttonGradientEnd = Color(0xFF5E40E3);
  static const Color buttonShadowPurple = Color(0x4D6C5CE7);
  static const Color heroGradientStart = Color(0xFFC084FC);
  static const Color heroGradientMid = Color(0xFFA855F7);
  static const Color heroGradientEnd = Color(0xFF8B5CF6);
  static const Color ringTrackLavender = Color(0xFFEDE9FE);
  static const Color ringArcPurple = Color(0xFF818CF8);
  static const Color ringArcIndigo = Color(0xFF4F46E5);
  static const Color taskCheckboxUnchecked = Color(0xFFC7D2FE);
  static const Color dividerSubtle = Color(0xFFF1F5F9);
}
