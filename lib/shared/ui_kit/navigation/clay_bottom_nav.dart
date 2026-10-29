import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_values.dart';

/// Canonical 5-tab navigation items for Kiddora bottom bar
enum ClayNavTab {
  home(Icons.home_rounded, AppStrings.navHome),
  courses(Icons.menu_book_rounded, AppStrings.navCourses),
  sessions(Icons.calendar_month_rounded, AppStrings.navSessions),
  tests(Icons.assignment_rounded, AppStrings.navTests),
  profile(Icons.person_rounded, AppStrings.navProfile);

  final IconData icon;
  final String label;
  const ClayNavTab(this.icon, this.label);
}

/// Shared Tactile Clay 5-Tab Bottom Navigation Bar — AGENTS.md §3
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
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppValues.radiusBottomNav),
          topRight: Radius.circular(AppValues.radiusBottomNav),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.clayBottomNavShadow,
            offset: Offset(0, -AppValues.radiusXs),
            blurRadius: AppValues.space7,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppValues.space4,
        vertical: AppValues.space2,
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            for (final tab in ClayNavTab.values) _buildNavItem(tab),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(ClayNavTab tab) {
    final isSelected = selectedIndex == tab.index;
    final color = isSelected ? AppColors.brandPrimary : AppColors.textMuted;

    return Semantics(
      button: true,
      selected: isSelected,
      label: tab.label,
      child: GestureDetector(
        onTap: () {
          HapticFeedback.lightImpact();
          onIndexChanged(tab.index);
        },
        behavior: HitTestBehavior.opaque,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: AppValues.minTouchTarget,
            minHeight: AppValues.minTouchTarget,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(tab.icon, size: AppValues.iconSizeLg, color: color),
              const SizedBox(height: AppValues.borderWidthThick),
              Text(
                tab.label,
                style: GoogleFonts.quicksand(
                  fontSize: AppValues.fontCaptionSm,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

