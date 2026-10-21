import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_values.dart';
import '../painters/clay_inset_painter.dart';

/// Universal Tactile Clay Action Button — DESIGN.md §2.5 Level 2 Clay Floating
///
/// 3D extrusion shelf + pillow glow + **true inset shadows** (specular rim +
/// bevel shade) via [ClayInsetPainter]. Pressed state inverts illumination
/// for haptic squish feel with scale(0.96) translateY(3px).
class ClayButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final Color? extrusionColor;
  final Widget? icon;
  final double height;
  final double? width;
  final bool isLoading;
  final double borderRadius;

  const ClayButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor = AppColors.brandPrimary,
    this.textColor = AppColors.textInverse,
    this.extrusionColor,
    this.icon,
    this.height = AppValues.recommendedKidTouchTarget,
    this.width,
    this.isLoading = false,
    this.borderRadius = AppValues.radiusPill,
  });

  @override
  State<ClayButton> createState() => _ClayButtonState();
}

class _ClayButtonState extends State<ClayButton> {
  bool _isPressed = false;

  void _handleTapDown(_) {
    if (widget.onPressed != null) setState(() => _isPressed = true);
  }

  void _handleTapUp(_) {
    if (widget.onPressed != null) setState(() => _isPressed = false);
  }

  void _handleTapCancel() {
    if (widget.onPressed != null) setState(() => _isPressed = false);
  }

  void _handleTap() {
    if (widget.onPressed != null) {
      HapticFeedback.mediumImpact();
      widget.onPressed!();
    }
  }

  Color _getExtrusionColor(bool isEnabled) {
    if (!isEnabled) return AppColors.clayExtrusionDisabled;
    if (widget.extrusionColor != null) return widget.extrusionColor!;
    if (widget.backgroundColor == AppColors.brandPrimary) {
      return AppColors.clayExtrusionIndigo;
    }
    if (widget.backgroundColor == AppColors.brandSecondary) {
      return AppColors.clayExtrusionAmber;
    }
    if (widget.backgroundColor == AppColors.brandMint) {
      return AppColors.clayExtrusionMint;
    }
    final hsl = HSLColor.fromColor(widget.backgroundColor);
    return hsl.withLightness((hsl.lightness - 0.16).clamp(0.0, 1.0)).toColor();
  }

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.onPressed != null;
    final extrusion = _getExtrusionColor(isEnabled);
    final baseColor =
        isEnabled ? widget.backgroundColor : AppColors.buttonDisabledBg;

    final gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: isEnabled
          ? [
              Color.lerp(baseColor, Colors.white, 0.28)!,
              baseColor,
              Color.lerp(baseColor, Colors.black, 0.12)!,
            ]
          : const [
              AppColors.buttonDisabledGradTop,
              AppColors.buttonDisabledBg,
              AppColors.buttonDisabledGradBottom,
            ],
      stops: const [0.0, 0.55, 1.0],
    );

    return GestureDetector(
      onTapDown: isEnabled ? _handleTapDown : null,
      onTapUp: isEnabled ? _handleTapUp : null,
      onTapCancel: isEnabled ? _handleTapCancel : null,
      onTap: isEnabled ? _handleTap : null,
      child: AnimatedScale(
        scale: _isPressed ? AppValues.scalePressed : 1.0,
        duration: AppValues.durationFast,
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: AppValues.durationFast,
          curve: Curves.easeOutCubic,
          height: widget.height,
          width: widget.width,
          transform: Matrix4.translationValues(
              0, _isPressed ? AppValues.translateYPressed : 0, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: gradient,
            border: Border.all(
              color: isEnabled
                  ? Colors.white.withValues(alpha: 0.5)
                  : Colors.white.withValues(alpha: 0.7),
              width: AppValues.borderWidthHairline,
            ),
            boxShadow: _isPressed || !isEnabled
                ? [
                    // Compressed extrusion
                    BoxShadow(
                      color: extrusion,
                      offset: const Offset(0, 1.2),
                      blurRadius: 0,
                    ),
                    BoxShadow(
                      color:
                          baseColor.withValues(alpha: isEnabled ? 0.2 : 0.05),
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ]
                : [
                    // Physical 3D Extruded Shelf underneath
                    BoxShadow(
                      color: extrusion,
                      offset: const Offset(0, 4.0),
                      blurRadius: 0,
                    ),
                    // L2: Outer colored pillow glow (stronger than L1)
                    BoxShadow(
                      color: baseColor.withValues(alpha: 0.38),
                      offset: const Offset(0, 14),
                      blurRadius: 24,
                      spreadRadius: -4,
                    ),
                    // Ambient floor shadow
                    BoxShadow(
                      color: AppColors.textPrimary.withValues(alpha: 0.06),
                      offset: const Offset(0, 6),
                      blurRadius: 8,
                      spreadRadius: -2,
                    ),
                  ],
          ),
          // Inset shadow layer for Claymorphism
          child: CustomPaint(
            painter: _isPressed
                ? const ClayInsetPainter(
                    borderRadius: 0,
                    // Active Pressed — DESIGN.md §2.5 depression
                    highlightColor: AppColors.claySquishShade, // 18% black
                    shadeColor: AppColors.claySquishHighlight, // 40% white
                    highlightOffset: Offset(4, 4),
                    shadeOffset: Offset(-2, -2),
                    highlightBlur: 8.0,
                    shadeBlur: 4.0,
                  )
                : ClayInsetPainter(
                    borderRadius: widget.borderRadius,
                    // Level 2 Clay Floating — DESIGN.md §2.5
                    highlightColor: AppColors.clayHighlightStrong, // 95% white
                    shadeColor: AppColors.clayShadeDeep, // 12% dark
                    highlightOffset: const Offset(4, 4),
                    shadeOffset: const Offset(-4, -4),
                    highlightBlur: 6.0,
                    shadeBlur: 6.0,
                  ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppValues.space9),
              child: widget.isLoading
                  ? const Center(
                      child: SizedBox(
                        width: AppValues.radiusXl,
                        height: AppValues.radiusXl,
                        child: CircularProgressIndicator(
                          strokeWidth: AppValues.borderWidthThick,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget.icon != null) ...[
                          widget.icon!,
                          const SizedBox(width: AppValues.space4),
                        ],
                        Text(
                          widget.label,
                          style: GoogleFonts.quicksand(
                            color: isEnabled
                                ? widget.textColor
                                : AppColors.buttonDisabledText,
                            fontSize: AppValues.fontTitleLg,
                            fontWeight: FontWeight.w800,
                            letterSpacing: AppValues.letterSpacingWide,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
