import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_values.dart';

/// Universal Tactile Clay Action Button with haptic squish effect
class ClayButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final Widget? icon;
  final double height;

  const ClayButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor = AppColors.brandPrimary,
    this.textColor = AppColors.textInverse,
    this.icon,
    this.height = AppValues.recommendedKidTouchTarget,
  });

  @override
  State<ClayButton> createState() => _ClayButtonState();
}

class _ClayButtonState extends State<ClayButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.onPressed != null;

    return GestureDetector(
      onTapDown: isEnabled ? (_) => setState(() => _isPressed = true) : null,
      onTapUp: isEnabled ? (_) => setState(() => _isPressed = false) : null,
      onTapCancel: isEnabled ? () => setState(() => _isPressed = false) : null,
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 80),
        height: widget.height,
        transform: Matrix4.translationValues(0, _isPressed ? 3 : 0, 0),
        decoration: BoxDecoration(
          color: isEnabled ? widget.backgroundColor : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(AppValues.radiusPill),
          boxShadow: _isPressed || !isEnabled
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    offset: const Offset(0, 2),
                    blurRadius: 4,
                  ),
                ]
              : [
                  BoxShadow(
                    color: widget.backgroundColor.withValues(alpha: 0.35),
                    offset: const Offset(0, 6),
                    blurRadius: 12,
                  ),
                ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppValues.space9),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) ...[
                widget.icon!,
                const SizedBox(width: AppValues.space4),
              ],
              Text(
                widget.label,
                style: TextStyle(
                  color: isEnabled ? widget.textColor : Colors.grey.shade600,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
