import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_values.dart';
import '../../../../shared/ui_kit/painters/clay_inset_painter.dart';

/// Tactile Clay Age Selector Pebble — DESIGN.md §2.5 Level 1 Clay Rest
///
/// Rounded pebble with **true inset shadows** (specular rim + bevel shade)
/// + 3D extrusion base shelf + pillow glow. Selected state uses L2 Clay
/// Floating with stronger insets for the indigo-filled pebble.
class AgeClayPebble extends StatelessWidget {
  final int age;
  final bool isSelected;
  final VoidCallback onTap;

  const AgeClayPebble({
    super.key,
    required this.age,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedScale(
        scale: isSelected ? AppValues.scaleSelected : 1.0,
        duration: AppValues.durationBounce,
        curve: Curves.easeOutBack,
        child: AnimatedContainer(
          duration: AppValues.durationBounce,
          curve: Curves.easeOutCubic,
          width: AppValues.agePebbleWidth,
          height: AppValues.agePebbleHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppValues.agePebbleRadius),
            gradient: isSelected
                ? const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.clayIndigoGradTop,
                      AppColors.brandPrimary,
                      AppColors.clayIndigoGradBottom,
                    ],
                  )
                : const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white,
                      AppColors.clayCardGradMid,
                      AppColors.clayCardGradBottom,
                    ],
                  ),
            border: Border.all(
              color: isSelected
                  ? Colors.white.withValues(alpha: 0.55)
                  : Colors.white,
              width: AppValues.borderWidthMedium,
            ),
            boxShadow: isSelected
                ? [
                    // Physical 3D extrusion base shelf
                    const BoxShadow(
                      color: AppColors.clayExtrusionIndigo,
                      offset: Offset(0, 3.5),
                      blurRadius: 0,
                    ),
                    // Pillow glow
                    BoxShadow(
                      color: AppColors.brandPrimary.withValues(alpha: 0.42),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [
                    // Bottom extrusion shelf
                    const BoxShadow(
                      color: AppColors.clayCardShade,
                      offset: Offset(0, 2.5),
                      blurRadius: 0,
                    ),
                    // Ambient soft shadow
                    BoxShadow(
                      color: AppColors.textPrimary.withValues(alpha: 0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
          ),
          // Inset shadow layer for clay inflation
          child: CustomPaint(
            painter: isSelected
                ? const ClayInsetPainter(
                    borderRadius: AppValues.agePebbleRadius,
                    // L2: stronger specular on indigo surface
                    highlightColor: AppColors.clayHighlightStrong,
                    shadeColor: AppColors.clayShadeDeep,
                    highlightOffset: Offset(3, 3),
                    shadeOffset: Offset(-3, -3),
                    highlightBlur: 5.0,
                    shadeBlur: 5.0,
                  )
                : const ClayInsetPainter(
                    borderRadius: AppValues.agePebbleRadius,
                    // L1: standard clay rest
                    highlightColor: AppColors.clayHighlight,
                    shadeColor: AppColors.clayShade,
                    highlightOffset: Offset(3, 3),
                    shadeOffset: Offset(-3, -3),
                    highlightBlur: 5.0,
                    shadeBlur: 5.0,
                  ),
            child: Center(
              child: Text(
                '$age ${AppStrings.ageUnit}',
                style: GoogleFonts.quicksand(
                  fontSize: AppValues.fontBodyMd,
                  fontWeight: FontWeight.w800,
                  color: isSelected ? Colors.white : AppColors.textPrimary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
