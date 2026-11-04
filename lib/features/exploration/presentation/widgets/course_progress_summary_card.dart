import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_values.dart';
import '../../../../shared/ui_kit/ui_kit.dart';

/// Progress summary card with percentage, bar, and 3 stat chips
class CourseProgressSummaryCard extends StatelessWidget {
  final double progress;
  final int completed;
  final int total;
  final int stars;

  const CourseProgressSummaryCard({
    super.key,
    required this.progress,
    required this.completed,
    required this.total,
    required this.stars,
  });

  @override
  Widget build(BuildContext context) {
    return ClayCard(
      padding: const EdgeInsets.all(AppValues.space6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                AppStrings.overallProgressLabel,
                style: GoogleFonts.quicksand(
                  fontSize: AppValues.fontBodyMd,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              Text(
                '${(progress * 100).toInt()}%',
                style: GoogleFonts.quicksand(
                  fontSize: AppValues.fontBodyMd,
                  fontWeight: FontWeight.bold,
                  color: AppColors.brandPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppValues.space4),
          ClayProgressBar(progress: progress),
          const SizedBox(height: AppValues.space6),
          Row(
            children: [
              _buildMiniStat(
                label: AppStrings.lessonsCompletedStat,
                value: '$completed/$total',
                color: AppColors.brandMint,
              ),
              const SizedBox(width: AppValues.space4),
              _buildMiniStat(
                label: AppStrings.starsEarnedStat,
                value: '$stars',
                color: AppColors.brandSecondary,
              ),
              const SizedBox(width: AppValues.space4),
              _buildMiniStat(
                label: AppStrings.streakDaysStat,
                value: '3 ngày',
                color: AppColors.streakOrange,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiniStat({
    required String label,
    required String value,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppValues.space3),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppValues.radiusMd),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: GoogleFonts.quicksand(
                fontSize: AppValues.fontBodyMd,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: AppValues.space1),
            Text(
              label,
              style: GoogleFonts.quicksand(
                fontSize: AppValues.fontCourseMeta,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

