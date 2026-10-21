import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_values.dart';
import '../../../../shared/ui_kit/surfaces/clay_card.dart';

/// 3D Tactile Clay Pedestal for Kid Mascot Companions
class AvatarClayPedestal extends StatelessWidget {
  final String name;
  final String path;
  final bool isSelected;
  final VoidCallback onTap;

  const AvatarClayPedestal({
    super.key,
    required this.name,
    required this.path,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClayCard(
      onTap: onTap,
      isSelected: isSelected,
      padding: const EdgeInsets.all(AppValues.avatarPedestalPadding),
      borderRadius: AppValues.avatarPedestalRadius,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.brandPrimary.withValues(alpha: 0.08)
                    : AppColors.surfaceRaised,
                borderRadius:
                    BorderRadius.circular(AppValues.avatarInnerRadius),
                border: Border.all(
                  color: isSelected
                      ? AppColors.brandPrimary.withValues(alpha: 0.2)
                      : Colors.white,
                  width: AppValues.borderWidthHairline,
                ),
              ),
              padding: const EdgeInsets.all(AppValues.avatarInnerPadding),
              child: Image.asset(path, fit: BoxFit.contain),
            ),
          ),
          const SizedBox(height: AppValues.space4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name,
                style: GoogleFonts.quicksand(
                  fontSize: AppValues.fontTitleMd,
                  fontWeight: FontWeight.w800,
                  color: isSelected
                      ? AppColors.brandPrimary
                      : AppColors.textPrimary,
                ),
              ),
              if (isSelected) ...[
                const SizedBox(width: AppValues.radiusXs),
                const Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.brandPrimary,
                  size: AppValues.fontTitleLg,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
