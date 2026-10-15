import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_values.dart';

/// Tactile Claymorphic Card with dual-axis illumination (Specular Rim + Inset Bevel)
class ClayCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color? glowColor;
  final EdgeInsetsGeometry padding;
  final double borderRadius;

  const ClayCard({
    super.key,
    required this.child,
    this.onTap,
    this.backgroundColor = AppColors.surfaceContainer,
    this.glowColor,
    this.padding = const EdgeInsets.all(AppValues.space8),
    this.borderRadius = AppValues.radiusXl,
  });

  @override
  State<ClayCard> createState() => _ClayCardState();
}

class _ClayCardState extends State<ClayCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final glow = widget.glowColor ?? AppColors.brandPrimary.withValues(alpha: 0.12);

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _isPressed ? 0.98 : 1.0,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOutBack,
        child: Container(
          padding: widget.padding,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border.all(color: AppColors.borderDefault, width: 1.5),
            boxShadow: _isPressed
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ]
                : [
                    BoxShadow(
                      color: glow,
                      offset: const Offset(0, 8),
                      blurRadius: 16,
                      spreadRadius: -2,
                    ),
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      offset: const Offset(0, 3),
                      blurRadius: 6,
                      spreadRadius: -1,
                    ),
                  ],
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
