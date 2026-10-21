import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kiddora/features/onboarding/data/datasources/onboarding_local_datasource.dart';
import 'package:kiddora/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:kiddora/features/onboarding/domain/models/kid_profile.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SharedPreferences prefs;
  late OnboardingLocalDataSource dataSource;
  late OnboardingRepositoryImpl repository;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    dataSource = OnboardingLocalDataSource(prefs);
    repository = OnboardingRepositoryImpl(dataSource);
  });

  group('OnboardingRepositoryImpl Tests', () {
    test('Initial onboarding status is false', () async {
      final status = await repository.hasCompletedOnboarding();
      expect(status, isFalse);
    });

    test('Can save and retrieve completed onboarding status', () async {
      await repository.setCompletedOnboarding(true);
      final status = await repository.hasCompletedOnboarding();
      expect(status, isTrue);
    });

    test('Initial kid profile is null', () async {
      final profile = await repository.getKidProfile();
      expect(profile, isNull);
    });

    test('Can save and retrieve KidProfile correctly', () async {
      final profile = KidProfile(
        id: 'kid_test_1',
        nickname: 'Alex Bo',
        age: 8,
        avatarId: 'lion',
        currentStars: 25,
        currentStreak: 3,
      );

      await repository.saveKidProfile(profile);
      final retrieved = await repository.getKidProfile();

      expect(retrieved, isNotNull);
      expect(retrieved!.id, equals('kid_test_1'));
      expect(retrieved.nickname, equals('Alex Bo'));
      expect(retrieved.age, equals(8));
      expect(retrieved.avatarId, equals('lion'));
      expect(retrieved.currentStars, equals(25));
      expect(retrieved.currentStreak, equals(3));
    });

    test('Can clear onboarding data', () async {
      await repository.setCompletedOnboarding(true);
      await repository.saveKidProfile(KidProfile(
        id: 'k1',
        nickname: 'Test',
        age: 7,
        avatarId: 'bear',
      ));

      await repository.clearOnboardingData();

      expect(await repository.hasCompletedOnboarding(), isFalse);
      expect(await repository.getKidProfile(), isNull);
    });
  });
}
