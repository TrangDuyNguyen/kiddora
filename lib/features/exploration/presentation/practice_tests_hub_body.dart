import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_values.dart';
import '../../../shared/ui_kit/ui_kit.dart';

class PracticeTestsHubBody extends StatefulWidget {
  final ValueChanged<String>? onSnack;

  const PracticeTestsHubBody({super.key, this.onSnack});

  @override
  State<PracticeTestsHubBody> createState() => _PracticeTestsHubBodyState();
}

class _PracticeTestsHubBodyState extends State<PracticeTestsHubBody> {
  int _selectedCategoryIndex = 0;

  static const _categories = [
    (title: AppStrings.categoryMath, icon: Icons.functions_rounded, color: AppColors.brandPrimary),
    (title: AppStrings.categoryStem, icon: Icons.biotech_rounded, color: AppColors.brandTertiary),
    (title: AppStrings.categoryLogic, icon: Icons.psychology_rounded, color: AppColors.brandMint),
    (title: AppStrings.categoryLanguage, icon: Icons.translate_rounded, color: AppColors.brandSky),
  ];

  static const _quizzes = [
    (
      title: AppStrings.testAnimalsTitle,
      meta: AppStrings.testAnimalsMeta,
      color: AppColors.brandTertiary,
      icon: Icons.pets_rounded,
    ),
    (
      title: AppStrings.testMathRiddleTitle,
      meta: AppStrings.testMathRiddleMeta,
      color: AppColors.brandPrimary,
      icon: Icons.calculate_rounded,
    ),
    (
      title: AppStrings.testSpaceOceanTitle,
      meta: AppStrings.testSpaceOceanMeta,
      color: AppColors.brandSky,
      icon: Icons.explore_rounded,
    ),
  ];

  void _notify(String msg) {
    if (widget.onSnack != null) {
      widget.onSnack!(msg);
    } else {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(msg),
          duration: AppValues.durationSnackBar,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppValues.space6,
        vertical: AppValues.space4,
      ),
      children: [
        _buildHeader(),
        const SizedBox(height: AppValues.space6),
        _buildStatsScoreboard(),
        const SizedBox(height: AppValues.space7),
        _buildCategorySection(),
        const SizedBox(height: AppValues.space7),
        _buildRecommendedSection(),
        const SizedBox(height: AppValues.space10),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.testsHubTitle,
          style: GoogleFonts.quicksand(
            fontSize: AppValues.fontHeadlineMid,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppValues.space1),
        Text(
          AppStrings.testsHubSubtitle,
          style: GoogleFonts.quicksand(
            fontSize: AppValues.fontBodySm,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsScoreboard() {
    return ClayCard(
      padding: const EdgeInsets.all(AppValues.space6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            label: AppStrings.statCompletedTests,
            value: AppStrings.statCompletedTestsValue,
            icon: Icons.check_circle_rounded,
            color: AppColors.brandMint,
          ),
          Container(
            width: 1,
            height: AppValues.space10,
            color: AppColors.dividerSubtle,
          ),
          _buildStatItem(
            label: AppStrings.statHighestScore,
            value: AppStrings.statHighestScoreValue,
            icon: Icons.emoji_events_rounded,
            color: AppColors.brandAmber,
          ),
          Container(
            width: 1,
            height: AppValues.space10,
            color: AppColors.dividerSubtle,
          ),
          _buildStatItem(
            label: AppStrings.statAverageScore,
            value: AppStrings.statAverageScoreValue,
            icon: Icons.trending_up_rounded,
            color: AppColors.brandPrimary,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: AppValues.iconSizeMd),
        const SizedBox(height: AppValues.space2),
        Text(
          value,
          style: GoogleFonts.quicksand(
            fontSize: AppValues.fontTitleHero,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppValues.space1),
        Text(
          label,
          style: GoogleFonts.quicksand(
            fontSize: AppValues.fontCaptionSm,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.testCategoryTitle,
          style: GoogleFonts.quicksand(
            fontSize: AppValues.fontTitleHero,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppValues.space4),
        SizedBox(
          height: AppValues.minTouchTarget,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: AppValues.space3),
            itemBuilder: (context, index) {
              final cat = _categories[index];
              final isSelected = index == _selectedCategoryIndex;
              return GestureDetector(
                onTap: () => setState(() => _selectedCategoryIndex = index),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppValues.space6,
                    vertical: AppValues.space2,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? cat.color
                        : AppColors.surfaceContainer,
                    borderRadius: BorderRadius.circular(AppValues.radiusPill),
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Icon(
                        cat.icon,
                        size: AppValues.iconSizeSm,
                        color: isSelected
                            ? AppColors.textInverse
                            : cat.color,
                      ),
                      const SizedBox(width: AppValues.space2),
                      Text(
                        cat.title,
                        style: GoogleFonts.quicksand(
                          fontSize: AppValues.fontBodyMd,
                          fontWeight: FontWeight.bold,
                          color: isSelected
                              ? AppColors.textInverse
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
      ],
    );
  }

  Widget _buildRecommendedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.recommendedTestsTitle,
          style: GoogleFonts.quicksand(
            fontSize: AppValues.fontTitleHero,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppValues.space4),
        for (final q in _quizzes) ...[
          _buildQuizCard(q),
          const SizedBox(height: AppValues.space4),
        ],
      ],
    );
  }

  Widget _buildQuizCard(
    ({String title, String meta, Color color, IconData icon}) q,
  ) {
    return ClayCard(
      padding: const EdgeInsets.all(AppValues.space6),
      child: Row(
        children: [
          Container(
            width: AppValues.minTouchTarget,
            height: AppValues.minTouchTarget,
            decoration: BoxDecoration(
              color: q.color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(AppValues.radiusLg),
            ),
            child: Icon(q.icon, color: q.color, size: AppValues.iconSizeLg),
          ),
          const SizedBox(width: AppValues.space4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  q.title,
                  style: GoogleFonts.quicksand(
                    fontSize: AppValues.fontBodyMd,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppValues.space1),
                Text(
                  q.meta,
                  style: GoogleFonts.quicksand(
                    fontSize: AppValues.fontCaptionSm,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          ClayButton.compact(
            label: AppStrings.btnStartTest,
            onPressed: () => _notify('${q.title} - ${AppStrings.btnStartTest}'),
          ),
        ],
      ),
    );
  }
}
