import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_values.dart';
import '../painters/clay_inset_painter.dart';

/// Tactile Claymorphic Card — DESIGN.md §2.5 Level 1 Clay Rest
///
/// Combines outer pillow shadows (colored glow + ambient floor) with
/// **true inset shadows** via [ClayInsetPainter] to create the signature
/// inflated-clay-dough look: specular rim (top-left) + bevel shade (bottom-right).
class ClayCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color? glowColor;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final bool isSelected;
  final Color? selectedColor;
  final double? width;
  final double? height;

  const ClayCard({
    super.key,
    required this.child,
    this.onTap,
    this.backgroundColor = AppColors.surfaceContainer,
    this.glowColor,
    this.padding = const EdgeInsets.all(AppValues.space8),
    this.borderRadius = AppValues.radiusXl,
    this.isSelected = false,
    this.selectedColor,
    this.width,
    this.height,
  });

  @override
  State<ClayCard> createState() => _ClayCardState();
}

class _ClayCardState extends State<ClayCard> {
  bool _isPressed = false;

  void _handleTapDown(_) {
    if (widget.onTap != null) setState(() => _isPressed = true);
  }

  void _handleTapUp(_) {
    if (widget.onTap != null) setState(() => _isPressed = false);
  }

  void _handleTapCancel() {
    if (widget.onTap != null) setState(() => _isPressed = false);
  }

  void _handleTap() {
    if (widget.onTap != null) {
      HapticFeedback.lightImpact();
      widget.onTap!();
    }
  }

  @override
  Widget build(BuildContext context) {
    final glow = widget.glowColor ??
        (widget.isSelected
            ? AppColors.brandPrimary.withValues(alpha: 0.3)
            : AppColors.brandPrimary.withValues(alpha: 0.12));

    final activeColor = widget.selectedColor ?? AppColors.brandPrimary;

    final borderColor =
        widget.isSelected ? activeColor : Colors.white.withValues(alpha: 0.95);

    final extrusionColor = widget.isSelected
        ? activeColor.withValues(alpha: 0.35)
        : AppColors.clayCardShade;

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: widget.onTap != null ? _handleTap : null,
      child: AnimatedScale(
        scale: _isPressed ? AppValues.scalePressed : 1.0,
        duration: AppValues.durationNormal,
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: AppValues.durationFeedback,
          curve: Curves.easeOutCubic,
          width: widget.width,
          height: widget.height,
          transform: Matrix4.translationValues(
              0, _isPressed ? AppValues.translateYPressed : 0, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border.all(
              color: borderColor,
              width: widget.isSelected
                  ? AppValues.borderWidthThick
                  : AppValues.borderWidthHairline,
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: widget.isSelected
                  ? [
                      activeColor.withValues(alpha: 0.08),
                      Colors.white,
                      activeColor.withValues(alpha: 0.05),
                    ]
                  : const [
                      Colors.white,
                      AppColors.clayCardSurfaceLight,
                      AppColors.clayCardSurfaceTint,
                    ],
              stops: const [0.0, 0.5, 1.0],
            ),
            boxShadow: _isPressed
                ? [
                    // Pressed: minimal outer shadow
                    BoxShadow(
                      color: glow.withValues(alpha: 0.1),
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ]
                : [
                    // L1: Bottom physical extrusion shelf
                    BoxShadow(
                      color: extrusionColor,
                      offset: const Offset(0, 3.0),
                      blurRadius: 0,
                    ),
                    // L1: Outer colored pillow glow
                    BoxShadow(
                      color: glow,
                      offset: Offset(0, widget.isSelected ? 10 : 8),
                      blurRadius: widget.isSelected ? 20 : 16,
                      spreadRadius: widget.isSelected ? -1 : -2,
                    ),
                    // L1: Ambient floor shadow
                    BoxShadow(
                      color: AppColors.textPrimary.withValues(alpha: 0.04),
                      offset: const Offset(0, 4),
                      blurRadius: 8,
                      spreadRadius: -1,
                    ),
                  ],
          ),
          // Stack: inset shadow painter + content
          child: CustomPaint(
            painter: _isPressed
                ? const ClayInsetPainter(
                    borderRadius: 0, // overwritten below if needed
                    // Pressed: invert — darker top, lighter bottom (squished)
                    highlightColor: AppColors.claySquishShade, // 18% black
                    shadeColor: AppColors.claySquishHighlight, // 40% white
                    highlightOffset: Offset(4, 4),
                    shadeOffset: Offset(-2, -2),
                    highlightBlur: 8.0,
                    shadeBlur: 4.0,
                  )
                : ClayInsetPainter(
                    borderRadius: widget.borderRadius,
                    // Level 1 Clay Rest — DESIGN.md §2.5
                    highlightColor: AppColors.clayHighlight, // 85% white
                    shadeColor: AppColors.clayShade, // 6% deep ink
                    highlightOffset: const Offset(3, 3),
                    shadeOffset: const Offset(-3, -3),
                    highlightBlur: 5.0,
                    shadeBlur: 5.0,
                  ),
            child: Padding(
              padding: widget.padding,
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
