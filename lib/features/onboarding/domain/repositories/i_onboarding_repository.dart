import '../models/kid_profile.dart';

abstract class IOnboardingRepository {
  Future<bool> hasCompletedOnboarding();
  Future<void> setCompletedOnboarding(bool completed);
  Future<KidProfile?> getKidProfile();
  Future<void> saveKidProfile(KidProfile profile);
  Future<void> clearOnboardingData();
}
