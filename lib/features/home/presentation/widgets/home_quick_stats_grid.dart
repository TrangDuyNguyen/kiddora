import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_values.dart';
import '../../../../shared/ui_kit/ui_kit.dart';

class HomeQuickStatsGrid extends StatelessWidget {
  final VoidCallback onMyProgressTap;
  final VoidCallback? onCurrentCoursesTap;
  final VoidCallback? onUpcomingSessionTap;
  final VoidCallback? onMyBadgesTap;
  final int activeCoursesCount;
  final String? upcomingSessionSubtitle;
  final int earnedBadgesCount;

  const HomeQuickStatsGrid({
    super.key,
    required this.onMyProgressTap,
    this.onCurrentCoursesTap,
    this.onUpcomingSessionTap,
    this.onMyBadgesTap,
    this.activeCoursesCount = 3,
    this.upcomingSessionSubtitle,
    this.earnedBadgesCount = 5,
  });

  @override
  Widget build(BuildContext context) {
    final coursesSubtitle = activeCoursesCount == 3
        ? AppStrings.currentCoursesSubtitle
        : '$activeCoursesCount Active Courses';
    final badgesSubtitle = earnedBadgesCount == 5
        ? AppStrings.myBadgesSubtitle
        : '$earnedBadgesCount Badges Earned';
    final sessionSub = upcomingSessionSubtitle ?? AppStrings.upcomingSessionSubtitle;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                icon: Icons.bar_chart_rounded,
                iconBg: AppColors.brandMintContainer,
                iconColor: AppColors.brandMint,
                title: AppStrings.myProgress,
                subtitle: AppStrings.myProgressSubtitle,
                onTap: onMyProgressTap,
              ),
            ),
            const SizedBox(width: AppValues.space4),
            Expanded(
              child: _buildStatCard(
                icon: Icons.menu_book_rounded,
                iconBg: AppColors.brandSkyContainer,
                iconColor: AppColors.brandSky,
                title: AppStrings.currentCourses,
                subtitle: coursesSubtitle,
                onTap: onCurrentCoursesTap ?? () {},
              ),
            ),
          ],
        ),
        const SizedBox(height: AppValues.space4),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                icon: Icons.calendar_month_rounded,
                iconBg: AppColors.brandPinkContainer,
                iconColor: AppColors.brandTertiary,
                title: AppStrings.upcomingSession,
                subtitle: sessionSub,
                onTap: onUpcomingSessionTap ?? () {},
              ),
            ),
            const SizedBox(width: AppValues.space4),
            Expanded(
              child: _buildStatCard(
                icon: Icons.emoji_events_rounded,
                iconBg: AppColors.brandAmberContainer,
                iconColor: AppColors.brandSecondary,
                title: AppStrings.myBadges,
                subtitle: badgesSubtitle,
                onTap: onMyBadgesTap ?? () {},
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ClayCard(
      onTap: onTap,
      padding: const EdgeInsets.all(AppValues.space5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: AppValues.sizeCircleButtonSm,
                height: AppValues.sizeCircleButtonSm,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(AppValues.radiusMd),
                ),
                alignment: Alignment.center,
                child: Icon(
                  icon,
                  size: AppValues.iconSizeMd,
                  color: iconColor,
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: AppValues.iconSizeCompact,
                color: AppColors.textMuted,
              ),
            ],
          ),
          const SizedBox(height: AppValues.space4),
          Text(
            title,
            style: GoogleFonts.quicksand(
              fontSize: AppValues.fontBodyMd,
              fontWeight: FontWeight.w700,
              color: AppColors.textDarkIndigo,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppValues.radiusXs),
          Text(
            subtitle,
            style: GoogleFonts.quicksand(
              fontSize: AppValues.fontCaptionSm,
              fontWeight: FontWeight.w500,
              color: AppColors.textSlate,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
