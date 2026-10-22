import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_values.dart';

/// Airy Tactile Quick Nickname Chips & Dice Randomizer (US-04.1)
/// Light, breathable, soft pills without heavy boxed outlines.
class QuickNicknameChips extends StatelessWidget {
  final String currentNickname;
  final ValueChanged<String> onSelectNickname;

  const QuickNicknameChips({
    super.key,
    required this.currentNickname,
    required this.onSelectNickname,
  });

  void _onRandomTap() {
    HapticFeedback.mediumImpact();
    final random = Random();
    final list = AppValues.randomNicknames;
    String candidate;
    do {
      candidate = list[random.nextInt(list.length)];
    } while (candidate == currentNickname && list.length > 1);
    onSelectNickname(candidate);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          // Gentle Dice Randomizer Button
          Tooltip(
            message: AppStrings.diceTooltip,
            child: GestureDetector(
              onTap: _onRandomTap,
              child: Container(
                width: 42,
                height: 42,
                margin: const EdgeInsets.only(right: AppValues.space3),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.brandPrimary.withValues(alpha: 0.15),
                    width: 1.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.brandPrimary.withValues(alpha: 0.08),
                      offset: const Offset(0, 3),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.casino_rounded,
                  color: AppColors.brandPrimary,
                  size: AppValues.iconSizeMd,
                ),
              ),
            ),
          ),

          // Suggestion Label
          Text(
            AppStrings.quickNicknameSuggestion,
            style: GoogleFonts.quicksand(
              fontSize: AppValues.fontBodyMd,
              fontWeight: FontWeight.w700,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(width: AppValues.space2),

          // Airy Preset Chips (Soft floating pills)
          ...AppValues.quickNicknames.map((name) {
            final isSelected = currentNickname.trim() == name;
            return Padding(
              padding: const EdgeInsets.only(right: AppValues.space2),
              child: GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact();
                  onSelectNickname(name);
                },
                child: AnimatedContainer(
                  duration: AppValues.durationFast,
                  height: 38,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.brandPrimary : Colors.white,
                    borderRadius: BorderRadius.circular(AppValues.radiusPill),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.brandPrimary
                          : Colors.white,
                      width: 1.0,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: isSelected
                            ? AppColors.brandPrimary.withValues(alpha: 0.25)
                            : Colors.black.withValues(alpha: 0.04),
                        offset: const Offset(0, 2),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        name,
                        style: GoogleFonts.quicksand(
                          fontSize: AppValues.fontBodyMd,
                          fontWeight:
                              isSelected ? FontWeight.w800 : FontWeight.w700,
                          color: isSelected
                              ? Colors.white
                              : AppColors.textPrimary,
                        ),
                      ),
                      if (isSelected) ...[
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.check_rounded,
                          color: Colors.white,
                          size: 16,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
