/// Standard spacing, radius, and touch target tokens for Kiddora
class AppValues {
  AppValues._();

  // Font Family
  static const String fontFamilyQuicksand = 'Quicksand';

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
  static const double borderWidthFocus = 3.0;

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
  static const double iconSizeXs = 11.0;
  static const double iconSizeCompact = 14.0;
  static const double iconSizeTick = 16.0;
  static const double iconSizeSm = 18.0;
  static const double iconSizeMd = 20.0;
  static const double iconSizeXl = 22.0;
  static const double iconSizeLg = 24.0;
  static const double iconSizeSocial = 26.0;

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

  // Sprint 3 Dimensions & Sizes
  static const double sizeAvatarSm = 42.0;
  static const double sizeAvatarMd = 48.0;
  static const double sizeAvatarLg = 50.0;
  static const double sizeAvatarXl = 54.0;
  static const double sizeCircleButtonSm = 36.0;
  static const double sizeCircleButtonMd = 38.0;
  static const double sizeCircleButtonLg = 42.0;
  static const double sizeCircleButtonXl = 44.0;
  static const double sizeSocialButton = 52.0;
  static const double sizeSocialButtonLg = 56.0;
  static const double sizeButtonPrimaryH = 54.0;
  static const double sizeLoginLogoH = 48.0;
  static const double sizeLoginHeroMascotH = 145.0;
  static const double sizeHomeHeroH = 155.0;
  static const double sizeGoalProgressBox = 220.0;
  static const double sizeGoalRing = 180.0;
  static const double sizeGoalMascotStar = 52.0;
  static const double sizeGoalThumbsMascot = 76.0;
  static const double sizeCourseThumbnail = 62.0;
  static const double sizeCheckbox = 22.0;
  static const double sizeGoalCheckbox = 26.0;
  static const double sizeMsLogoBox = 18.0;
  static const double sizeNotificationBadgeMin = 15.0;
  static const double waveHeaderDipH = 18.0;
  static const double waveHeaderEdgeH = 14.0;
  static const double waveHeaderCrestH = 2.0;
  static const double waveSheetTopPadding = 48.0;

  // Custom Radii
  static const double radiusInput = 16.0;
  static const double radiusPillInput = 24.0;
  static const double radiusCourseThumbnail = 14.0;
  static const double radiusCheckbox = 6.0;
  static const double radiusTaskTile = 12.0;
  static const double radiusCardLg = 20.0;
  static const double radiusBottomNav = 28.0;
  static const double radiusSheetTop = 36.0;

  // Stroke Widths
  static const double strokeWidthRing = 14.0;
  static const double strokeWidthSparkle = 3.5;
  static const double strokeWidthCheckbox = 2.0;

  // Additional Typography Tokens
  static const double fontCaptionXs = 10.0;
  static const double fontSocialG = 22.0;

  // Splash Screen Tokens
  static const Duration splashAnimDuration = Duration(milliseconds: 1800);
  static const double splashLogoSize = 120.0;
  static const double splashLogoRadius = 28.0;
  static const double splashScaleStart = 0.5;
  static const double splashTaglineOffset = 24.0;
  static const double splashShadowBlur = 40.0;
  static const double splashShadowOffsetY = 16.0;
  static const String splashLogoAsset = 'assets/images/app_icon_source.jpg';

  // Network & API Tokens
  static const Duration apiTimeout = Duration(seconds: 10);

  // Modal Dialog & Shared UI Kit Expansion Tokens
  static const Duration durationSnackBar = Duration(seconds: 2);
  static const double radiusModal = 28.0;
  static const double modalMaxWidth = 348.0;
  static const double modalMaxHeightFactor = 0.86;
  static const double modalIllustrationSize = 128.0;
  static const int modalImageCachePx = 384;
  static const double modalInsetOffset = 5.0;
  static const double modalInsetBlur = 8.0;
  static const double modalShadowBlur = 38.0;
  static const double modalShadowOffsetY = 24.0;
  static const double modalScaleStart = 0.92;
  static const double modalCloseOffset = 10.0;
  static const double sizeButtonCompactH = 38.0;
  static const double sizeFilterChipH = 40.0;
  static const double sizeMenuIconCircle = 36.0;
  static const double sizeBadgeMicroIcon = 18.0;
  static const double offsetY2 = 2.0;
  static const double offsetY3 = 3.0;
  static const double spreadSubtle = -1.0;
  static const double spreadModal = -4.0;
  static const double alphaGlowResting = 0.35;
  static const double alphaGlowPressed = 0.22;
  static const double alphaGlowDisabled = 0.05;
  static const double lerpHighlight = 0.12;
  static const double lerpShade = 0.08;
  static const double badgeInsetOffset = 2.0;
  static const double badgeInsetBlur = 3.0;
}
