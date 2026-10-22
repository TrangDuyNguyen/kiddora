import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_values.dart';

class ClayBottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onIndexChanged;

  const ClayBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onIndexChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppValues.radiusBottomNav),
          topRight: Radius.circular(AppValues.radiusBottomNav),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.brandPrimary.withValues(alpha: 0.08),
            offset: const Offset(0, -4),
            blurRadius: AppValues.space7,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppValues.space7,
        vertical: AppValues.space5,
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(0, Icons.home_rounded, AppStrings.navHome),
            _buildNavItem(1, Icons.menu_book_rounded, AppStrings.navCourses),
            _buildNavItem(2, Icons.calendar_month_rounded, AppStrings.navSessions),
            _buildNavItem(3, Icons.assignment_rounded, AppStrings.navTests),
            _buildNavItem(4, Icons.more_horiz_rounded, AppStrings.navMore),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = selectedIndex == index;
    final color = isSelected ? AppColors.brandPrimary : AppColors.textMuted;

    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onIndexChanged(index);
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: AppValues.iconSizeLg, color: color),
          const SizedBox(height: AppValues.borderWidthThick),
          Text(
            label,
            style: GoogleFonts.quicksand(
              fontSize: AppValues.fontCaptionSm,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
