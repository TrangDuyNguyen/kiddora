import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_values.dart';
import '../../../../core/router/app_router.gr.dart';
import '../../../../shared/ui_kit/ui_kit.dart';
import '../widgets/celebration_reward_summary.dart';

@RoutePage()
class CourseCompletedCelebrationScreen extends StatelessWidget {
  final String courseId;
  final String? courseTitle;
  final int starsEarned;

  const CourseCompletedCelebrationScreen({
    super.key,
    required this.courseId,
    this.courseTitle,
    this.starsEarned = 50,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppValues.space6,
            vertical: AppValues.space7,
          ),
          child: Column(
            children: [
              _buildCelebrationCard(context),
              const SizedBox(height: AppValues.space7),
              _buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCelebrationCard(BuildContext context) {
    return ClayCard(
      padding: const EdgeInsets.all(AppValues.space7),
      child: Column(
        children: [
          Image.asset(
            'assets/images/mascot_boy_crown.png',
            height: AppValues.celebrationMascotSize,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: AppValues.space5),
          if (courseTitle != null) ...[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppValues.space4,
                vertical: AppValues.space2,
              ),
              decoration: BoxDecoration(
                color: AppColors.brandPrimary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppValues.radiusPill),
              ),
              child: Text(
                courseTitle!,
                style: GoogleFonts.quicksand(
                  fontSize: AppValues.fontCourseCategory,
                  fontWeight: FontWeight.bold,
                  color: AppColors.brandPrimary,
                ),
              ),
            ),
            const SizedBox(height: AppValues.space3),
          ],
          Text(
            AppStrings.celebrationTitle,
            style: GoogleFonts.quicksand(
              fontSize: AppValues.fontHeadlineXl,
              fontWeight: FontWeight.bold,
              color: AppColors.brandPrimary,
            ),
          ),
          const SizedBox(height: AppValues.space2),
          Text(
            AppStrings.courseCompletedHeading,
            style: GoogleFonts.quicksand(
              fontSize: AppValues.fontHeadlineMd,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppValues.space3),
          Text(
            AppStrings.courseCompletedSubheading,
            style: GoogleFonts.quicksand(
              fontSize: AppValues.fontBodySm,
              color: AppColors.textSecondary,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppValues.space6),
          const CelebrationRewardSummary(),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ClayButton(
            label: AppStrings.btnViewProgressTracker,
            onPressed: () {
              HapticFeedback.lightImpact();
              final hasRouter =
                  context.findAncestorWidgetOfExactType<RouterScope>() != null;
              if (hasRouter) {
                context.router.push(
                  CourseProgressTrackerRoute(
                    courseId: courseId,
                    courseTitle: courseTitle,
                  ),
                );
              }
            },
            height: AppValues.minTouchTarget,
            icon: const Icon(
              Icons.trending_up_rounded,
              color: AppColors.textInverse,
              size: AppValues.space6,
            ),
          ),
        ),
        const SizedBox(height: AppValues.space4),
        SizedBox(
          width: double.infinity,
          child: ClayButton(
            label: AppStrings.btnBackToHome,
            backgroundColor: AppColors.surfaceContainer,
            textColor: AppColors.textPrimary,
            onPressed: () {
              HapticFeedback.lightImpact();
              final hasRouter =
                  context.findAncestorWidgetOfExactType<RouterScope>() != null;
              if (hasRouter) {
                context.router.replace(const HomeRoute());
              }
            },
            height: AppValues.minTouchTarget,
          ),
        ),
      ],
    );
  }
}
