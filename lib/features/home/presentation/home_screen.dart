import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_values.dart';
import '../../../core/router/app_router.gr.dart';
import '../../onboarding/presentation/controllers/onboarding_controller.dart';
import 'widgets/clay_bottom_nav.dart';
import 'widgets/guest_claim_banner.dart';
import 'widgets/home_continue_learning_card.dart';
import 'widgets/home_header.dart';
import 'widgets/home_hero_banner.dart';
import 'widgets/home_quick_stats_grid.dart';
import 'widgets/home_upcoming_session_card.dart';

@RoutePage()
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingControllerProvider);
    final profile = state.profile;
    final nickname = profile?.nickname.isNotEmpty == true
        ? profile!.nickname
        : AppStrings.defaultKidName;

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppValues.space7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppValues.space4),

              // Header: Keil's Avatar, Greeting, Notification Badge & Logout
              HomeHeader(
                kidName: nickname,
                onNotificationTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(AppStrings.notificationsAlert),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                onLogoutTap: () {
                  HapticFeedback.mediumImpact();
                  context.router.replace(const LoginRoute());
                },
              ),
              const SizedBox(height: AppValues.space6),

              // Guest Claim Banner (shown only when in guest mode)
              const GuestClaimBanner(),

              // Hero Banner "Keep Learning Keep Growing!"

              HomeHeroBanner(
                onActionTap: () {
                  context.router.push(const TodayLearningGoalRoute());
                },
              ),
              const SizedBox(height: AppValues.space7),

              // Quick Actions 2x2 Grid (My Progress -> TodayLearningGoalScreen)
              HomeQuickStatsGrid(
                onMyProgressTap: () {
                  context.router.push(const TodayLearningGoalRoute());
                },
              ),
              const SizedBox(height: AppValues.space7),

              // Continue Learning Section (Amazing Animals Science)
              HomeContinueLearningCard(
                onTap: () {
                  context.router.push(const TodayLearningGoalRoute());
                },
              ),
              const SizedBox(height: AppValues.space7),

              // Upcoming Session Section (Math Fun with Numbers - Coach Sarah)
              HomeUpcomingSessionCard(
                onJoinTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(AppStrings.joiningSessionAlert),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
              const SizedBox(height: AppValues.space9),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ClayBottomNav(
        selectedIndex: _currentNavIndex,
        onIndexChanged: (index) {
          setState(() => _currentNavIndex = index);
          if (index == 2 || index == 3) {
            context.router.push(const TodayLearningGoalRoute());
          }
        },
      ),
    );
  }
}
