import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_values.dart';
import '../../domain/models/course.dart';

class CourseClayCard extends StatelessWidget {
  final Course course;
  final VoidCallback onTap;
  final VoidCallback? onFavoriteTap;
  final bool showFavoriteButton;

  const CourseClayCard({
    super.key,
    required this.course,
    required this.onTap,
    this.onFavoriteTap,
    this.showFavoriteButton = false,
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
            decoration: BoxDecoration(
              color: AppColors.surfaceContainer,
              borderRadius: BorderRadius.circular(AppValues.courseCardRadius),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.shadowCardAmbient,
                  offset: Offset(0, AppValues.offsetY3),
                  blurRadius: AppValues.space4,
                ),
              ],
            ),
            padding: const EdgeInsets.all(AppValues.courseCardPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                // Top: Image thumbnail expands flexibly to fill top space, 0 overflow on 1.5x text scale
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.blobLavender,
                      borderRadius: BorderRadius.circular(AppValues.courseCardThumbnailRadius),
                    ),
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(AppValues.courseCardThumbnailRadius),
                            child: Image.asset(
                              course.thumbnailUrl,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => const Center(
                                child: Icon(
                                  Icons.school_rounded,
                                  size: AppValues.space11,
                                  color: AppColors.brandPrimary,
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (showFavoriteButton)
                          Positioned(
                            top: AppValues.space2,
                            right: AppValues.space2,
                            child: GestureDetector(
                              onTap: () {
                                HapticFeedback.mediumImpact();
                                onFavoriteTap?.call();
                              },
                              child: Container(
                                width: AppValues.sizeCircleButtonSm,
                                height: AppValues.sizeCircleButtonSm,
                                decoration: const BoxDecoration(
                                  color: AppColors.favoriteHeartBg,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.shadowCardAmbient,
                                      blurRadius: AppValues.space2,
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  course.isFavorite
                                      ? Icons.favorite_rounded
                                      : Icons.favorite_border_rounded,
                                  size: AppValues.iconSizeSm,
                                  color: course.isFavorite
                                      ? AppColors.favoriteHeartRed
                                      : AppColors.textMuted,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppValues.space2),

                // Title (Bold 14dp)
                Text(
                  course.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.quicksand(
                    fontSize: AppValues.fontCourseTitle,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppValues.borderWidthThin),

                // Category subtitle (e.g. Science, Mathematics, Arts & Creativity)
                Text(
                  _formatCategory(course.category),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.quicksand(
                    fontSize: AppValues.fontCourseCategory,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppValues.space2),

                // Metadata row & Action Button (exact 32x32dp circle)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_month_rounded,
                                size: AppValues.iconCourseMeta,
                                color: AppColors.textSecondary,
                              ),
                              const SizedBox(width: AppValues.borderWidthThick),
                              Text(
                                '${course.totalLessons} ${AppStrings.lessonsCountSuffix}',
                                style: GoogleFonts.quicksand(
                                  fontSize: AppValues.fontCourseMeta,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppValues.borderWidthThick),
                          Row(
                            children: [
                              const Icon(
                                Icons.person_rounded,
                                size: AppValues.iconCourseMeta,
                                color: AppColors.textSecondary,
                              ),
                              const SizedBox(width: AppValues.borderWidthThick),
                              Text(
                                '${AppStrings.agesPrefix} ${course.minAge}–${course.maxAge}',
                                style: GoogleFonts.quicksand(
                                  fontSize: AppValues.fontCourseMeta,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: AppValues.courseActionButtonSize,
                      height: AppValues.courseActionButtonSize,
                      decoration: const BoxDecoration(
                        color: AppColors.courseActionBtnBg,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.clayFilterActiveShadow,
                            offset: Offset(0, AppValues.offsetY2),
                            blurRadius: AppValues.space3,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.chevron_right_rounded,
                        color: AppColors.textInverse,
                        size: AppValues.courseActionIconSize,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatCategory(String cat) {
    final lower = cat.toLowerCase();
    if (lower == 'math' || lower.startsWith('mathem')) return 'Mathematics';
    if (lower == 'arts' || lower.contains('creativ')) return 'Arts & Creativity';
    if (lower == 'science') return 'Science';
    if (lower == 'language') return 'Language';
    return cat.isNotEmpty ? cat[0].toUpperCase() + cat.substring(1) : cat;
  }
}
