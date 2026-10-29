import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_values.dart';

/// Horizontal Scrollable Tactile Clay Filter Pill Bar
/// Used across `My Sessions` (`Upcoming / Completed / Cancelled`) and `Tests` (`All / Practice / Mock Test / Completed`).
class ClayFilterBar extends StatelessWidget {
  final List<String> items;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const ClayFilterBar({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: Row(
        children: [
          for (var i = 0; i < items.length; i++) ...[
            if (i > 0) const SizedBox(width: AppValues.space5),
            _ClayFilterChip(
              label: items[i],
              isSelected: i == selectedIndex,
              onTap: () {
                HapticFeedback.selectionClick();
                onSelected(i);
              },
            ),
          ],
        ],
      ),
    );
  }
}

class _ClayFilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ClayFilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: isSelected,
      label: label,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          constraints: const BoxConstraints(
            minHeight: AppValues.minTouchTarget,
            minWidth: AppValues.minTouchTarget,
          ),
          alignment: Alignment.center,
          child: AnimatedContainer(
            duration: AppValues.durationFeedback,
            curve: Curves.easeOutCubic,
            height: AppValues.sizeFilterChipH,
            padding: const EdgeInsets.symmetric(horizontal: AppValues.space7),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppValues.radiusInput),
              gradient: isSelected
                  ? const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.brandIndigoLight,
                        AppColors.brandPrimary,
                      ],
                    )
                  : null,
              color: isSelected ? null : AppColors.surfaceContainer,
              border: isSelected
                  ? null
                  : Border.all(
                      color: AppColors.borderInputPill,
                      width: AppValues.borderWidthDefault,
                    ),
              boxShadow: [
                BoxShadow(
                  color: isSelected
                      ? AppColors.clayFilterActiveShadow
                      : AppColors.clayShadeSubtle,
                  offset: const Offset(0, AppValues.offsetY3),
                  blurRadius: AppValues.radiusMd,
                ),
              ],
            ),
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.quicksand(
                fontSize: AppValues.fontLabelMd,
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                color: isSelected
                    ? AppColors.textInverse
                    : AppColors.textSlateDark,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

