import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_values.dart';

/// Tactile Claymorphic Progress Bar with pill track and smooth fill
class ClayProgressBar extends StatelessWidget {
  final double progress; // 0.0 to 1.0
  final double height;
  final Color progressColor;
  final Color trackColor;

  const ClayProgressBar({
    super.key,
    required this.progress,
    this.height = AppValues.space6,
    this.progressColor = AppColors.brandPrimary,
    this.trackColor = AppColors.borderDefault,
  });

  @override
  Widget build(BuildContext context) {
    final clamped = progress.clamp(0.0, 1.0);

    return LayoutBuilder(
      builder: (context, constraints) {
        final totalWidth = constraints.maxWidth;
        final fillWidth = totalWidth * clamped;

        return Container(
          height: height,
          width: totalWidth,
          decoration: BoxDecoration(
            color: trackColor,
            borderRadius: BorderRadius.circular(AppValues.radiusPill),
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadowCardAmbient,
                offset: Offset(0, 1),
                blurRadius: 2,
              ),
            ],
          ),
          child: Stack(
            children: [
              AnimatedContainer(
                duration: const Duration(
                  milliseconds: AppValues.gameAnimDurationMs,
                ),
                curve: Curves.easeInOutCubic,
                width: fillWidth,
                height: height,
                decoration: BoxDecoration(
                  color: progressColor,
                  borderRadius: BorderRadius.circular(AppValues.radiusPill),
                  boxShadow: [
                    BoxShadow(
                      color: progressColor.withValues(alpha: 0.35),
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

