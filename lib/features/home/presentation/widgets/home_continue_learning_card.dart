import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_values.dart';

class HomeContinueLearningCard extends StatelessWidget {
  final VoidCallback onTap;

  const HomeContinueLearningCard({
    super.key,
    required this.onTap,
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
        GestureDetector(
          onTap: () {
            HapticFeedback.lightImpact();
            onTap();
          },
          child: Container(
            padding: const EdgeInsets.all(AppValues.space4),
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
                // Dino Image Thumbnail
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                    AppValues.radiusCourseThumbnail,
                  ),
                  child: Image.asset(
                    'assets/images/course_dino.png',
                    width: AppValues.sizeCourseThumbnail,
                    height: AppValues.sizeCourseThumbnail,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: AppValues.space6),

                // Info: Subject, Title & Progress
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.courseScienceTag,
                        style: GoogleFonts.quicksand(
                          fontSize: AppValues.fontCaptionSm,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textMuted,
                        ),
                      ),
                      Text(
                        AppStrings.courseAmazingAnimals,
                        style: GoogleFonts.quicksand(
                          fontSize: AppValues.fontBodyMd,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textDarkIndigo,
                        ),
                      ),
                      const SizedBox(height: AppValues.radiusSm),
                      // Progress Bar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(AppValues.radiusXs),
                        child: const LinearProgressIndicator(
                          value: 0.6,
                          minHeight: AppValues.space1,
                          backgroundColor: AppColors.ringTrackLavender,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.brandPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppValues.radiusXs),
                      Text(
                        AppStrings.courseLessonsProgress,
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
        ),
      ],
    );
  }
}
