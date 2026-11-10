import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_values.dart';
import '../../../../core/router/app_router.gr.dart';

typedef _SlideSpec = ({
  String title,
  String subtitle,
  List<Color> colors,
  Color shadow,
  String asset,
  bool flushBottom,
  VoidCallback onTap,
});

class HomeHeroBanner extends StatefulWidget {
  final VoidCallback onActionTap;
  final VoidCallback? onPlaygroundTap;
  final VoidCallback? onQuestTap;

  const HomeHeroBanner({
    super.key,
    required this.onActionTap,
    this.onPlaygroundTap,
    this.onQuestTap,
  });

  @override
  State<HomeHeroBanner> createState() => _HomeHeroBannerState();
}

class _HomeHeroBannerState extends State<HomeHeroBanner> {
  final _pageController = PageController();
  int _index = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<_SlideSpec> _slides(BuildContext context) => [
        (
          title: AppStrings.keepLearningHeroTitle,
          subtitle: AppStrings.keepLearningHeroSubtitle,
          colors: const [
            AppColors.heroGradientStart,
            AppColors.heroGradientMid,
            AppColors.heroGradientEnd,
          ],
          shadow: AppColors.heroGradientMid,
          asset: 'assets/images/mascot_boy_crown.png',
          flushBottom: true,
          onTap: widget.onActionTap,
        ),
        (
          title: AppStrings.playgroundBannerTitleEn,
          subtitle: AppStrings.playgroundBannerSubtitleEn,
          colors: const [
            AppColors.heroGameGradStart,
            AppColors.heroGameGradMid,
            AppColors.heroGameGradEnd,
          ],
          shadow: AppColors.heroGameGradMid,
          asset: 'assets/images/icon_test_bag_3d.png',
          flushBottom: false,
          onTap: widget.onPlaygroundTap ?? () => _openPlayground(context),
        ),
        (
          title: AppStrings.heroSlideQuestTitle,
          subtitle: AppStrings.heroSlideQuestSubtitle,
          colors: const [
            AppColors.heroQuestGradStart,
            AppColors.heroQuestGradMid,
            AppColors.heroQuestGradEnd,
          ],
          shadow: AppColors.heroQuestGradMid,
          asset: 'assets/images/avatar_dino.png',
          flushBottom: false,
          onTap: widget.onQuestTap ?? widget.onActionTap,
        ),
      ];

  void _openPlayground(BuildContext context) {
    if (context.findAncestorWidgetOfExactType<RouterScope>() != null) {
      context.router.push(const MiniGamePlaygroundRoute());
    }
  }

  void _goToSlide(int index) {
    HapticFeedback.selectionClick();
    _pageController.animateToPage(
      index,
      duration: AppValues.durationNormal,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final slides = _slides(context);
    final active = slides[_index];
    return AnimatedContainer(
      duration: AppValues.durationNormal,
      width: double.infinity,
      height: AppValues.sizeHomeHeroH,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppValues.radiusXl),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: active.colors,
        ),
        boxShadow: [
          BoxShadow(
            color: active.shadow.withValues(alpha: 0.28),
            offset: const Offset(0, 8),
            blurRadius: AppValues.space8,
          ),
        ],
      ),
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            physics: const BouncingScrollPhysics(),
            itemCount: slides.length,
            onPageChanged: (i) {
              HapticFeedback.selectionClick();
              setState(() => _index = i);
            },
            itemBuilder: (_, i) => _buildSlide(slides[i]),
          ),
          Positioned(
            left: AppValues.space7 + AppValues.sizeCircleButtonMd + AppValues.space4,
            bottom: AppValues.space5 + AppValues.space2,
            child: _buildDots(slides.length),
          ),
        ],
      ),
    );
  }

  Widget _buildSlide(_SlideSpec s) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        HapticFeedback.lightImpact();
        s.onTap();
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppValues.space7,
                AppValues.space5,
                AppValues.space2,
                AppValues.space5,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    s.title,
                    style: GoogleFonts.quicksand(
                      fontSize: AppValues.fontTitleHero,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: AppValues.lineHeightTight,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    s.subtitle,
                    style: GoogleFonts.quicksand(
                      fontSize: AppValues.fontBodySm,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withValues(alpha: 0.92),
                      height: AppValues.lineHeightCompact,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Container(
                    width: AppValues.sizeCircleButtonMd,
                    height: AppValues.sizeCircleButtonMd,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.arrow_forward_rounded,
                      size: AppValues.iconSizeLg,
                      color: AppColors.textDarkIndigo,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: EdgeInsets.only(
                top: s.flushBottom ? AppValues.space2 : AppValues.space4,
                right: AppValues.space4,
                bottom: s.flushBottom ? 0 : AppValues.space4,
              ),
              child: Align(
                alignment: s.flushBottom ? Alignment.bottomCenter : Alignment.center,
                child: Image.asset(s.asset, fit: BoxFit.contain),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDots(int count) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (i) {
        final active = i == _index;
        return GestureDetector(
          onTap: () => _goToSlide(i),
          child: AnimatedContainer(
            duration: AppValues.durationFast,
            margin: const EdgeInsets.only(right: AppValues.space2),
            width: active ? AppValues.sizeHeroDotActiveW : AppValues.sizeHeroDotInactiveW,
            height: AppValues.sizeHeroDotH,
            decoration: BoxDecoration(
              color: active ? Colors.white : Colors.white.withValues(alpha: 0.45),
              borderRadius: BorderRadius.circular(AppValues.radiusPill),
            ),
          ),
        );
      }),
    );
  }
}
