import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_values.dart';
import '../painters/clay_inset_painter.dart';

/// Tactile 3D Clay Star, Streak & Profile Stat Pill Badge — DESIGN.md §2.5 Level 1
class StarCounterBadge extends StatelessWidget {
  final int count;
  final bool isStreak;
  final String? customLabel;
  final Widget? leadingIcon;
  final bool isPrimary;

  const StarCounterBadge({
    super.key,
    required this.count,
    this.isStreak = false,
  })  : customLabel = null,
        leadingIcon = null,
        isPrimary = false;

  /// Custom pill badge for Profile stats (`Level 5`, `1200 Points`)
  const StarCounterBadge.custom({
    super.key,
    required String label,
    required Widget icon,
    this.isPrimary = false,
  })  : count = 0,
        isStreak = false,
        customLabel = label,
        leadingIcon = icon;

  @override
  Widget build(BuildContext context) {
    final textColor = isPrimary
        ? AppColors.textInverse
        : (customLabel != null
            ? AppColors.textDarkIndigo
            : (isStreak ? AppColors.streakOrange : AppColors.brandSecondary));

    final gradientColors = isPrimary
        ? const [
            AppColors.buttonGradientStart,
            AppColors.brandIndigoLight,
            AppColors.brandPrimary,
          ]
        : (customLabel != null
            ? const [
                AppColors.surfaceContainer,
                AppColors.clayCardGradMid,
                AppColors.clayCardGradBottom,
              ]
            : (isStreak
                ? const [
                    AppColors.streakGradStart,
                    AppColors.streakGradMid,
                    AppColors.streakGradEnd,
                  ]
                : const [
                    AppColors.starGradStart,
                    AppColors.starGradMid,
                    AppColors.starGradEnd,
                  ]));

    final glowColor = isPrimary
        ? AppColors.brandPrimary
        : (isStreak ? AppColors.streakOrange : AppColors.brandSecondary);

    final iconWidget = leadingIcon ??
        Icon(
          isStreak ? Icons.local_fire_department_rounded : Icons.star_rounded,
          color: textColor,
          size: AppValues.iconSizeMd,
        );

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
          colors: gradientColors,
        ),
        border: Border.all(
          color: isPrimary
              ? AppColors.clayBadgePrimaryBorder
              : AppColors.surfaceContainer,
          width: AppValues.borderWidthHairline,
        ),
        boxShadow: [
          BoxShadow(
            color: glowColor.withValues(alpha: AppValues.alphaGlowPressed),
            offset: const Offset(0, AppValues.radiusXs),
            blurRadius: AppValues.radiusMd,
            spreadRadius: AppValues.spreadSubtle,
          ),
        ],
      ),
      child: CustomPaint(
        painter: const ClayInsetPainter(
          borderRadius: AppValues.radiusPill,
          highlightColor: AppColors.clayHighlightBadge,
          shadeColor: AppColors.clayShadeBadge,
          highlightOffset: Offset(
            AppValues.badgeInsetOffset,
            AppValues.badgeInsetOffset,
          ),
          shadeOffset: Offset(
            -AppValues.badgeInsetOffset,
            -AppValues.badgeInsetOffset,
          ),
          highlightBlur: AppValues.badgeInsetBlur,
          shadeBlur: AppValues.badgeInsetBlur,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            iconWidget,
            const SizedBox(width: AppValues.space1),
            Text(
              customLabel ?? '$count',
              style: GoogleFonts.quicksand(
                color: textColor,
                fontWeight: FontWeight.w800,
                fontSize: customLabel != null
                    ? AppValues.fontCaptionSm
                    : AppValues.fontBodyMd,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
