import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_values.dart';

class HomeQuickStatsGrid extends StatelessWidget {
  final VoidCallback onMyProgressTap;

  const HomeQuickStatsGrid({
    super.key,
    required this.onMyProgressTap,
  });

  @override
  Widget build(BuildContext context) {
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
                subtitle: AppStrings.currentCoursesSubtitle,
                onTap: () {},
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
                subtitle: AppStrings.upcomingSessionSubtitle,
                onTap: () {},
              ),
            ),
            const SizedBox(width: AppValues.space4),
            Expanded(
              child: _buildStatCard(
                icon: Icons.emoji_events_rounded,
                iconBg: AppColors.brandAmberContainer,
                iconColor: AppColors.brandSecondary,
                title: AppStrings.myBadges,
                subtitle: AppStrings.myBadgesSubtitle,
                onTap: () {},
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
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.all(AppValues.space5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppValues.radiusXl),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowIndigoSubtle,
              offset: const Offset(0, 3),
              blurRadius: AppValues.space5,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: AppValues.sizeCircleButtonSm,
              height: AppValues.sizeCircleButtonSm,
              decoration: BoxDecoration(
                color: iconBg,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(
                icon,
                size: AppValues.iconSizeLg,
                color: iconColor,
              ),
            ),
            const SizedBox(height: AppValues.space5),
            Text(
              title,
              style: GoogleFonts.quicksand(
                fontSize: AppValues.fontLabelMd,
                fontWeight: FontWeight.w700,
                color: AppColors.textDarkIndigo,
              ),
            ),
            const SizedBox(height: AppValues.borderWidthThick),
            Row(
              children: [
                Expanded(
                  child: Text(
                    subtitle,
                    style: GoogleFonts.quicksand(
                      fontSize: AppValues.fontCaptionXs,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSlate,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  size: AppValues.iconSizeSm,
                  color: AppColors.textMuted,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
