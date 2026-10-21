import '../../domain/models/kid_profile.dart';
import '../../domain/repositories/i_onboarding_repository.dart';
import '../datasources/onboarding_local_datasource.dart';

class OnboardingRepositoryImpl implements IOnboardingRepository {
  const OnboardingRepositoryImpl(this._localDataSource);

  final OnboardingLocalDataSource _localDataSource;

  @override
  Future<bool> hasCompletedOnboarding() async {
    return _localDataSource.hasCompletedOnboarding;
  }

  @override
  Future<void> setCompletedOnboarding(bool completed) async {
    await _localDataSource.setCompletedOnboarding(completed);
  }

  @override
  Future<KidProfile?> getKidProfile() async {
    return _localDataSource.getKidProfile();
  }

  @override
  Future<void> saveKidProfile(KidProfile profile) async {
    await _localDataSource.saveKidProfile(profile);
  }

  @override
  Future<void> clearOnboardingData() async {
    await _localDataSource.clear();
  }
}
