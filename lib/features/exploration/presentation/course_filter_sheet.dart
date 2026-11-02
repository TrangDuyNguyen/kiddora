import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_values.dart';
import '../../../shared/ui_kit/buttons/clay_button.dart';
import '../../../shared/ui_kit/navigation/clay_screen_header.dart';
import '../domain/models/course_filter.dart';
import 'controllers/courses_controller.dart';

@RoutePage()
class CourseFilterScreen extends ConsumerStatefulWidget {
  const CourseFilterScreen({super.key});

  @override
  ConsumerState<CourseFilterScreen> createState() => _CourseFilterScreenState();
}

class _CourseFilterScreenState extends ConsumerState<CourseFilterScreen> {
  late String _selectedCategory;
  late String _selectedAge;
  late String _selectedLevel;
  late String _selectedDuration;

  @override
  void initState() {
    super.initState();
    final f = ref.read(coursesControllerProvider).filter;
    _selectedCategory = f.category;
    _selectedAge = f.ageRange;
    _selectedLevel = f.level;
    _selectedDuration = f.duration;
  }

  void _handleClearAll() {
    HapticFeedback.mediumImpact();
    setState(() {
      _selectedCategory = 'all';
      _selectedAge = 'all';
      _selectedLevel = 'all';
      _selectedDuration = 'all';
    });
  }

  void _handleApply() {
    HapticFeedback.lightImpact();
    final filter = CourseFilter(
      category: _selectedCategory,
      ageRange: _selectedAge,
      level: _selectedLevel,
      duration: _selectedDuration,
    );
    ref.read(coursesControllerProvider.notifier).applyFilter(filter);
    Navigator.of(context).maybePop(filter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppValues.space7),
              child: Column(
                children: [
                  const SizedBox(height: AppValues.space4),
                  ClayScreenHeader(
                    title: AppStrings.filterCoursesTitle,
                    onBackPressed: () => Navigator.of(context).maybePop(),
                    trailing: GestureDetector(
                      onTap: _handleClearAll,
                      child: Text(
                        AppStrings.filterClearAll,
                        style: GoogleFonts.quicksand(
                          fontSize: AppValues.fontBodySm,
                          fontWeight: FontWeight.w700,
                          color: AppColors.stateError,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppValues.space4),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: AppValues.space7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Program / Category
                    _buildSectionTitle(AppStrings.filterSectionProgram),
                    _buildChipWrap(
                      items: [
                        const _ChipOption('all', AppStrings.subjectAll),
                        const _ChipOption('science', AppStrings.subjectScience),
                        const _ChipOption('math', AppStrings.subjectMathematics),
                        const _ChipOption('language', AppStrings.subjectLanguage),
                        const _ChipOption('arts', AppStrings.subjectArtsCreativity),
                        const _ChipOption('technology', AppStrings.subjectTechnology),
                        const _ChipOption('life_skills', AppStrings.subjectLifeSkills),
                      ],
                      selectedValue: _selectedCategory,
                      onSelected: (val) => setState(() => _selectedCategory = val),
                    ),
                    const SizedBox(height: AppValues.space6),

                    // 2. Age Group
                    _buildSectionTitle(AppStrings.filterSectionAgeGroup),
                    _buildChipWrap(
                      items: [
                        const _ChipOption('all', AppStrings.subjectAll),
                        const _ChipOption('7-8', AppStrings.filterAge7to8),
                        const _ChipOption('9-10', AppStrings.filterAge9to10),
                        const _ChipOption('11-12', AppStrings.filterAge11to12),
                      ],
                      selectedValue: _selectedAge,
                      onSelected: (val) => setState(() => _selectedAge = val),
                    ),
                    const SizedBox(height: AppValues.space6),

                    // 3. Difficulty Level
                    _buildSectionTitle(AppStrings.filterSectionLevel),
                    _buildChipWrap(
                      items: [
                        const _ChipOption('all', AppStrings.subjectAll),
                        const _ChipOption('beginner', AppStrings.levelBeginner),
                        const _ChipOption('intermediate', AppStrings.levelIntermediate),
                        const _ChipOption('advanced', AppStrings.levelAdvanced),
                      ],
                      selectedValue: _selectedLevel,
                      onSelected: (val) => setState(() => _selectedLevel = val),
                    ),
                    const SizedBox(height: AppValues.space6),

                    // 4. Course Duration
                    _buildSectionTitle(AppStrings.filterSectionDuration),
                    _buildChipWrap(
                      items: [
                        const _ChipOption('all', AppStrings.subjectAll),
                        const _ChipOption('short', AppStrings.durationShort),
                        const _ChipOption('medium', AppStrings.durationMedium),
                        const _ChipOption('long', AppStrings.durationLong),
                      ],
                      selectedValue: _selectedDuration,
                      onSelected: (val) => setState(() => _selectedDuration = val),
                    ),
                    const SizedBox(height: AppValues.space9),
                  ],
                ),
              ),
            ),

            // Bottom CTA
            Padding(
              padding: const EdgeInsets.all(AppValues.space7),
              child: ClayButton(
                label: AppStrings.filterApply,
                icon: const Icon(
                  Icons.tune_rounded,
                  color: AppColors.textInverse,
                  size: AppValues.iconSizeMd,
                ),
                onPressed: _handleApply,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppValues.space4),
      child: Text(
        title,
        style: GoogleFonts.quicksand(
          fontSize: AppValues.fontTitleMd,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildChipWrap({
    required List<_ChipOption> items,
    required String selectedValue,
    required ValueChanged<String> onSelected,
  }) {
    return Wrap(
      spacing: AppValues.space4,
      runSpacing: AppValues.space4,
      children: items.map((opt) {
        final isSelected = opt.value == selectedValue;
        return GestureDetector(
          onTap: () {
            HapticFeedback.selectionClick();
            onSelected(opt.value);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppValues.space6,
              vertical: AppValues.space4,
            ),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.brandPrimary : AppColors.surfaceContainer,
              borderRadius: BorderRadius.circular(AppValues.radiusPill),
              boxShadow: isSelected
                  ? const [
                      BoxShadow(
                        color: AppColors.clayFilterActiveShadow,
                        offset: Offset(0, AppValues.offsetY2),
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
            child: Text(
              opt.label,
              style: GoogleFonts.quicksand(
                fontSize: AppValues.fontBodySm,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                color: isSelected ? AppColors.textInverse : AppColors.textPrimary,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _ChipOption {
  final String value;
  final String label;
  const _ChipOption(this.value, this.label);
}
