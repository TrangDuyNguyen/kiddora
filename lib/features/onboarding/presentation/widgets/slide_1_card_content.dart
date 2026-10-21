import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_values.dart';

class Slide1CardContent extends StatelessWidget {
  const Slide1CardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: AppStrings.onboardingSlide1HeroTitle,
                  style: GoogleFonts.quicksand(
                    fontSize: AppValues.fontHeadlineLg,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                    height: AppValues.lineHeightCompact,
                    letterSpacing: AppValues.letterSpacingCondensed,
                  ),
                ),
                TextSpan(
                  text: AppStrings.onboardingSlide1HeroSubtitle,
                  style: GoogleFonts.quicksand(
                    fontSize: AppValues.fontHeadlineLg,
                    fontWeight: FontWeight.w800,
                    color: AppColors.brandIndigoLight,
                    height: AppValues.lineHeightCompact,
                    letterSpacing: AppValues.letterSpacingCondensed,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppValues.space2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppValues.radiusXs),
            child: Text(
              AppStrings.onboardingSlide1Description,
              textAlign: TextAlign.center,
              style: GoogleFonts.quicksand(
                fontSize: AppValues.fontLabelMd,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
                height: AppValues.lineHeightNormal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
