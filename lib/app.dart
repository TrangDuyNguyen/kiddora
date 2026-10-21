import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/app_strings.dart';
import 'core/router/app_router.dart';
import 'features/onboarding/presentation/controllers/onboarding_controller.dart';

class KiddoraApp extends ConsumerStatefulWidget {
  const KiddoraApp({super.key});

  @override
  ConsumerState<KiddoraApp> createState() => _KiddoraAppState();
}

class _KiddoraAppState extends ConsumerState<KiddoraApp> {
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    final onboardingState = ref.read(onboardingControllerProvider);
    _appRouter = AppRouter(hasCompletedOnboarding: onboardingState.isCompleted);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: _appRouter.config(),
    );
  }
}
