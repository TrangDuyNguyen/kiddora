import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_values.dart';

/// Universal Tactile Clay Action Button — DESIGN.md §2.5 Level 2 Clay Floating
class ClayButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final Widget? icon;
  final Widget? trailingIcon;
  final Gradient? customGradient;
  final Border? border;
  final double height;
  final double? width;
  final double fontSize;
  final double horizontalPadding;
  final bool isLoading;
  final bool showGlow;
  final double borderRadius;
  final bool ensureMinTouchTarget;

  const ClayButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor = AppColors.brandPrimary,
    this.textColor = AppColors.textInverse,
    this.icon,
    this.trailingIcon,
    this.customGradient,
    this.border,
    this.height = AppValues.recommendedKidTouchTarget,
    this.width,
    this.fontSize = AppValues.fontTitleLg,
    this.horizontalPadding = AppValues.space9,
    this.isLoading = false,
    this.showGlow = true,
    this.borderRadius = AppValues.radiusPill,
    this.ensureMinTouchTarget = false,
  });

  /// Soft-tinted Lavender Clay Secondary Pill — WCAG AA 6.97:1 contrast
  const ClayButton.secondary({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.trailingIcon,
    this.height = AppValues.recommendedKidTouchTarget,
    this.width,
    this.isLoading = false,
    this.borderRadius = AppValues.radiusPill,
  })  : backgroundColor = AppColors.buttonSecondaryGradTop,
        textColor = AppColors.brandPrimary,
        customGradient = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.buttonSecondaryGradTop,
            AppColors.buttonSecondaryGradBottom,
          ],
        ),
        border = const Border.fromBorderSide(BorderSide(
          color: AppColors.buttonSecondaryBorder,
          width: AppValues.borderWidthDefault,
        )),
        fontSize = AppValues.fontTitleLg,
        horizontalPadding = AppValues.space9,
        showGlow = false,
        ensureMinTouchTarget = false;

  /// Compact Action Pill (`Join`, `Start`) with 48dp accessible hit target
  const ClayButton.compact({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor = AppColors.brandPrimary,
    this.textColor = AppColors.textInverse,
    this.icon,
  })  : trailingIcon = null,
        customGradient = null,
        border = null,
        height = AppValues.sizeButtonCompactH,
        width = null,
        fontSize = AppValues.fontLabelMd,
        horizontalPadding = AppValues.space8,
        isLoading = false,
        showGlow = true,
        borderRadius = AppValues.radiusCardLg,
        ensureMinTouchTarget = true;

  @override
  State<ClayButton> createState() => _ClayButtonState();
}

class _ClayButtonState extends State<ClayButton> {
  bool _isPressed = false;

  void _setPressed(bool v) {
    if (widget.onPressed != null && _isPressed != v) {
      setState(() => _isPressed = v);
    }
  }

  void _handleTap() {
    if (widget.onPressed != null && !widget.isLoading) {
      HapticFeedback.mediumImpact();
      widget.onPressed!();
    }
  }

  List<BoxShadow> _buildShadows(bool isEnabled, Color glow) {
    if (_isPressed || !isEnabled || !widget.showGlow) {
      return [
        BoxShadow(
          color: widget.showGlow
              ? glow.withValues(
                  alpha: isEnabled
                      ? AppValues.alphaGlowPressed
                      : AppValues.alphaGlowDisabled,
                )
              : AppColors.clayShadeSubtle,
          offset: const Offset(0, AppValues.offsetY2),
          blurRadius: AppValues.radiusSm,
        ),
      ];
    }
    return [
      BoxShadow(
        color: glow.withValues(alpha: AppValues.alphaGlowResting),
        offset: const Offset(0, AppValues.space4),
        blurRadius: AppValues.iconSizeSm,
      ),
      const BoxShadow(
        color: AppColors.clayContactShadow,
        offset: Offset(0, AppValues.offsetY3),
        blurRadius: AppValues.radiusMd,
        spreadRadius: AppValues.spreadSubtle,
      ),
    ];
  }

  Widget _buildLabelRow(bool isEnabled) => Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.icon != null) ...[
            widget.icon!,
            const SizedBox(width: AppValues.space4),
          ],
          Flexible(
            child: Text(
              widget.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.quicksand(
                color:
                    isEnabled ? widget.textColor : AppColors.buttonDisabledText,
                fontSize: widget.fontSize,
                fontWeight: FontWeight.w800,
                letterSpacing: AppValues.letterSpacingWide,
              ),
            ),
          ),
        ],
      );

  Widget _buildInnerContent(bool isEnabled) {
    if (widget.isLoading) {
      return Center(
        child: SizedBox(
          width: AppValues.iconSizeLg,
          height: AppValues.iconSizeLg,
          child: CircularProgressIndicator(
            strokeWidth: AppValues.borderWidthThick,
            valueColor: AlwaysStoppedAnimation<Color>(widget.textColor),
          ),
        ),
      );
    }
    if (widget.trailingIcon == null) return _buildLabelRow(isEnabled);
    return Stack(
      alignment: Alignment.center,
      children: [
        _buildLabelRow(isEnabled),
        Align(alignment: Alignment.centerRight, child: widget.trailingIcon!),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.onPressed != null;
    final base = isEnabled ? widget.backgroundColor : AppColors.buttonDisabledBg;
    final gradient = !isEnabled
        ? const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.buttonDisabledGradTop,
              AppColors.buttonDisabledBg,
              AppColors.buttonDisabledGradBottom,
            ],
          )
        : (widget.customGradient ??
            LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.lerp(
                  base,
                  AppColors.surfaceContainer,
                  AppValues.lerpHighlight,
                )!,
                base,
                Color.lerp(
                  base,
                  AppColors.textTertiary,
                  AppValues.lerpShade,
                )!,
              ],
            ));
    final glow =
        widget.customGradient != null ? AppColors.buttonGradientEnd : base;
    final pill = AnimatedScale(
      scale: _isPressed ? AppValues.scalePressed : 1.0,
      duration: AppValues.durationFast,
      curve: Curves.easeOutCubic,
      child: AnimatedContainer(
        duration: AppValues.durationFast,
        curve: Curves.easeOutCubic,
        height: widget.height,
        width: widget.width,
        transform: Matrix4.translationValues(
          0,
          _isPressed ? AppValues.translateYPressed : 0,
          0,
        ),
        padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          gradient: gradient,
          border: isEnabled ? widget.border : null,
          boxShadow: _buildShadows(isEnabled, glow),
        ),
        child: _buildInnerContent(isEnabled),
      ),
    );
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: isEnabled ? (_) => _setPressed(true) : null,
      onTapUp: isEnabled ? (_) => _setPressed(false) : null,
      onTapCancel: isEnabled ? () => _setPressed(false) : null,
      onTap: isEnabled ? _handleTap : null,
      child: widget.ensureMinTouchTarget
          ? ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: AppValues.minTouchTarget,
                minHeight: AppValues.minTouchTarget,
              ),
              child: Center(widthFactor: 1.0, child: pill),
            )
          : pill,
    );
  }
}
