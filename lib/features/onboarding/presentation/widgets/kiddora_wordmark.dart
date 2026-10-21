import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_values.dart';

/// Colorful 3D Tactile Clay Wordmark for Kiddora with iconic 5-ray sunburst
/// precisely matched to DESIGN.md and kiddora_onboarding_1_welcome.png
/// (scaled to 56px font size to span ~80% of screen width).
class KiddoraWordmark extends StatelessWidget {
  const KiddoraWordmark({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            // 5-Ray Sunburst radiating above 'i' and 'd'
            Positioned(
              top: -22,
              left: 60,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Ray 1: Far left (-50°)
                  Transform.rotate(
                    angle: -0.65,
                    child: _buildRay(height: 13),
                  ),
                  const SizedBox(width: 3),
                  // Ray 2: Mid left (-25°)
                  Transform.rotate(
                    angle: -0.32,
                    child: _buildRay(height: 17),
                  ),
                  const SizedBox(width: 3),
                  // Ray 3: Center (0°)
                  _buildRay(height: 20),
                  const SizedBox(width: 3),
                  // Ray 4: Mid right (+25°)
                  Transform.rotate(
                    angle: 0.32,
                    child: _buildRay(height: 17),
                  ),
                  const SizedBox(width: 3),
                  // Ray 5: Far right (+50°)
                  Transform.rotate(
                    angle: 0.65,
                    child: _buildRay(height: 13),
                  ),
                ],
              ),
            ),

            // Colorful 3D Clay Letters — Quicksand Ultra Bold 56px
            Text.rich(
              TextSpan(
                style: GoogleFonts.quicksand(
                  fontSize: AppValues.fontWordmark,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1.0,
                  height: AppValues.lineHeightTight,
                ),
                children: const [
                  TextSpan(
                    text: AppStrings.wordmarkK,
                    style: TextStyle(color: AppColors.wordmarkBlue),
                  ),
                  TextSpan(
                    text: AppStrings.wordmarkI,
                    style: TextStyle(color: AppColors.wordmarkIndigo),
                  ),
                  TextSpan(
                    text: AppStrings.wordmarkD1,
                    style: TextStyle(color: AppColors.brandSecondary),
                  ),
                  TextSpan(
                    text: AppStrings.wordmarkD2,
                    style: TextStyle(color: AppColors.wordmarkOrange),
                  ),
                  TextSpan(
                    text: AppStrings.wordmarkO,
                    style: TextStyle(color: AppColors.wordmarkCyan),
                  ),
                  TextSpan(
                    text: AppStrings.wordmarkR,
                    style: TextStyle(color: AppColors.brandTertiary),
                  ),
                  TextSpan(
                    text: AppStrings.wordmarkA,
                    style: TextStyle(color: AppColors.wordmarkPurple),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppValues.radiusXs),

        // Tagline: Learn • Play • Achieve with colorful tactile dots
        Text.rich(
          TextSpan(
            style: GoogleFonts.quicksand(
              fontSize: AppValues.fontTitleMd,
              fontWeight: FontWeight.w800,
              letterSpacing: AppValues.letterSpacingWide,
            ),
            children: const [
              TextSpan(
                text: AppStrings.learn,
                style: TextStyle(color: AppColors.brandPrimary),
              ),
              TextSpan(
                text: AppStrings.wordmarkSeparator,
                style: TextStyle(
                    color: AppColors.wordmarkOrange,
                    fontWeight: FontWeight.w900),
              ),
              TextSpan(
                text: AppStrings.play,
                style: TextStyle(color: AppColors.brandPrimary),
              ),
              TextSpan(
                text: AppStrings.wordmarkSeparator,
                style: TextStyle(
                    color: AppColors.brandTertiary,
                    fontWeight: FontWeight.w900),
              ),
              TextSpan(
                text: AppStrings.achieve,
                style: TextStyle(color: AppColors.brandPrimary),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget _buildRay({required double height}) {
    return Container(
      width: 5.2,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.brandAmberLight,
        borderRadius: BorderRadius.circular(99),
        boxShadow: [
          BoxShadow(
            color: AppColors.brandSecondary.withValues(alpha: 0.5),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
    );
  }
}
