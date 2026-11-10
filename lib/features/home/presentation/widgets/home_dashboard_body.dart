import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_values.dart';
import '../../../../core/router/app_router.gr.dart';
import '../../domain/models/home_dashboard_summary.dart';
import '../controllers/home_dashboard_controller.dart';
import 'guest_claim_banner.dart';
import 'home_continue_learning_card.dart';
import 'home_header.dart';
import 'home_hero_banner.dart';
import 'home_quick_stats_grid.dart';
import 'home_upcoming_session_card.dart';

class HomeDashboardBody extends ConsumerWidget {
  final String nickname;
  final VoidCallback onLogoutTap;
  final ValueChanged<String> onSnack;
  final ValueChanged<int>? onSwitchTab;

  const HomeDashboardBody({
    super.key,
    required this.nickname,
    required this.onLogoutTap,
    required this.onSnack,
    this.onSwitchTab,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(homeDashboardControllerProvider);
    final summary = summaryAsync.value ?? const HomeDashboardSummary();
    final displayName = nickname.isNotEmpty
        ? nickname
        : (summary.kidProfile.nickname.isNotEmpty
            ? summary.kidProfile.nickname
            : AppStrings.defaultKidName);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: AppValues.space7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppValues.space4),
          HomeHeader(
            kidName: displayName,
            avatarAsset: summary.kidProfile.avatarAsset,
            starPoints: summary.kidProfile.starPoints,
            notificationCount: summary.unreadNotificationsCount,
            onAvatarTap: () => onSwitchTab?.call(4),
            onNotificationTap: () => onSnack(AppStrings.notificationsAlert),
            onLogoutTap: onLogoutTap,
          ),
          const SizedBox(height: AppValues.space6),
          const GuestClaimBanner(),
          HomeHeroBanner(
            onActionTap: () {
              context.router.push(const TodayLearningGoalRoute());
            },
            onQuestTap: () {
              final lessonId = summary.continueLearning.nextLessonId;
              if (lessonId.isNotEmpty) {
                context.router.push(LessonPlayerRoute(lessonId: lessonId));
              } else {
                context.router.push(const TodayLearningGoalRoute());
              }
            },
          ),
          const SizedBox(height: AppValues.space7),
          HomeQuickStatsGrid(
            activeCoursesCount: summary.stats.activeCoursesCount,
            upcomingSessionSubtitle: AppStrings.upcomingSessionSubtitle,
            earnedBadgesCount: summary.stats.earnedBadgesCount,
            onMyProgressTap: () {
              context.router.push(const TodayLearningGoalRoute());
            },
            onCurrentCoursesTap: () => onSwitchTab?.call(1),
            onUpcomingSessionTap: () => onSwitchTab?.call(2),
            onMyBadgesTap: () => onSwitchTab?.call(4),
          ),
          const SizedBox(height: AppValues.space7),
          HomeContinueLearningCard(
            subjectName: summary.continueLearning.subjectName,
            courseTitle: summary.continueLearning.courseTitle,
            thumbnailAsset: summary.continueLearning.thumbnailAsset,
            progress: summary.continueLearning.progressPercentage,
            completedLessons: summary.continueLearning.completedLessons,
            totalLessons: summary.continueLearning.totalLessons,
            onTap: () {
              final lessonId = summary.continueLearning.nextLessonId;
              if (lessonId.isNotEmpty) {
                context.router.push(LessonPlayerRoute(lessonId: lessonId));
              } else {
                context.router.push(const TodayLearningGoalRoute());
              }
            },
            onSeeAllTap: () => onSwitchTab?.call(1),
          ),
          const SizedBox(height: AppValues.space7),
          HomeUpcomingSessionCard(
            title: summary.upcomingSession.title,
            coachName: summary.upcomingSession.coachName,
            coachAvatar: summary.upcomingSession.coachAvatar,
            scheduledTime: summary.upcomingSession.scheduledTime,
            onCardTap: () => onSwitchTab?.call(2),
            onJoinTap: () => onSwitchTab?.call(2),
            onSeeAllTap: () => onSwitchTab?.call(2),
          ),
          const SizedBox(height: AppValues.space9),
        ],
      ),
    );
  }
}
