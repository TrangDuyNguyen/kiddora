import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_values.dart';

/// Airy Tactile Clay Age Selector (US-04.2)
/// Organic, breathable floating pebbles with soft tactile feedback.
/// Zero heavy box borders, zero clutter.
class ClayAgeWheelSpinner extends StatefulWidget {
  final int selectedAge;
  final ValueChanged<int> onAgeChanged;

  const ClayAgeWheelSpinner({
    super.key,
    required this.selectedAge,
    required this.onAgeChanged,
  });

  @override
  State<ClayAgeWheelSpinner> createState() => _ClayAgeWheelSpinnerState();
}

class _ClayAgeWheelSpinnerState extends State<ClayAgeWheelSpinner> {
  late final ScrollController _scrollController;

  static const double _pebbleWidth = 58.0;
  static const double _pebbleHeight = 68.0;
  static const double _pebbleSpacing = 10.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelected(widget.selectedAge);
    });
  }

  @override
  void didUpdateWidget(covariant ClayAgeWheelSpinner oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedAge != widget.selectedAge) {
      _scrollToSelected(widget.selectedAge);
    }
  }

  void _scrollToSelected(int age) {
    if (!_scrollController.hasClients) return;
    final index =
        (age - AppValues.minAge).clamp(0, AppValues.targetAges.length - 1);
    final offset = index * (_pebbleWidth + _pebbleSpacing) - 30;
    _scrollController.animateTo(
      offset.clamp(0.0, _scrollController.position.maxScrollExtent),
      duration: AppValues.durationNormal,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  IconData _getIconForAge(int age) {
    switch (age) {
      case 6:
        return Icons.school_rounded;
      case 7:
        return Icons.explore_rounded;
      case 8:
        return Icons.psychology_rounded;
      case 9:
        return Icons.bolt_rounded;
      case 10:
        return Icons.military_tech_rounded;
      case 11:
        return Icons.science_rounded;
      case 12:
        return Icons.auto_awesome_rounded;
      default:
        return Icons.stars_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Horizontal Floating Pebbles Track
        SizedBox(
          height: 80,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: AppValues.targetAges.length,
            separatorBuilder: (_, __) => const SizedBox(width: _pebbleSpacing),
            itemBuilder: (context, index) {
              final age = AppValues.targetAges[index];
              final isSelected = age == widget.selectedAge;

              return GestureDetector(
                onTap: () {
                  HapticFeedback.selectionClick();
                  widget.onAgeChanged(age);
                },
                child: AnimatedContainer(
                  duration: AppValues.durationFast,
                  curve: Curves.easeOutCubic,
                  width: _pebbleWidth,
                  height: _pebbleHeight,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.brandPrimary : Colors.white,
                    borderRadius: BorderRadius.circular(AppValues.radiusXl),
                    boxShadow: isSelected
                        ? [
                            const BoxShadow(
                              color: Color(0xFF3730A3),
                              offset: Offset(0, 3),
                              blurRadius: 0,
                            ),
                            BoxShadow(
                              color:
                                  AppColors.brandPrimary.withValues(alpha: 0.35),
                              offset: const Offset(0, 6),
                              blurRadius: 14,
                            ),
                          ]
                        : [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.04),
                              offset: const Offset(0, 3),
                              blurRadius: 8,
                            ),
                          ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$age',
                        style: GoogleFonts.quicksand(
                          fontSize: isSelected ? 24 : 22,
                          fontWeight: FontWeight.w800,
                          height: 1.1,
                          color: isSelected
                              ? Colors.white
                              : AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        AppStrings.ageUnit,
                        style: GoogleFonts.quicksand(
                          fontSize: AppValues.fontBodySm,
                          fontWeight:
                              isSelected ? FontWeight.w800 : FontWeight.w600,
                          color: isSelected
                              ? Colors.white.withValues(alpha: 0.9)
                              : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 18),

        // Breathable, Elegant Milestone Hint Pill (Zero Boxed Overload)
        Center(
          child: AnimatedContainer(
            duration: AppValues.durationNormal,
            curve: Curves.easeOutCubic,
            padding: const EdgeInsets.symmetric(
              horizontal: AppValues.space6,
              vertical: AppValues.space3,
            ),
            decoration: BoxDecoration(
              color: AppColors.brandIndigoContainer,
              borderRadius: BorderRadius.circular(AppValues.radiusPill),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _getIconForAge(widget.selectedAge),
                  color: AppColors.brandPrimary,
                  size: AppValues.iconSizeSm,
                ),
                const SizedBox(width: AppValues.space2),
                Flexible(
                  child: Text(
                    AppStrings.curriculumHintForAge(widget.selectedAge),
                    style: GoogleFonts.quicksand(
                      fontSize: AppValues.fontBodySm,
                      fontWeight: FontWeight.w700,
                      color: AppColors.brandPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
