import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_values.dart';

class CourseBadgeBanner extends StatelessWidget {
  const CourseBadgeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppValues.space6),
      decoration: BoxDecoration(
        color: AppColors.badgeBannerBg,
        borderRadius: BorderRadius.circular(AppValues.radiusCardLg),
        border: Border.all(
          color: AppColors.badgeBannerBorder,
          width: AppValues.borderWidthDefault,
        ),
      ),
      child: Row(
        children: [
          // 3D Trophy / Crown icon
          Image.asset(
            AppAssets.iconCrown3d,
            width: AppValues.sizeCircleButtonXl,
            height: AppValues.sizeCircleButtonXl,
            errorBuilder: (_, __, ___) => const Icon(
              Icons.emoji_events_rounded,
              color: AppColors.stateWarningAmber,
              size: AppValues.sizeCircleButtonXl,
            ),
          ),
          const SizedBox(width: AppValues.space5),

          // Message
          Expanded(
            child: Text(
              AppStrings.completeLessonsBadgeBanner,
              style: GoogleFonts.quicksand(
                fontSize: AppValues.fontBodySm,
                fontWeight: FontWeight.w700,
                color: AppColors.textDarkIndigo,
                height: AppValues.lineHeightCompact,
              ),
            ),
          ),
          const SizedBox(width: AppValues.space2),

          // Badge companion thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(AppValues.radiusMd),
            child: Image.asset(
              AppAssets.avatarDino,
              width: AppValues.sizeCircleButtonLg,
              height: AppValues.sizeCircleButtonLg,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}

