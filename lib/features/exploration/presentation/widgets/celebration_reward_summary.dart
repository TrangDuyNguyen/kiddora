import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_values.dart';

/// Tactile box displaying stars, streak bonus, and badge honors
class CelebrationRewardSummary extends StatelessWidget {
  const CelebrationRewardSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppValues.space5),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(AppValues.radiusCardLg),
        border: Border.all(color: AppColors.borderDefault),
      ),
      child: Column(
        children: [
          _buildRewardRow(
            imagePath: 'assets/images/icon_star_coin_3d.png',
            title: AppStrings.starsRewardTotal,
            color: AppColors.brandSecondary,
          ),
          const Divider(height: AppValues.space6),
          _buildRewardRow(
            icon: Icons.local_fire_department_rounded,
            title: AppStrings.streakBonusText,
            color: AppColors.streakOrange,
          ),
          const Divider(height: AppValues.space6),
          _buildRewardRow(
            imagePath: 'assets/images/icon_crown_3d.png',
            title: AppStrings.badgeEarnedTitle,
            color: AppColors.brandPrimary,
          ),
        ],
      ),
    );
  }

  Widget _buildRewardRow({
    String? imagePath,
    IconData? icon,
    required String title,
    required Color color,
  }) {
    return Row(
      children: [
        if (imagePath != null)
          Image.asset(
            imagePath,
            width: AppValues.space8,
            height: AppValues.space8,
            fit: BoxFit.contain,
          )
        else if (icon != null)
          Icon(icon, color: color, size: AppValues.space8),
        const SizedBox(width: AppValues.space4),
        Expanded(
          child: Text(
            title,
            style: GoogleFonts.quicksand(
              fontSize: AppValues.fontBodySm,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}

