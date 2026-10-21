import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/datasources/onboarding_local_datasource.dart';
import '../../data/repositories/onboarding_repository_impl.dart';
import '../../domain/models/kid_profile.dart';
import '../../domain/repositories/i_onboarding_repository.dart';

// Provider cho SharedPreferences (sẽ được override trong ProviderScope của main.dart)
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences chưa được khởi tạo');
});

// Provider cho OnboardingLocalDataSource
final onboardingLocalDataSourceProvider =
    Provider<OnboardingLocalDataSource>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return OnboardingLocalDataSource(prefs);
});

// Provider cho IOnboardingRepository
final onboardingRepositoryProvider = Provider<IOnboardingRepository>((ref) {
  final localDataSource = ref.watch(onboardingLocalDataSourceProvider);
  return OnboardingRepositoryImpl(localDataSource);
});

// State cho luồng Onboarding & Profile Setup
class OnboardingState {
  const OnboardingState({
    this.currentSlideIndex = 0,
    this.nickname = '',
    this.selectedAge = 8,
    this.selectedAvatarId = 'lion',
    this.isLoading = false,
    this.isCompleted = false,
    this.profile,
  });

  final int currentSlideIndex;
  final String nickname;
  final int selectedAge;
  final String selectedAvatarId;
  final bool isLoading;
  final bool isCompleted;
  final KidProfile? profile;

  bool get isProfileValid => nickname.trim().length >= 2;

  OnboardingState copyWith({
    int? currentSlideIndex,
    String? nickname,
    int? selectedAge,
    String? selectedAvatarId,
    bool? isLoading,
    bool? isCompleted,
    KidProfile? profile,
  }) {
    return OnboardingState(
      currentSlideIndex: currentSlideIndex ?? this.currentSlideIndex,
      nickname: nickname ?? this.nickname,
      selectedAge: selectedAge ?? this.selectedAge,
      selectedAvatarId: selectedAvatarId ?? this.selectedAvatarId,
      isLoading: isLoading ?? this.isLoading,
      isCompleted: isCompleted ?? this.isCompleted,
      profile: profile ?? this.profile,
    );
  }
}

// Controller quản lý tương tác và cập nhật hồ sơ bé
class OnboardingController extends StateNotifier<OnboardingState> {
  OnboardingController(this._repository, [OnboardingState? initialState])
      : super(initialState ?? const OnboardingState());

  final IOnboardingRepository _repository;

  void setSlideIndex(int index) {
    if (index >= 0 && index <= 2) {
      state = state.copyWith(currentSlideIndex: index);
    }
  }

  void updateNickname(String name) {
    state = state.copyWith(nickname: name);
  }

  void selectAge(int age) {
    if (age >= 7 && age <= 10) {
      state = state.copyWith(selectedAge: age);
    }
  }

  void selectAvatar(String avatarId) {
    state = state.copyWith(selectedAvatarId: avatarId);
  }

  Future<bool> completeOnboarding() async {
    if (!state.isProfileValid) return false;

    state = state.copyWith(isLoading: true);
    try {
      final profile = KidProfile(
        id: 'kid_${DateTime.now().millisecondsSinceEpoch}',
        nickname: state.nickname.trim(),
        age: state.selectedAge,
        avatarId: state.selectedAvatarId,
        currentStars: 10,
        currentStreak: 1,
      );

      await _repository.saveKidProfile(profile);
      await _repository.setCompletedOnboarding(true);

      state = state.copyWith(
        isLoading: false,
        isCompleted: true,
        profile: profile,
      );
      return true;
    } catch (_) {
      state = state.copyWith(isLoading: false);
      return false;
    }
  }
}

final onboardingControllerProvider =
    StateNotifierProvider<OnboardingController, OnboardingState>((ref) {
  final repo = ref.watch(onboardingRepositoryProvider);
  final localDataSource = ref.watch(onboardingLocalDataSourceProvider);
  final isCompleted = localDataSource.hasCompletedOnboarding;
  final profile = localDataSource.getKidProfile();

  return OnboardingController(
    repo,
    OnboardingState(
      isCompleted: isCompleted,
      profile: profile,
      nickname: profile?.nickname ?? '',
      selectedAge: profile?.age ?? 8,
      selectedAvatarId: profile?.avatarId ?? 'lion',
    ),
  );
});
