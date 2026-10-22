import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_values.dart';

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
  final Widget? trailingIcon;
  final Gradient? customGradient;
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
    this.trailingIcon,
    this.customGradient,
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

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.onPressed != null;
    final baseColor =
        isEnabled ? widget.backgroundColor : AppColors.buttonDisabledBg;

    final gradient = widget.customGradient ??
        LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isEnabled
              ? [
                  Color.lerp(baseColor, Colors.white, 0.12)!,
                  baseColor,
                  Color.lerp(baseColor, Colors.black, 0.08)!,
                ]
              : const [
                  AppColors.buttonDisabledGradTop,
                  AppColors.buttonDisabledBg,
                  AppColors.buttonDisabledGradBottom,
                ],
          stops: const [0.0, 0.5, 1.0],
        );

    final glowColor =
        widget.customGradient != null ? AppColors.buttonGradientEnd : baseColor;

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
            boxShadow: _isPressed || !isEnabled
                ? [
                    BoxShadow(
                      color:
                          glowColor.withValues(alpha: isEnabled ? 0.22 : 0.05),
                      offset: const Offset(0, 2),
                      blurRadius: 6,
                    ),
                    const BoxShadow(
                      color: AppColors.clayShadeSubtle,
                      offset: Offset(0, 1),
                      blurRadius: 3,
                    ),
                  ]
                : [
                    // Plush colored pillow drop glow (matching Dribbble reference)
                    BoxShadow(
                      color: glowColor.withValues(alpha: 0.38),
                      offset: const Offset(0, 8),
                      blurRadius: 18,
                      spreadRadius: 0,
                    ),
                    // Ambient diffuse ground contact shadow
                    const BoxShadow(
                      color: AppColors.clayContactShadow,
                      offset: Offset(0, 3),
                      blurRadius: 8,
                      spreadRadius: -1,
                    ),
                  ],
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
                  : widget.trailingIcon != null
                      ? Stack(
                          alignment: Alignment.center,
                          children: [
                            Row(
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
                            Align(
                              alignment: Alignment.centerRight,
                              child: widget.trailingIcon!,
                            ),
                          ],
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
    );
  }
}
