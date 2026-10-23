import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_values.dart';
import '../../../../core/router/app_router.gr.dart';
import '../../../../shared/ui_kit/buttons/clay_icon_button.dart';
import '../../../../shared/ui_kit/painters/clay_inset_painter.dart';
import '../../../../shared/ui_kit/surfaces/clay_card.dart';
import '../controllers/onboarding_controller.dart';
import '../widgets/clay_page_indicator.dart';
import '../widgets/kiddora_wordmark.dart';
import '../widgets/onboarding_feature_chips.dart';
import '../widgets/onboarding_pastel_blobs.dart';
import '../widgets/onboarding_slide_headers.dart';
import '../widgets/slide_1_card_content.dart';

@RoutePage()
class OnboardingScreen extends ConsumerStatefulWidget {
  final int initialPage;
  const OnboardingScreen({super.key, this.initialPage = 0});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  late final PageController _pageController;
  late int _currentPage;

  static const List<FeatureChipItem> _slide2Chips = [
    FeatureChipItem(
      icon: Icons.school_rounded,
      label: AppStrings.chipInteractiveCourses,
      circleColor: AppColors.brandIndigoContainer,
      iconColor: AppColors.brandIndigoLight,
    ),
    FeatureChipItem(
      icon: Icons.sports_esports_rounded,
      label: AppStrings.chipFunActivities,
      circleColor: AppColors.brandPinkContainer,
      iconColor: AppColors.brandTertiary,
    ),
    FeatureChipItem(
      icon: Icons.bar_chart_rounded,
      label: AppStrings.chipTrackProgress,
      circleColor: AppColors.brandMintContainer,
      iconColor: AppColors.brandMint,
    ),
  ];

  static const List<FeatureChipItem> _slide3Chips = [
    FeatureChipItem(
      icon: Icons.people_alt_rounded,
      label: AppStrings.chipLiveClassroom,
      circleColor: AppColors.brandSkyContainer,
      iconColor: AppColors.brandSky,
    ),
    FeatureChipItem(
      icon: Icons.chat_bubble_rounded,
      label: AppStrings.chipInteractiveQA,
      circleColor: AppColors.brandPinkContainer,
      iconColor: AppColors.brandTertiary,
    ),
    FeatureChipItem(
      icon: Icons.star_rounded,
      label: AppStrings.chipTopCoaches,
      circleColor: AppColors.brandAmberContainer,
      iconColor: AppColors.brandSecondary,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage;
    _pageController = PageController(initialPage: widget.initialPage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(const AssetImage(AppAssets.onboarding1), context);
    precacheImage(const AssetImage(AppAssets.onboarding2), context);
    precacheImage(const AssetImage(AppAssets.onboarding3), context);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNextTap() {
    HapticFeedback.lightImpact();
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: AppValues.durationPageTransition,
        curve: Curves.easeOutCubic,
      );
    } else {
      context.router.push(const RegisterRoute());
    }
  }

  void _onSkipTap() {
    HapticFeedback.lightImpact();
    context.router.push(const KidProfileSetupRoute());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Organic Pastel Clay Blobs
          const OnboardingPastelBlobs(),

          // 2. Interactive Slides
          SafeArea(
            child: Column(
              children: [
                // Top Header Bar with separated Top Action Bar to prevent collision
                _buildTopHeader(),

                // PageView with Hero Characters
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (page) {
                      setState(() => _currentPage = page);
                      ref
                          .read(onboardingControllerProvider.notifier)
                          .setSlideIndex(page);
                    },
                    children: [
                      _buildHeroImage(AppAssets.onboarding1),
                      _buildHeroImage(AppAssets.onboarding2),
                      _buildHeroImage(AppAssets.onboarding3),
                    ],
                  ),
                ),

                // Bottom Floating Clay Card
                _buildBottomClayCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppValues.fontHeadlineMd,
        AppValues.space1,
        AppValues.fontHeadlineMd,
        0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top Action Row: Hosts Login shortcut and "Bỏ qua" button
          SizedBox(
            height: AppValues.onboardingSkipButtonHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    context.router.push(const LoginRoute());
                  },
                  child: Text(
                    AppStrings.logIn,
                    style: GoogleFonts.quicksand(
                      fontSize: AppValues.fontLabelMd,
                      fontWeight: FontWeight.w700,
                      color: AppColors.brandIndigoLight,
                    ),
                  ),
                ),
                if (_currentPage < 2)
                  _buildSkipButton()
                else
                  const SizedBox(height: AppValues.onboardingSkipButtonHeight),
              ],
            ),
          ),


          // Unified-height Header Region to eliminate transition jitter
          SizedBox(
            height: AppValues.onboardingHeaderHeight,
            child: AnimatedSwitcher(
              duration: AppValues.durationSwitch,
              child: _currentPage == 0
                  ? const Center(
                      key: ValueKey(0),
                      child: KiddoraWordmark(),
                    )
                  : _currentPage == 1
                      ? const Align(
                          key: ValueKey(1),
                          alignment: Alignment.centerLeft,
                          child: Slide2Header(),
                        )
                      : const Align(
                          key: ValueKey(2),
                          alignment: Alignment.centerLeft,
                          child: Slide3Header(),
                        ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkipButton() {
    return GestureDetector(
      onTap: _onSkipTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppValues.space6,
          vertical: AppValues.space1,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppValues.radiusPill),
          border: Border.all(
            color: Colors.white,
            width: AppValues.borderWidthHairline,
          ),
          boxShadow: [
            const BoxShadow(
              color: AppColors.borderDefault,
              offset: Offset(0, 1.5),
              blurRadius: 0,
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              offset: const Offset(0, 2),
              blurRadius: 4,
            ),
          ],
        ),
        child: CustomPaint(
          painter: const ClayInsetPainter(
            borderRadius: AppValues.radiusPill,
            highlightColor: AppColors.clayHighlight,
            shadeColor: AppColors.clayShade,
            highlightOffset: Offset(1.5, 1.5),
            shadeOffset: Offset(-1.5, -1.5),
            highlightBlur: 2.0,
            shadeBlur: 2.0,
          ),
          child: Text(
            AppStrings.skip,
            style: GoogleFonts.quicksand(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w700,
              fontSize: AppValues.fontLabelMd,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroImage(String imagePath) {
    return Transform.translate(
      offset: const Offset(0, AppValues.space5),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppValues.radiusXs),
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
            alignment: Alignment.bottomCenter,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomClayCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(
        AppValues.space7,
        0,
        AppValues.space7,
        AppValues.space6,
      ),
      child: ClayCard(
        borderRadius: AppValues.onboardingCardRadius,
        padding: const EdgeInsets.fromLTRB(
          AppValues.fontHeadlineMd,
          AppValues.fontHeadlineMd,
          AppValues.fontHeadlineMd,
          AppValues.space8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Unified-height Content Region above Navigation Row
            SizedBox(
              height: AppValues.onboardingCardContentHeight,
              child: AnimatedSwitcher(
                duration: AppValues.durationSwitch,
                child: _currentPage == 0
                    ? const Slide1CardContent(key: ValueKey(0))
                    : _currentPage == 1
                        ? const Center(
                            key: ValueKey(1),
                            child: OnboardingFeatureChips(items: _slide2Chips),
                          )
                        : const Center(
                            key: ValueKey(2),
                            child: OnboardingFeatureChips(items: _slide3Chips),
                          ),
              ),
            ),
            const SizedBox(height: AppValues.space7),

            // Bottom Control Row: Clay Page Indicator & 3D Circular Arrow Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClayPageIndicator(currentPage: _currentPage),
                ClayIconButton(
                  size: AppValues.onboardingActionBtnSize,
                  backgroundColor: AppColors.brandIndigoLight,
                  icon: const Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.white,
                    size: AppValues.fontHeadlineXl,
                  ),
                  onPressed: _onNextTap,
                ),
              ],
            ),
            if (_currentPage == 2) ...[
              const SizedBox(height: AppValues.space3),
              GestureDetector(
                onTap: _onSkipTap,
                child: Text(
                  AppStrings.exploreAsGuest,
                  style: GoogleFonts.quicksand(
                    fontSize: AppValues.fontBodySm,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                    decoration: TextDecoration.underline,
                  ),
                ),

              ),
            ],
          ],
        ),
      ),
    );
  }

}
