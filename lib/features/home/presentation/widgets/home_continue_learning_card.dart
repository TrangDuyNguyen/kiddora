import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_values.dart';
import '../../../../shared/ui_kit/indicators/clay_progress_bar.dart';
import '../../../../shared/ui_kit/surfaces/clay_card.dart';

class HomeContinueLearningCard extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback? onSeeAllTap;
  final String subjectName;
  final String courseTitle;
  final String thumbnailAsset;
  final double progress;
  final int completedLessons;
  final int totalLessons;

  const HomeContinueLearningCard({
    super.key,
    required this.onTap,
    this.onSeeAllTap,
    this.subjectName = 'Science',
    this.courseTitle = 'Amazing Animals',
    this.thumbnailAsset = 'assets/images/course_dino.png',
    this.progress = 0.6,
    this.completedLessons = 3,
    this.totalLessons = 5,
  });

  @override
  Widget build(BuildContext context) {
    final progressText = '$completedLessons of $totalLessons lessons';

    return Column(
      children: [
        // Section Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.continueLearning,
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

        // Course Card
        ClayCard(
          onTap: onTap,
          padding: const EdgeInsets.all(AppValues.space4),
          child: Row(
            children: [
              // Dino Image Thumbnail
              ClipRRect(
                borderRadius: BorderRadius.circular(
                  AppValues.radiusCourseThumbnail,
                ),
                child: Image.asset(
                  thumbnailAsset,
                  width: AppValues.sizeCourseThumbnail,
                  height: AppValues.sizeCourseThumbnail,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Image.asset(
                    'assets/images/course_dino.png',
                    width: AppValues.sizeCourseThumbnail,
                    height: AppValues.sizeCourseThumbnail,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: AppValues.space6),

              // Info: Subject, Title & Progress
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subjectName,
                      style: GoogleFonts.quicksand(
                        fontSize: AppValues.fontCaptionSm,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textMuted,
                      ),
                    ),
                    Text(
                      courseTitle,
                      style: GoogleFonts.quicksand(
                        fontSize: AppValues.fontBodyMd,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDarkIndigo,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppValues.radiusSm),
                    // Clay Progress Bar
                    ClayProgressBar(
                      progress: progress,
                      height: AppValues.space2,
                      progressColor: AppColors.brandPrimary,
                      trackColor: AppColors.ringTrackLavender,
                    ),
                    const SizedBox(height: AppValues.radiusXs),
                    Text(
                      progressText,
                      style: GoogleFonts.quicksand(
                        fontSize: AppValues.fontCaptionXs,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSlate,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppValues.space5),

              // Action Arrow Button
              Container(
                width: AppValues.sizeCircleButtonSm,
                height: AppValues.sizeCircleButtonSm,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.brandPrimary,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.clayShadow,
                      offset: Offset(0, 3),
                      blurRadius: AppValues.radiusSm,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: AppValues.iconSizeCompact,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
