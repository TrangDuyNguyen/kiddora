import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_values.dart';

class Slide2Header extends StatelessWidget {
  const Slide2Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: AppValues.radiusXs),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: AppStrings.onboardingSlide2TitlePart1,
                  style: GoogleFonts.quicksand(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize: AppValues.fontDisplayGiant,
                    height: AppValues.lineHeightTight,
                    letterSpacing: AppValues.letterSpacingTight,
                  ),
                ),
                TextSpan(
                  text: AppStrings.onboardingSlide2TitlePart2,
                  style: GoogleFonts.quicksand(
                    color: AppColors.brandIndigoLight,
                    fontWeight: FontWeight.w700,
                    fontSize: AppValues.fontDisplayGiant,
                    height: AppValues.lineHeightTight,
                    letterSpacing: AppValues.letterSpacingTight,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: AppValues.space4),
          Text(
            AppStrings.onboardingSlide2Description,
            textAlign: TextAlign.left,
            style: GoogleFonts.quicksand(
              fontSize: AppValues.fontBodyLg,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
              height: AppValues.lineHeightRelaxed,
              letterSpacing: AppValues.letterSpacingSubtle,
            ),
          ),
        ],
      ),
    );
  }
}

class Slide3Header extends StatelessWidget {
  const Slide3Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: AppValues.radiusXs),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: AppStrings.onboardingSlide3TitlePart1,
                  style: GoogleFonts.quicksand(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize: AppValues.fontDisplayGiant,
                    height: AppValues.lineHeightTight,
                    letterSpacing: AppValues.letterSpacingTight,
                  ),
                ),
                TextSpan(
                  text: AppStrings.onboardingSlide3TitlePart2,
                  style: GoogleFonts.quicksand(
                    color: AppColors.brandSky,
                    fontWeight: FontWeight.w700,
                    fontSize: AppValues.fontDisplayGiant,
                    height: AppValues.lineHeightTight,
                    letterSpacing: AppValues.letterSpacingTight,
                  ),
                ),
                TextSpan(
                  text: AppStrings.onboardingSlide3TitlePart3,
                  style: GoogleFonts.quicksand(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize: AppValues.fontDisplayGiant,
                    height: AppValues.lineHeightTight,
                    letterSpacing: AppValues.letterSpacingTight,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: AppValues.space4),
          Text(
            AppStrings.onboardingSlide3Description,
            textAlign: TextAlign.left,
            style: GoogleFonts.quicksand(
              fontSize: AppValues.fontBodyLg,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
              height: AppValues.lineHeightRelaxed,
              letterSpacing: AppValues.letterSpacingSubtle,
            ),
          ),
        ],
      ),
    );
  }
}
