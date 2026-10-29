import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_values.dart';
import '../../../../shared/ui_kit/ui_kit.dart';

class HomeUpcomingSessionCard extends StatelessWidget {
  final VoidCallback onJoinTap;

  const HomeUpcomingSessionCard({
    super.key,
    required this.onJoinTap,
  });

  Widget _buildSessionDetails() => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.mathFunWithNumbers,
              style: GoogleFonts.quicksand(
                fontSize: AppValues.fontLabelMd,
                fontWeight: FontWeight.w700,
                color: AppColors.textDarkIndigo,
              ),
            ),
            const SizedBox(height: AppValues.borderWidthThin),
            Text(
              AppStrings.coachSarah,
              style: GoogleFonts.quicksand(
                fontSize: AppValues.fontCaptionSm,
                fontWeight: FontWeight.w600,
                color: AppColors.textSlate,
              ),
            ),
            const SizedBox(height: AppValues.borderWidthThick),
            Row(
              children: [
                const Icon(
                  Icons.calendar_today_rounded,
                  size: AppValues.iconSizeXs,
                  color: AppColors.textMuted,
                ),
                const SizedBox(width: AppValues.radiusXs),
                Text(
                  AppStrings.sessionTodayTime,
                  style: GoogleFonts.quicksand(
                    fontSize: AppValues.fontCaptionXs,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSlate,
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.upcomingSession,
              style: GoogleFonts.quicksand(
                fontSize: AppValues.fontTitleLg,
                fontWeight: FontWeight.w800,
                color: AppColors.textDarkIndigo,
              ),
            ),
            GestureDetector(
              onTap: HapticFeedback.lightImpact,
              child: Text(
                AppStrings.seeAll,
                style: GoogleFonts.quicksand(
                  fontSize: AppValues.fontLabelMd,
                  fontWeight: FontWeight.w700,
                  color: AppColors.brandPrimary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppValues.space4),
        Container(
          padding: const EdgeInsets.all(AppValues.space4),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainer,
            borderRadius: BorderRadius.circular(AppValues.radiusXl),
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadowIndigoSubtle,
                offset: Offset(0, AppValues.radiusXs),
                blurRadius: AppValues.radiusTaskTile,
              ),
            ],
          ),
          child: Row(
            children: [
              ClipOval(
                child: Image.asset(
                  AppAssets.avatarCoachSarah,
                  width: AppValues.sizeAvatarMd,
                  height: AppValues.sizeAvatarMd,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: AppValues.radiusTaskTile),
              _buildSessionDetails(),
              const SizedBox(width: AppValues.space4),
              ClayButton.compact(
                label: AppStrings.join,
                onPressed: onJoinTap,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
