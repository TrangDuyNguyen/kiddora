import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_values.dart';

class HomeUpcomingSessionCard extends StatelessWidget {
  final VoidCallback onJoinTap;

  const HomeUpcomingSessionCard({
    super.key,
    required this.onJoinTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Section Header
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

        // Session Card
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppValues.space4,
            vertical: AppValues.space4,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppValues.radiusXl),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowIndigoSubtle,
                offset: const Offset(0, 4),
                blurRadius: AppValues.radiusTaskTile,
              ),
            ],
          ),
          child: Row(
            children: [
              // Coach Avatar
              ClipOval(
                child: Image.asset(
                  'assets/images/avatar_coach_sarah.png',
                  width: AppValues.sizeAvatarMd,
                  height: AppValues.sizeAvatarMd,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: AppValues.radiusTaskTile),

              // Title, Coach Name & Time
              Expanded(
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
              ),
              const SizedBox(width: AppValues.space4),

              // Join Pill Button
              GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact();
                  onJoinTap();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppValues.space8,
                    vertical: AppValues.space4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.brandPrimary,
                    borderRadius: BorderRadius.circular(AppValues.radiusCardLg),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.brandPrimary.withValues(alpha: 0.35),
                        offset: const Offset(0, 3),
                        blurRadius: AppValues.radiusSm,
                      ),
                    ],
                  ),
                  child: Text(
                    AppStrings.join,
                    style: GoogleFonts.quicksand(
                      fontSize: AppValues.fontLabelMd,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
