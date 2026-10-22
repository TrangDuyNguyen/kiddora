import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
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
                  size: 44,
                  backgroundColor: Colors.white,
                  glowColor: Colors.black.withValues(alpha: 0.04),
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    context.router.maybePop();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 18,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(height: AppValues.space4),

              // Title & Subtitle
              Text(
                "Today's Learning Goal",
                style: GoogleFonts.quicksand(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF1E1B4B),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                'Small steps make big progress!',
                style: GoogleFonts.quicksand(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF6E6D7A),
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
                      color: const Color(0xFF4F46E5).withValues(alpha: 0.06),
                      offset: const Offset(0, 4),
                      blurRadius: 16,
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
                    color: Color(0xFFF1F5F9),
                    height: 1,
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
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
        child: Row(
          children: [
            // Checkbox Indicator
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: task.isCompleted
                    ? const Color(0xFF10B981)
                    : Colors.transparent,
                border: Border.all(
                  color: task.isCompleted
                      ? const Color(0xFF10B981)
                      : const Color(0xFFC7D2FE),
                  width: 2.0,
                ),
              ),
              child: task.isCompleted
                  ? const Icon(
                      Icons.check_rounded,
                      size: 16,
                      color: Colors.white,
                    )
                  : null,
            ),
            const SizedBox(width: 14),

            // Title & Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: GoogleFonts.quicksand(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1E1B4B),
                    ),
                  ),
                  Text(
                    task.subtitle,
                    style: GoogleFonts.quicksand(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF6E6D7A),
                    ),
                  ),
                ],
              ),
            ),

            // Trailing Chevron
            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFF94A3B8),
              size: 22,
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
        color: const Color(0xFFFEF3C7),
        borderRadius: BorderRadius.circular(AppValues.radiusXl),
        border: Border.all(color: const Color(0xFFFDE68A), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFF59E0B).withValues(alpha: 0.12),
            offset: const Offset(0, 4),
            blurRadius: 12,
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
            width: 76,
            height: 76,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 14),

          // Encouraging Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'You can do it!',
                  style: GoogleFonts.quicksand(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF1E1B4B),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Keep learning and reach your goal today!',
                  style: GoogleFonts.quicksand(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF6E6D7A),
                    height: 1.3,
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
