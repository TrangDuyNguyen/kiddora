import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_values.dart';

/// 3D Tactile Clay Circular Action Button — DESIGN.md Level 2 Clay Floating
///
/// Seamless borderless circular clay sphere matching the Dribbble reference design:
/// Velvety radial spherical shading, zero harsh outline borders, and a plush
/// diffuse purple glow underneath.
class ClayIconButton extends StatefulWidget {
  final Widget icon;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color? glowColor;
  final Color? extrusionColor;
  final Gradient? gradient;
  final Border? border;
  final double size;

  const ClayIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.backgroundColor = AppColors.brandIndigoLight,
    this.glowColor,
    this.extrusionColor,
    this.gradient,
    this.border,
    this.size = AppValues.recommendedKidTouchTarget, // 56dp
  });

  @override
  State<ClayIconButton> createState() => _ClayIconButtonState();
}

class _ClayIconButtonState extends State<ClayIconButton> {
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
      HapticFeedback.lightImpact();
      widget.onPressed!();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.onPressed != null;
    final isWhite = widget.backgroundColor == Colors.white;

    final glow = widget.glowColor ??
        (isWhite ? AppColors.textPrimary : widget.backgroundColor);

    final Gradient surfaceGradient;
    if (widget.gradient != null) {
      surfaceGradient = widget.gradient!;
    } else if (!isEnabled) {
      surfaceGradient = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          AppColors.buttonDisabledGradTop,
          AppColors.buttonDisabledBg,
        ],
      );
    } else if (isWhite) {
      surfaceGradient = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white,
          AppColors.clayWhiteGradMid,
          AppColors.clayWhiteGradBottom,
        ],
      );
    } else {
      // Soft velvety spherical clay gradient matching Reference Image 2
      surfaceGradient = const RadialGradient(
        center: Alignment(-0.25, -0.35),
        radius: 0.95,
        colors: [
          AppColors.claySphereVioletLight, // Soft radiant violet at focal point
          AppColors.claySphereVioletMid, // Rich iris violet
          AppColors.claySphereVioletDark, // Smooth deep violet edge
        ],
        stops: [0.0, 0.65, 1.0],
      );
    }

    return GestureDetector(
      onTapDown: isEnabled ? _handleTapDown : null,
      onTapUp: isEnabled ? _handleTapUp : null,
      onTapCancel: isEnabled ? _handleTapCancel : null,
      onTap: isEnabled ? _handleTap : null,
      child: AnimatedScale(
        scale: _isPressed ? AppValues.scalePressedSubtle : 1.0,
        duration: AppValues.durationNormal,
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: AppValues.durationNormal,
          curve: Curves.easeOutCubic,
          width: widget.size,
          height: widget.size,
          transform: Matrix4.translationValues(
              0, _isPressed ? AppValues.translateYPressedSubtle : 0, 0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: surfaceGradient,
            border:
                widget.border, // Borderless by default for velvety clay look
            boxShadow: _isPressed
                ? [
                    BoxShadow(
                      color: glow.withValues(alpha: isWhite ? 0.08 : 0.25),
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
                    // Plush colored pillow drop glow (matching reference)
                    BoxShadow(
                      color: glow.withValues(alpha: isWhite ? 0.08 : 0.40),
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
          child: Center(child: widget.icon),
        ),
      ),
    );
  }
}
