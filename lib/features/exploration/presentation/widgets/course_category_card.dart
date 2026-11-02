import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_values.dart';

class CourseCategoryCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const CourseCategoryCard({
    super.key,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bg = isSelected ? AppColors.brandPrimary : AppColors.surfaceContainer;
    final fg = isSelected ? AppColors.textInverse : AppColors.textPrimary;
    final iconColor = isSelected ? AppColors.textInverse : AppColors.brandPrimary;

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
          width: AppValues.minTouchTarget + AppValues.space9,
          constraints: const BoxConstraints(
            minHeight: AppValues.minTouchTarget + AppValues.space8,
          ),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(AppValues.radiusCardLg),
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
                      blurRadius: AppValues.space2,
                    ),
                  ],
          ),
          padding: const EdgeInsets.symmetric(
            vertical: AppValues.space4,
            horizontal: AppValues.space2,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: iconColor,
                size: AppValues.iconSizeLg,
              ),
              const SizedBox(height: AppValues.space2),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: GoogleFonts.quicksand(
                  fontSize: AppValues.fontBodySm,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                  color: fg,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
