import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_values.dart';

class CourseCategoryCard extends StatelessWidget {
  final String label;
  final IconData? icon;
  final String? assetIcon;
  final bool isSelected;
  final Color? activeColor;
  final Color? iconColor;
  final VoidCallback onTap;
  final double? width;

  const CourseCategoryCard({
    super.key,
    required this.label,
    this.icon,
    this.assetIcon,
    required this.isSelected,
    this.activeColor,
    this.iconColor,
    required this.onTap,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final bg = isSelected
        ? (activeColor ?? AppColors.categoryActiveBg)
        : AppColors.categoryInactiveBg;
    final fg = isSelected ? AppColors.textInverse : AppColors.textPrimary;
    final resolvedIconColor = isSelected
        ? AppColors.textInverse
        : (iconColor ?? AppColors.brandPrimary);

    return Semantics(
      button: true,
      selected: isSelected,
      label: label,
      child: GestureDetector(
        onTap: () {
          HapticFeedback.selectionClick();
          onTap();
        },
        child: Container(
          width: width,
          height: AppValues.categoryCardH,
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(AppValues.categoryCardRadius),
            boxShadow: isSelected
                ? const [
                    BoxShadow(
                      color: AppColors.clayFilterActiveShadow,
                      offset: Offset(0, AppValues.offsetY3),
                      blurRadius: AppValues.space4,
                    ),
                  ]
                : const [
                    BoxShadow(
                      color: AppColors.shadowCardAmbient,
                      offset: Offset(0, AppValues.offsetY2),
                      blurRadius: AppValues.space3,
                    ),
                  ],
          ),
          padding: const EdgeInsets.symmetric(
            vertical: AppValues.space2,
            horizontal: AppValues.borderWidthThick,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (assetIcon != null)
                Image.asset(
                  assetIcon!,
                  width: AppValues.categoryCardIconSize,
                  height: AppValues.categoryCardIconSize,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => Icon(
                    icon ?? Icons.category_rounded,
                    color: resolvedIconColor,
                    size: AppValues.categoryCardIconSize,
                  ),
                )
              else if (icon != null)
                Icon(
                  icon!,
                  color: resolvedIconColor,
                  size: AppValues.categoryCardIconSize,
                ),
              const SizedBox(height: AppValues.space2),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppValues.borderWidthThin),
                  child: Text(
                    label,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.quicksand(
                      fontSize: AppValues.fontCaptionSm,
                      letterSpacing: -0.2,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                      color: fg,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
