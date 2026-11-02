import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_values.dart';
import '../../../../core/router/app_router.gr.dart';
import 'guest_claim_banner.dart';
import 'home_continue_learning_card.dart';
import 'home_header.dart';
import 'home_hero_banner.dart';
import 'home_quick_stats_grid.dart';
import 'home_upcoming_session_card.dart';

class HomeDashboardBody extends StatelessWidget {
  final String nickname;
  final VoidCallback onLogoutTap;
  final ValueChanged<String> onSnack;

  const HomeDashboardBody({
    super.key,
    required this.nickname,
    required this.onLogoutTap,
    required this.onSnack,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: AppValues.space7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppValues.space4),
          HomeHeader(
            kidName: nickname,
            onNotificationTap: () => onSnack(AppStrings.notificationsAlert),
            onLogoutTap: onLogoutTap,
          ),
          const SizedBox(height: AppValues.space6),
          const GuestClaimBanner(),
          HomeHeroBanner(
            onActionTap: () {
              context.router.push(const TodayLearningGoalRoute());
            },
          ),
          const SizedBox(height: AppValues.space7),
          HomeQuickStatsGrid(
            onMyProgressTap: () {
              context.router.push(const TodayLearningGoalRoute());
            },
          ),
          const SizedBox(height: AppValues.space7),
          HomeContinueLearningCard(
            onTap: () {
              context.router.push(const TodayLearningGoalRoute());
            },
          ),
          const SizedBox(height: AppValues.space7),
          HomeUpcomingSessionCard(
            onJoinTap: () => onSnack(AppStrings.joiningSessionAlert),
          ),
          const SizedBox(height: AppValues.space9),
        ],
      ),
    );
  }
}

