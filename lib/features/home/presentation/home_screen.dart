import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_values.dart';
import '../../../core/network/token_storage.dart';
import '../../../core/router/app_router.gr.dart';
import '../../../shared/ui_kit/ui_kit.dart';
import '../../exploration/presentation/courses_hub_body.dart';
import '../../onboarding/presentation/controllers/onboarding_controller.dart';
import 'widgets/home_dashboard_body.dart';

@RoutePage()
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentNavIndex = 0;

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), duration: AppValues.durationSnackBar),
    );
  }

  Future<void> _handleLogoutTap() async {
    HapticFeedback.mediumImpact();
    final confirmed = await ClayDialog.showLogout(context);
    if (confirmed != true || !mounted) return;
    final tokenStorage = ref.read(tokenStorageProvider);
    await tokenStorage.clearTokens();
    await tokenStorage.setGuestMode(false);
    if (mounted) {
      context.router.replace(const LoginRoute());
    }
  }

  Future<void> _handleTabChanged(int index) async {
    setState(() => _currentNavIndex = index);
    if (index == ClayNavTab.sessions.index) {
      final explore = await ClayDialog.showEmptySessions(context);
      if (explore == true && mounted) {
        setState(() => _currentNavIndex = ClayNavTab.courses.index);
      }
      return;
    }
    if (index == ClayNavTab.tests.index) {
      context.router.push(const TodayLearningGoalRoute());
    }
  }

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
        child: IndexedStack(
          index: _currentNavIndex,
          children: [
            HomeDashboardBody(
              nickname: nickname,
              onLogoutTap: _handleLogoutTap,
              onSnack: _showSnack,
            ),
            const CoursesHubBody(),
            const SizedBox.shrink(),
            const SizedBox.shrink(),
            const SizedBox.shrink(),
          ],
        ),
      ),
      bottomNavigationBar: ClayBottomNav(
        selectedIndex: _currentNavIndex,
        onIndexChanged: _handleTabChanged,
      ),
    );
  }
}
