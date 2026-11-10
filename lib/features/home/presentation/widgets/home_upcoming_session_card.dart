import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_values.dart';
import '../../../../shared/ui_kit/ui_kit.dart';

class HomeUpcomingSessionCard extends StatelessWidget {
  final VoidCallback onJoinTap;
  final VoidCallback? onSeeAllTap;
  final VoidCallback? onCardTap;
  final String title;
  final String coachName;
  final String coachAvatar;
  final String scheduledTime;

  const HomeUpcomingSessionCard({
    super.key,
    required this.onJoinTap,
    this.onSeeAllTap,
    this.onCardTap,
    this.title = AppStrings.mathFunWithNumbers,
    this.coachName = AppStrings.coachSarah,
    this.coachAvatar = 'assets/images/avatar_coach_sarah.png',
    this.scheduledTime = AppStrings.sessionTodayTime,
  });

  Widget _buildSessionDetails() => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.quicksand(
                fontSize: AppValues.fontLabelMd,
                fontWeight: FontWeight.w700,
                color: AppColors.textDarkIndigo,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: AppValues.borderWidthThin),
            Text(
              coachName,
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
                  scheduledTime,
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
              onTap: () {
                HapticFeedback.lightImpact();
                onSeeAllTap?.call();
              },
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
        ClayCard(
          onTap: onCardTap ?? onJoinTap,
          padding: const EdgeInsets.all(AppValues.space4),
          child: Row(
            children: [
              ClipOval(
                child: Image.asset(
                  coachAvatar,
                  width: AppValues.sizeAvatarMd,
                  height: AppValues.sizeAvatarMd,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Image.asset(
                    'assets/images/avatar_coach_sarah.png',
                    width: AppValues.sizeAvatarMd,
                    height: AppValues.sizeAvatarMd,
                    fit: BoxFit.cover,
                  ),
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
