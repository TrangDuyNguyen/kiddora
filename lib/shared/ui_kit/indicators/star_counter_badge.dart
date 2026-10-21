import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_values.dart';
import '../painters/clay_inset_painter.dart';

/// Tactile 3D Clay Star & Streak Counter Badge — DESIGN.md §2.5 Level 1
///
/// Small pill badge with **true inset shadows** (specular rim + bevel shade)
/// + outer extrusion shelf + pillow glow for authentic inflated-clay look.
class StarCounterBadge extends StatelessWidget {
  final int count;
  final bool isStreak;

  const StarCounterBadge({
    super.key,
    required this.count,
    this.isStreak = false,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor =
        isStreak ? AppColors.streakOrange : AppColors.brandSecondary;
    final extrusionColor =
        isStreak ? AppColors.streakExtrusion : AppColors.starExtrusion;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppValues.space5,
        vertical: AppValues.space2,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppValues.radiusPill),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isStreak
              ? const [
                  AppColors.streakGradStart,
                  AppColors.streakGradMid,
                  AppColors.streakGradEnd,
                ]
              : const [
                  AppColors.starGradStart,
                  AppColors.starGradMid,
                  AppColors.starGradEnd,
                ],
        ),
        border: Border.all(
          color: Colors.white,
          width: AppValues.borderWidthHairline,
        ),
        boxShadow: [
          // Bottom extrusion shelf
          BoxShadow(
            color: extrusionColor.withValues(alpha: 0.5),
            offset: const Offset(0, 2.0),
            blurRadius: 0,
          ),
          // Outer colored pillow glow
          BoxShadow(
            color: iconColor.withValues(alpha: 0.22),
            offset: const Offset(0, 4),
            blurRadius: 8,
            spreadRadius: -1,
          ),
        ],
      ),
      child: CustomPaint(
        painter: const ClayInsetPainter(
          borderRadius: AppValues.radiusPill,
          // Level 1 Clay Rest — softer insets for small badge
          highlightColor: AppColors.clayHighlightBadge,
          shadeColor: AppColors.clayShadeBadge,
          highlightOffset: Offset(2, 2),
          shadeOffset: Offset(-2, -2),
          highlightBlur: 3.0,
          shadeBlur: 3.0,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isStreak
                  ? Icons.local_fire_department_rounded
                  : Icons.star_rounded,
              color: iconColor,
              size: AppValues.iconSizeMd,
            ),
            const SizedBox(width: AppValues.space1),
            Text(
              '$count',
              style: GoogleFonts.quicksand(
                color: iconColor,
                fontWeight: FontWeight.w900,
                fontSize: AppValues.fontBodyMd,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
