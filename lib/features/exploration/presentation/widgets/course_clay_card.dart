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
              borderRadius: BorderRadius.circular(AppValues.radiusCardLg),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.shadowCardAmbient,
                  offset: Offset(0, AppValues.offsetY3),
                  blurRadius: AppValues.space4,
                ),
              ],
            ),
            padding: const EdgeInsets.all(AppValues.space5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                // Top: Image thumbnail + optional favorite heart
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.blobLavender,
                          borderRadius: BorderRadius.circular(AppValues.radiusCourseThumbnail),
                        ),
                        alignment: Alignment.center,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(AppValues.radiusCourseThumbnail),
                          child: Image.asset(
                            course.thumbnailUrl,
                            fit: BoxFit.contain,
                            errorBuilder: (_, __, ___) => const Icon(
                              Icons.school_rounded,
                              size: AppValues.space11,
                              color: AppColors.brandPrimary,
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
                const SizedBox(height: AppValues.space4),

                // Category & Age pill
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppValues.space2,
                        vertical: AppValues.space1 / 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.blobPeriwinkle,
                        borderRadius: BorderRadius.circular(AppValues.radiusSm),
                      ),
                      child: Text(
                        course.category.toUpperCase(),
                        style: GoogleFonts.quicksand(
                          fontSize: AppValues.fontCaptionXs,
                          fontWeight: FontWeight.w700,
                          color: AppColors.brandPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppValues.space2),
                    Expanded(
                      child: Text(
                        '${AppStrings.agesPrefix} ${course.minAge}–${course.maxAge}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.quicksand(
                          fontSize: AppValues.fontCaptionXs,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppValues.space2),

                // Title
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
                const SizedBox(height: AppValues.space2),

                // Total lessons & Action Arrow
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${course.totalLessons} ${AppStrings.lessonsCountSuffix}',
                      style: GoogleFonts.quicksand(
                        fontSize: AppValues.fontBodySm,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Container(
                      width: AppValues.sizeCircleButtonSm,
                      height: AppValues.sizeCircleButtonSm,
                      decoration: const BoxDecoration(
                        color: AppColors.brandPrimary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.chevron_right_rounded,
                        color: AppColors.textInverse,
                        size: AppValues.iconSizeSm,
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
}
