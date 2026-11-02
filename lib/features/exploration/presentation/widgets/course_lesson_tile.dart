import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_values.dart';
import '../../domain/models/lesson.dart';

class CourseLessonTile extends StatelessWidget {
  final Lesson lesson;
  final VoidCallback onTap;
  final VoidCallback onLockedTap;

  const CourseLessonTile({
    super.key,
    required this.lesson,
    required this.onTap,
    required this.onLockedTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppValues.space4),
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
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppValues.radiusCardLg),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppValues.radiusCardLg),
          onTap: () {
            HapticFeedback.lightImpact();
            if (lesson.isUnlocked) {
              onTap();
            } else {
              onLockedTap();
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(AppValues.space4),
            child: Row(
              children: [
                // Order Index Pill
                Container(
                  width: AppValues.minTouchTarget,
                  height: AppValues.minTouchTarget,
                  decoration: BoxDecoration(
                    color: lesson.isCompleted
                        ? AppColors.progressBarMintBg
                        : (lesson.isUnlocked
                            ? AppColors.blobPeriwinkle
                            : AppColors.buttonDisabledBg),
                    borderRadius: BorderRadius.circular(AppValues.radiusLg),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    lesson.orderIndex < 10
                        ? '0${lesson.orderIndex}'
                        : '${lesson.orderIndex}',
                    style: GoogleFonts.quicksand(
                      fontSize: AppValues.fontTitleMd,
                      fontWeight: FontWeight.w700,
                      color: lesson.isCompleted
                          ? AppColors.stateSuccessGreen
                          : (lesson.isUnlocked
                              ? AppColors.brandPrimary
                              : AppColors.buttonDisabledText),
                    ),
                  ),
                ),
                const SizedBox(width: AppValues.space5),

                // Title & Duration
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lesson.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.quicksand(
                          fontSize: AppValues.fontTitleMd,
                          fontWeight: FontWeight.w700,
                          color: lesson.isUnlocked
                              ? AppColors.textPrimary
                              : AppColors.textMuted,
                        ),
                      ),
                      const SizedBox(height: AppValues.space1),
                      Text(
                        '${lesson.durationMins} ${AppStrings.minSuffix}',
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

                // Status Indicator
                _buildStatusIcon(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIcon() {
    if (lesson.isCompleted) {
      return Container(
        width: AppValues.sizeCircleButtonSm,
        height: AppValues.sizeCircleButtonSm,
        decoration: const BoxDecoration(
          color: AppColors.stateSuccessGreen,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.check_rounded,
          color: AppColors.textInverse,
          size: AppValues.iconSizeSm,
        ),
      );
    }

    if (lesson.isUnlocked) {
      return Container(
        width: AppValues.sizeCircleButtonSm,
        height: AppValues.sizeCircleButtonSm,
        decoration: const BoxDecoration(
          color: AppColors.brandPrimary,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.play_arrow_rounded,
          color: AppColors.textInverse,
          size: AppValues.iconSizeSm,
        ),
      );
    }

    return Container(
      width: AppValues.sizeCircleButtonSm,
      height: AppValues.sizeCircleButtonSm,
      decoration: const BoxDecoration(
        color: AppColors.buttonDisabledBg,
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.lock_rounded,
        color: AppColors.buttonDisabledText,
        size: AppValues.iconSizeCompact,
      ),
    );
  }
}

