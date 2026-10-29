import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_values.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/token_storage.dart';
import '../../../auth/data/repositories/auth_repository_impl.dart';
import '../../../auth/domain/repositories/i_auth_repository.dart';
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
  try {
    final prefs = ref.watch(sharedPreferencesProvider);
    return OnboardingLocalDataSource(prefs);
  } catch (_) {
    return const OnboardingLocalDataSource();
  }
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
    this.errorMessage,
  });


  final int currentSlideIndex;
  final String nickname;
  final int selectedAge;
  final String selectedAvatarId;
  final bool isLoading;
  final bool isCompleted;
  final KidProfile? profile;
  final String? errorMessage;

  bool get isProfileValid => nickname.trim().length >= 2;

  OnboardingState copyWith({
    int? currentSlideIndex,
    String? nickname,
    int? selectedAge,
    String? selectedAvatarId,
    bool? isLoading,
    bool? isCompleted,
    KidProfile? profile,
    String? errorMessage,
  }) {
    return OnboardingState(
      currentSlideIndex: currentSlideIndex ?? this.currentSlideIndex,
      nickname: nickname ?? this.nickname,
      selectedAge: selectedAge ?? this.selectedAge,
      selectedAvatarId: selectedAvatarId ?? this.selectedAvatarId,
      isLoading: isLoading ?? this.isLoading,
      isCompleted: isCompleted ?? this.isCompleted,
      profile: profile ?? this.profile,
      errorMessage: errorMessage,
    );
  }
}

// Controller quản lý tương tác và cập nhật hồ sơ bé
class OnboardingController extends StateNotifier<OnboardingState> {
  OnboardingController(
    this._repository, [
    this._authRepository,
    this._tokenStorage,
    OnboardingState? initialState,
  ]) : super(initialState ?? const OnboardingState());

  final IOnboardingRepository _repository;
  final IAuthRepository? _authRepository;
  final TokenStorage? _tokenStorage;

  void setSlideIndex(int index) {
    if (index >= 0 && index <= 2) {
      state = state.copyWith(currentSlideIndex: index);
    }
  }

  void updateNickname(String name) {
    state = state.copyWith(nickname: name);
  }

  void selectAge(int age) {
    if (age >= AppValues.minAge && age <= AppValues.maxAge) {
      state = state.copyWith(selectedAge: age);
    }
  }

  void selectAvatar(String avatarId) {
    state = state.copyWith(selectedAvatarId: avatarId);
  }

  Future<bool> completeOnboarding() async {
    if (!state.isProfileValid) return false;

    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final token = await _tokenStorage?.getAccessToken();
      KidProfile profile;

      if (token != null && token.isNotEmpty && _authRepository != null) {
        // Đã đăng nhập -> Lưu lên Backend Database
        profile = await _authRepository!.createOrUpdateKidProfile(
          nickname: state.nickname.trim(),
          age: state.selectedAge,
          mascotId: state.selectedAvatarId,
        );
      } else {
        // Chế độ Khách (Guest) -> Lưu Local
        profile = KidProfile(
          id: 'kid_${DateTime.now().millisecondsSinceEpoch}',
          nickname: state.nickname.trim(),
          age: state.selectedAge,
          avatarId: state.selectedAvatarId,
          currentStars: 10,
          currentStreak: 1,
        );
        await _repository.saveKidProfile(profile);
        await _repository.setCompletedOnboarding(true);
        await _tokenStorage?.setGuestMode(true);
      }

      state = state.copyWith(
        isLoading: false,
        isCompleted: true,
        profile: profile,
      );
      return true;
    } catch (e) {
      debugPrint('[ONBOARDING-ERR] $e');
      state = state.copyWith(
        isLoading: false,
        errorMessage:
            e is ApiException ? e.message : AppStrings.saveKidProfileFailed,
      );
      return false;
    }
  }
}

final onboardingControllerProvider =
    StateNotifierProvider<OnboardingController, OnboardingState>((ref) {
  final repo = ref.watch(onboardingRepositoryProvider);
  final authRepo = ref.watch(authRepositoryProvider);
  final tokenStorage = ref.watch(tokenStorageProvider);
  final localDataSource = ref.watch(onboardingLocalDataSourceProvider);
  final isCompleted = localDataSource.hasCompletedOnboarding;
  final profile = localDataSource.getKidProfile();

  return OnboardingController(
    repo,
    authRepo,
    tokenStorage,
    OnboardingState(
      isCompleted: isCompleted,
      profile: profile,
      nickname: profile?.nickname ?? '',
      selectedAge: profile?.age ?? 8,
      selectedAvatarId: profile?.avatarId ?? 'lion',
    ),
  );
});


