import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_values.dart';
import '../../../../shared/ui_kit/painters/clay_inset_painter.dart';

/// Tactile Clay Page Indicator — joyful inflated beads precisely matching
/// kiddora_onboarding_1_welcome.png reference design.
///
/// Active bead: vibrant violet rounded capsule with soft specular highlight.
/// Inactive beads: soft pastel lilac circular beads with subtle clay bevel.
class ClayPageIndicator extends StatelessWidget {
  const ClayPageIndicator({
    super.key,
    required this.currentPage,
    this.pageCount = 3,
  });

  final int currentPage;
  final int pageCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(pageCount, (index) {
        final isActive = index == currentPage;
        return AnimatedContainer(
          duration: AppValues.durationIndicator,
          curve: Curves.easeOutBack,
          margin: const EdgeInsets.symmetric(horizontal: AppValues.radiusXs),
          height: AppValues.indicatorHeight,
          width: isActive
              ? AppValues.indicatorWidthActive
              : AppValues.indicatorWidthInactive,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppValues.radiusPill),
            gradient: isActive
                ? const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.brandIndigoIndicator,
                      AppColors.brandIndigoLight,
                    ],
                  )
                : const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.surfaceRaised,
                      AppColors.brandIndigoContainer,
                    ],
                  ),
            border: Border.all(
              color: isActive
                  ? Colors.white.withValues(alpha: 0.6)
                  : Colors.white.withValues(alpha: 0.8),
              width: AppValues.borderWidthThin,
            ),
            boxShadow: isActive
                ? [
                    // Extruded shelf base (subtle deep violet)
                    const BoxShadow(
                      color: AppColors.clayExtrusionIndigo,
                      offset: Offset(0, 1.5),
                      blurRadius: 0,
                    ),
                    // Soft purple glow
                    BoxShadow(
                      color: AppColors.brandIndigoLight.withValues(alpha: 0.35),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [
                    const BoxShadow(
                      color: AppColors.clayExtrusionDisabled,
                      offset: Offset(0, 1.0),
                      blurRadius: 0,
                    ),
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
          ),
          child: CustomPaint(
            painter: ClayInsetPainter(
              borderRadius: AppValues.radiusPill,
              highlightColor: isActive
                  ? AppColors.clayHighlightMedium
                  : AppColors.clayHighlightSoft,
              shadeColor: isActive
                  ? AppColors.clayShadeDeep
                  : AppColors.clayShadeSubtle,
              highlightOffset: const Offset(1.2, 1.2),
              shadeOffset: const Offset(-1.2, -1.2),
              highlightBlur: 2.0,
              shadeBlur: 2.0,
            ),
            child: const SizedBox.expand(),
          ),
        );
      }),
    );
  }
}
