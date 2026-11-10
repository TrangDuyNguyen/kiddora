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
import '../../classroom/presentation/sessions_hub_body.dart';
import '../../exploration/presentation/courses_hub_body.dart';
import '../../exploration/presentation/practice_tests_hub_body.dart';
import '../../onboarding/presentation/controllers/onboarding_controller.dart';
import '../../parent_hub/presentation/student_profile_body.dart';
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

  void _handleTabChanged(int index) {
    setState(() => _currentNavIndex = index);
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
            SessionsHubBody(onSnack: _showSnack),
            PracticeTestsHubBody(onSnack: _showSnack),
            StudentProfileBody(
              nickname: nickname,
              age: profile?.age ?? 8,
              onLogoutTap: _handleLogoutTap,
              onSnack: _showSnack,
            ),
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
