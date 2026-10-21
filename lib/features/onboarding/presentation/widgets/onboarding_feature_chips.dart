import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_values.dart';
import '../../../../shared/ui_kit/painters/clay_inset_painter.dart';

class FeatureChipItem {
  final IconData icon;
  final String label;
  final Color circleColor;
  final Color iconColor;

  const FeatureChipItem({
    required this.icon,
    required this.label,
    required this.circleColor,
    required this.iconColor,
  });
}

/// 3 Feature Chips row inside Onboarding Bottom Clay Sheet
///
/// Each circular badge uses **true inset shadows** via [ClayInsetPainter]
/// for the inflated clay-dough look instead of flat circles.
class OnboardingFeatureChips extends StatelessWidget {
  final List<FeatureChipItem> items;

  const OnboardingFeatureChips({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) {
        return Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 3D Inflated Circular Clay Badge with inset shadows
              Container(
                width: AppValues.onboardingActionBtnSize,
                height: AppValues.onboardingActionBtnSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: item.circleColor,
                  boxShadow: [
                    BoxShadow(
                      color: item.iconColor.withValues(alpha: 0.20),
                      offset: const Offset(0, 4),
                      blurRadius: 10,
                      spreadRadius: -1,
                    ),
                  ],
                ),
                child: CustomPaint(
                  painter: const ClayInsetPainter(
                    borderRadius: 0,
                    isCircle: true,
                    // Soft marshmallow inset for circular clay badges
                    highlightColor: AppColors.clayHighlightMuted,
                    shadeColor: AppColors.clayShadeSubtle,
                    highlightOffset: Offset(1.5, 1.5),
                    shadeOffset: Offset(-1.5, -1.5),
                    highlightBlur: 3.0,
                    shadeBlur: 3.0,
                  ),
                  child: Center(
                    child: Icon(
                      item.icon,
                      color: item.iconColor,
                      size: AppValues.fontHeadlineXl,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppValues.space4),
              Text(
                item.label,
                textAlign: TextAlign.center,
                style: GoogleFonts.quicksand(
                  fontSize: AppValues.fontBodySm,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  height: AppValues.lineHeightCompact,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
