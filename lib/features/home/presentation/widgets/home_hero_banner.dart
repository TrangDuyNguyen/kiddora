import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_values.dart';

class HomeHeroBanner extends StatelessWidget {
  final VoidCallback onActionTap;

  const HomeHeroBanner({
    super.key,
    required this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: AppValues.sizeHomeHeroH,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppValues.radiusXl),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.heroGradientStart,
            AppColors.heroGradientMid,
            AppColors.heroGradientEnd,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.heroGradientMid.withValues(alpha: 0.28),
            offset: const Offset(0, 8),
            blurRadius: AppValues.space8,
          ),
        ],
      ),
      child: Stack(
        children: [
          // Left Content: Texts & Circular Button
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppValues.space7,
              vertical: AppValues.space6,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.keepLearningHeroTitle,
                      style: GoogleFonts.quicksand(
                        fontSize: AppValues.fontTitleHero,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        height: AppValues.lineHeightTight,
                      ),
                    ),
                    const SizedBox(height: AppValues.radiusSm),
                    Text(
                      AppStrings.keepLearningHeroSubtitle,
                      style: GoogleFonts.quicksand(
                        fontSize: AppValues.fontBodySm,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withValues(alpha: 0.9),
                        height: AppValues.lineHeightCompact,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    onActionTap();
                  },
                  child: Container(
                    width: AppValues.sizeCircleButtonMd,
                    height: AppValues.sizeCircleButtonMd,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.clayContactShadow,
                          blurRadius: AppValues.radiusXs,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.arrow_forward_rounded,
                      size: AppValues.iconSizeLg,
                      color: AppColors.textDarkIndigo,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Right Content: Mascot Boy with Golden Crown
          Positioned(
            right: AppValues.radiusXs,
            bottom: 0,
            top: AppValues.borderWidthThick,
            child: Image.asset(
              'assets/images/mascot_boy_crown.png',
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
