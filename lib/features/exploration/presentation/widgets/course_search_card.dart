import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_values.dart';
import '../../domain/models/course.dart';

class CourseSearchCard extends StatelessWidget {
  final Course course;
  final VoidCallback onTap;

  const CourseSearchCard({
    super.key,
    required this.course,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Semantics(
        button: true,
        label: course.title,
        child: GestureDetector(
          onTap: () {
            HapticFeedback.lightImpact();
            onTap();
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: AppValues.space4),
            padding: const EdgeInsets.all(AppValues.space4),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainer,
              borderRadius: BorderRadius.circular(AppValues.radiusCardLg),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.shadowCardAmbient,
                  offset: Offset(0, AppValues.offsetY2),
                  blurRadius: AppValues.space2,
                ),
              ],
            ),
            child: Row(
              children: [
                // 3D Thumbnail
                Container(
                  width: AppValues.sizeCourseThumbnail,
                  height: AppValues.sizeCourseThumbnail,
                  decoration: BoxDecoration(
                    color: AppColors.blobLavender,
                    borderRadius: BorderRadius.circular(AppValues.radiusCourseThumbnail),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppValues.radiusCourseThumbnail),
                    child: Image.asset(
                      course.thumbnailUrl,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.school_rounded,
                        color: AppColors.brandPrimary,
                        size: AppValues.iconSizeLg,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppValues.space5),

                // Course Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.quicksand(
                          fontSize: AppValues.fontTitleMd,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: AppValues.space1),
                      Text(
                        '${course.category.toUpperCase()} • ${course.totalLessons} ${AppStrings.lessonsCountSuffix} • ${AppStrings.agesPrefix} ${course.minAge}–${course.maxAge}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.quicksand(
                          fontSize: AppValues.fontBodySm,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppValues.space2),

                // Arrow Circle
                Container(
                  width: AppValues.sizeCircleButtonSm,
                  height: AppValues.sizeCircleButtonSm,
                  decoration: const BoxDecoration(
                    color: AppColors.surfaceInputPill,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.brandPrimary,
                    size: AppValues.iconSizeSm,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

