import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_values.dart';
import '../../../shared/ui_kit/ui_kit.dart';
import 'controllers/today_learning_goal_controller.dart';
import 'widgets/goal_circular_progress.dart';

@RoutePage()
class TodayLearningGoalScreen extends ConsumerWidget {
  const TodayLearningGoalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(todayLearningGoalControllerProvider);
    final controller = ref.read(todayLearningGoalControllerProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppValues.space7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: AppValues.space4),

              // Top App Bar with Circular Back Button
              Align(
                alignment: Alignment.centerLeft,
                child: ClayIconButton(
                  size: AppValues.sizeCircleButtonXl,
                  backgroundColor: Colors.white,
                  glowColor: AppColors.clayContactShadow,
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    context.router.maybePop();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: AppValues.iconSizeSm,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(height: AppValues.space4),

              // Title & Subtitle
              Text(
                AppStrings.todaysLearningGoal,
                style: GoogleFonts.quicksand(
                  fontSize: AppValues.fontHeadlineLg,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDarkIndigo,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppValues.radiusXs),
              Text(
                AppStrings.todaysGoalSubtitle,
                style: GoogleFonts.quicksand(
                  fontSize: AppValues.fontBodyMd,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSlate,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppValues.space7),

              // Center Circular Progress Ring
              GoalCircularProgress(
                completedCount: state.completedCount,
                totalCount: state.totalCount,
                progress: state.progressRatio,
              ),
              const SizedBox(height: AppValues.space8),

              // White Porcelain Task Checklist Card
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppValues.radiusXl),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadowIndigoSubtle,
                      offset: const Offset(0, 4),
                      blurRadius: AppValues.space7,
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppValues.space5,
                  vertical: AppValues.space4,
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.tasks.length,
                  separatorBuilder: (context, index) => const Divider(
                    color: AppColors.dividerSubtle,
                    height: AppValues.borderWidthThin,
                  ),
                  itemBuilder: (context, index) {
                    final task = state.tasks[index];
                    return _buildTaskRow(
                      task: task,
                      onTap: () => controller.toggleTask(task.id),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppValues.space7),

              // Bottom Motivation Card
              _buildMotivationCard(),
              const SizedBox(height: AppValues.space8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTaskRow({
    required DailyGoalTask task,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppValues.radiusTaskTile),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppValues.radiusLg,
          horizontal: AppValues.space4,
        ),
        child: Row(
          children: [
            // Checkbox Indicator
            AnimatedContainer(
              duration: AppValues.durationBounce,
              width: AppValues.sizeGoalCheckbox,
              height: AppValues.sizeGoalCheckbox,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: task.isCompleted
                    ? AppColors.stateSuccessGreen
                    : Colors.transparent,
                border: Border.all(
                  color: task.isCompleted
                      ? AppColors.stateSuccessGreen
                      : AppColors.taskCheckboxUnchecked,
                  width: AppValues.strokeWidthCheckbox,
                ),
              ),
              child: task.isCompleted
                  ? const Icon(
                      Icons.check_rounded,
                      size: AppValues.iconSizeTick,
                      color: Colors.white,
                    )
                  : null,
            ),
            const SizedBox(width: AppValues.space6),

            // Title & Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: GoogleFonts.quicksand(
                      fontSize: AppValues.fontBodyMd,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDarkIndigo,
                    ),
                  ),
                  Text(
                    task.subtitle,
                    style: GoogleFonts.quicksand(
                      fontSize: AppValues.fontBodySm,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSlate,
                    ),
                  ),
                ],
              ),
            ),

            // Trailing Chevron
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textMuted,
              size: AppValues.iconSizeXl,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMotivationCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.stateWarningContainer,
        borderRadius: BorderRadius.circular(AppValues.radiusXl),
        border: Border.all(
          color: AppColors.borderGoalCard,
          width: AppValues.borderWidthHairline,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.brandSecondary.withValues(alpha: 0.12),
            offset: const Offset(0, 4),
            blurRadius: AppValues.radiusLg,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppValues.space6,
        vertical: AppValues.space5,
      ),
      child: Row(
        children: [
          // 3D Mascot Boy Thumbs Up
          Image.asset(
            'assets/images/mascot_boy_thumbs_up.png',
            width: AppValues.sizeGoalThumbsMascot,
            height: AppValues.sizeGoalThumbsMascot,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: AppValues.space6),

          // Encouraging Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.youCanDoIt,
                  style: GoogleFonts.quicksand(
                    fontSize: AppValues.fontTitleLg,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textDarkIndigo,
                  ),
                ),
                const SizedBox(height: AppValues.radiusXs),
                Text(
                  AppStrings.reachGoalToday,
                  style: GoogleFonts.quicksand(
                    fontSize: AppValues.fontLabelMd,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSlate,
                    height: AppValues.lineHeightNormal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
