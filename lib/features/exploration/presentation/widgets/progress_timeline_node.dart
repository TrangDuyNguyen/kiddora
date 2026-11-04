import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_values.dart';
import '../../../../shared/ui_kit/ui_kit.dart';
import '../../domain/models/lesson.dart';

/// Single interactive node along the Course Progress Timeline
class ProgressTimelineNode extends StatelessWidget {
  final Lesson lesson;
  final bool isCurrent;
  final bool isFirst;
  final bool isLast;
  final VoidCallback onTap;

  const ProgressTimelineNode({
    super.key,
    required this.lesson,
    this.isCurrent = false,
    this.isFirst = false,
    this.isLast = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDone = lesson.isCompleted;
    final isLocked = !lesson.isUnlocked;

    final nodeColor = isDone
        ? AppColors.brandMint
        : isCurrent
            ? AppColors.brandPrimary
            : AppColors.borderDefault;

    final nodeIcon = isDone
        ? Icons.check_rounded
        : isCurrent
            ? Icons.play_arrow_rounded
            : Icons.lock_rounded;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Left timeline column: upper line, circle node, lower line
          SizedBox(
            width: AppValues.trackerStepNodeSize,
            child: Column(
              children: [
                if (!isFirst)
                  Expanded(
                    child: Container(
                      width: AppValues.trackerTimelineLineWidth,
                      color: isDone ? AppColors.brandMint : AppColors.borderDefault,
                    ),
                  )
                else
                  const Spacer(),
                Container(
                  width: AppValues.trackerStepNodeSize,
                  height: AppValues.trackerStepNodeSize,
                  decoration: BoxDecoration(
                    color: nodeColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: nodeColor.withValues(alpha: 0.35),
                        offset: const Offset(0, 3),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Icon(
                    nodeIcon,
                    color: AppColors.textInverse,
                    size: AppValues.space7,
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: AppValues.trackerTimelineLineWidth,
                      color: isDone ? AppColors.brandMint : AppColors.borderDefault,
                    ),
                  )
                else
                  const Spacer(),
              ],
            ),
          ),
          const SizedBox(width: AppValues.space5),
          // Right content card
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: AppValues.space5),
              child: ClayCard(
                onTap: onTap,
                padding: const EdgeInsets.all(AppValues.space5),
                backgroundColor: AppColors.surfaceContainer,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Bài ${lesson.orderIndex}',
                          style: GoogleFonts.quicksand(
                            fontSize: AppValues.fontCourseMeta,
                            fontWeight: FontWeight.bold,
                            color: isCurrent
                                ? AppColors.brandPrimary
                                : AppColors.textSecondary,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppValues.space3,
                            vertical: AppValues.space1,
                          ),
                          decoration: BoxDecoration(
                            color: nodeColor.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(
                              AppValues.radiusPill,
                            ),
                          ),
                          child: Text(
                            isDone
                                ? AppStrings.statusCompleted
                                : isCurrent
                                    ? AppStrings.statusInProgress
                                    : AppStrings.statusLocked,
                            style: GoogleFonts.quicksand(
                              fontSize: AppValues.fontCourseMeta,
                              fontWeight: FontWeight.bold,
                              color: nodeColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppValues.space2),
                    Text(
                      lesson.title,
                      style: GoogleFonts.quicksand(
                        fontSize: AppValues.fontCourseTitle,
                        fontWeight: FontWeight.bold,
                        color: isLocked
                            ? AppColors.textSecondary
                            : AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppValues.space3),
                    Row(
                      children: [
                        const Icon(
                          Icons.schedule_rounded,
                          size: AppValues.iconCourseMeta,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: AppValues.space2),
                        Text(
                          '${lesson.durationMins} ${AppStrings.minSuffix}',
                          style: GoogleFonts.quicksand(
                            fontSize: AppValues.fontCourseMeta,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    if (isCurrent) ...[
                      const SizedBox(height: AppValues.space4),
                      SizedBox(
                        width: double.infinity,
                        child: ClayButton(
                          label: AppStrings.btnContinueCurrentLesson,
                          onPressed: onTap,
                          height: AppValues.minTouchTarget,
                          icon: const Icon(
                            Icons.play_arrow_rounded,
                            color: AppColors.textInverse,
                            size: AppValues.space6,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
