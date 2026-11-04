import 'package:flutter/material.dart';
import 'package:kiddora/core/constants/app_colors.dart';
import 'package:kiddora/core/constants/app_values.dart';

/// Tactile progress bar displaying 5 clay bean capsules (E1 to E5)
class LessonProgressDots extends StatelessWidget {
  final int totalStages;
  final int currentStageIndex;

  const LessonProgressDots({
    super.key,
    this.totalStages = 5,
    required this.currentStageIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(totalStages, (index) {
        final isActive = index == currentStageIndex;
        final isCompleted = index < currentStageIndex;

        return AnimatedContainer(
          duration: const Duration(milliseconds: AppValues.gameAnimDurationMs),
          curve: Curves.easeInOutCubic,
          margin: const EdgeInsets.symmetric(
            horizontal: AppValues.lessonDotSpacing / 2,
          ),
          width: isActive
              ? AppValues.lessonDotActiveWidth
              : AppValues.lessonDotInactiveWidth,
          height: AppValues.lessonDotHeight,
          decoration: BoxDecoration(
            color: isCompleted
                ? AppColors.brandMint
                : isActive
                    ? AppColors.brandPrimary
                    : AppColors.borderDefault,
            borderRadius: BorderRadius.circular(AppValues.lessonDotRadius),
          ),
        );
      }),
    );
  }
}
