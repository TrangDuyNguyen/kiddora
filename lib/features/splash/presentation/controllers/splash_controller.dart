import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../onboarding/presentation/controllers/onboarding_controller.dart';

/// Reads onboarding completion state for route decision after splash.
class SplashState {
  const SplashState({this.isReady = false});
  final bool isReady;
}

class SplashController extends Notifier<SplashState> {
  @override
  SplashState build() => const SplashState();

  bool get hasCompletedOnboarding =>
      ref.read(onboardingControllerProvider).isCompleted;

  void markReady() => state = const SplashState(isReady: true);
}

final splashControllerProvider =
    NotifierProvider<SplashController, SplashState>(SplashController.new);
