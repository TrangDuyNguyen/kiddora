/// Standard spacing, radius, and touch target tokens for Kiddora
class AppValues {
  AppValues._();

  // Spacing
  static const double space1 = 5.0;
  static const double space2 = 6.0;
  static const double space3 = 7.0;
  static const double space4 = 8.0;
  static const double space5 = 10.0;
  static const double space6 = 14.0;
  static const double space7 = 16.0;
  static const double space8 = 18.5;
  static const double space9 = 24.0;
  static const double space10 = 32.0;
  static const double space11 = 48.0;

  // Radii
  static const double radiusXs = 4.0;
  static const double radiusSm = 6.0;
  static const double radiusMd = 8.0;
  static const double radiusLg = 12.0;
  static const double radiusXl = 24.0;
  static const double radiusPill = 9999.0;

  // Font Sizes (DESIGN.md Typography)
  static const double fontBadgeXs = 9.0;
  static const double fontCaptionSm = 11.0;
  static const double fontBodySm = 12.5;
  static const double fontLabelMd = 13.0;
  static const double fontBodyMd = 14.0;
  static const double fontBodyLg = 14.5;
  static const double fontTitleMd = 15.0;
  static const double fontTitleLg = 16.0;
  static const double fontTitleHero = 18.0;
  static const double fontHeadlineMd = 20.0;
  static const double fontHeadlineMid = 22.0;
  static const double fontHeadlineLg = 24.0;
  static const double fontHeadlineXl = 28.0;
  static const double fontDisplayHero = 32.0;
  static const double fontDisplayGiant = 38.0;
  static const double fontWordmark = 56.0;

  // Line Heights
  static const double lineHeightTight = 1.12;
  static const double lineHeightCompact = 1.20;
  static const double lineHeightNormal = 1.35;
  static const double lineHeightRelaxed = 1.42;

  // Letter Spacing
  static const double letterSpacingTight = -0.7;
  static const double letterSpacingCondensed = -0.3;
  static const double letterSpacingSubtle = -0.2;
  static const double letterSpacingNormal = 0.0;
  static const double letterSpacingWide = 0.3;

  // Component Specific Sizes
  static const double onboardingHeaderHeight = 152.0;
  static const double onboardingCardContentHeight = 108.0;
  static const double onboardingSkipButtonHeight = 28.0;
  static const double onboardingActionBtnSize = 58.0;
  static const double onboardingCardRadius = 36.0;

  // Touch Target
  static const double minTouchTarget = 48.0;
  static const double recommendedKidTouchTarget = 56.0;

  // Border Widths
  static const double borderWidthThin = 1.0;
  static const double borderWidthDefault = 1.5;
  static const double borderWidthHairline = 1.5;
  static const double borderWidthMedium = 1.8;
  static const double borderWidthThick = 2.5;

  // Scale & Motion
  static const double scalePressed = 0.96;
  static const double scalePressedSubtle = 0.94;
  static const double scaleSelected = 1.04;
  static const double translateYPressed = 3.0;
  static const double translateYPressedSubtle = 2.5;

  // Durations
  static const Duration durationFast = Duration(milliseconds: 70);
  static const Duration durationNormal = Duration(milliseconds: 90);
  static const Duration durationFeedback = Duration(milliseconds: 160);
  static const Duration durationBounce = Duration(milliseconds: 180);
  static const Duration durationSwitch = Duration(milliseconds: 250);
  static const Duration durationIndicator = Duration(milliseconds: 280);
  static const Duration durationPageTransition = Duration(milliseconds: 350);

  // Specific Dimensions
  static const double indicatorHeight = 9.0;
  static const double indicatorWidthActive = 26.0;
  static const double indicatorWidthInactive = 9.0;

  static const double agePebbleWidth = 72.0;
  static const double agePebbleHeight = 60.0;
  static const double agePebbleRadius = 20.0;

  static const double avatarPedestalPadding = 12.0;
  static const double avatarPedestalRadius = 24.0;
  static const double avatarInnerRadius = 18.0;
  static const double avatarInnerPadding = 6.0;
  static const double avatarGridAspectRatio = 0.92;

  static const double actionButtonSmall = 42.0;
  static const double iconSizeSm = 18.0;
  static const double iconSizeMd = 20.0;
  static const double iconSizeLg = 24.0;

  // Nickname Input
  static const double inputIconSize = 38.0;
  static const int nicknameMaxLength = 16;
  static const List<String> quickNicknames = ['Bắp', 'Sóc', 'Tin', 'Alex'];
  static const List<String> randomNicknames = [
    'Miu',
    'Ben',
    'Sam',
    'Đậu',
    'Bơ',
    'Thỏ',
    'Tom',
    'Kitty',
  ];

  // Target Ages (From 6 to 12 years old)
  static const int minAge = 6;
  static const int maxAge = 12;
  static const int defaultAge = 8;
  static const List<int> targetAges = [6, 7, 8, 9, 10, 11, 12];

  // Age Spinner Dimensions
  static const double ageSpinnerHeight = 136.0;
  static const double ageSpinnerItemExtent = 44.0;
}
