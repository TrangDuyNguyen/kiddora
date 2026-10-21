import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/models/kid_profile.dart';

class OnboardingLocalDataSource {
  const OnboardingLocalDataSource(this._prefs);

  final SharedPreferences _prefs;

  static const String _keyCompletedOnboarding = 'has_completed_onboarding';
  static const String _keyKidProfile = 'kiddora_kid_profile';

  bool get hasCompletedOnboarding =>
      _prefs.getBool(_keyCompletedOnboarding) ?? false;

  Future<void> setCompletedOnboarding(bool completed) async {
    await _prefs.setBool(_keyCompletedOnboarding, completed);
  }

  KidProfile? getKidProfile() {
    final rawJson = _prefs.getString(_keyKidProfile);
    if (rawJson == null || rawJson.isEmpty) return null;
    try {
      return KidProfile.fromJson(rawJson);
    } catch (_) {
      return null;
    }
  }

  Future<void> saveKidProfile(KidProfile profile) async {
    await _prefs.setString(_keyKidProfile, profile.toJson());
  }

  Future<void> clear() async {
    await _prefs.remove(_keyCompletedOnboarding);
    await _prefs.remove(_keyKidProfile);
  }
}
