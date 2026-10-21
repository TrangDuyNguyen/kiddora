import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kiddora/features/onboarding/data/datasources/onboarding_local_datasource.dart';
import 'package:kiddora/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:kiddora/features/onboarding/presentation/controllers/onboarding_controller.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SharedPreferences prefs;
  late OnboardingLocalDataSource dataSource;
  late OnboardingRepositoryImpl repository;
  late OnboardingController controller;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    dataSource = OnboardingLocalDataSource(prefs);
    repository = OnboardingRepositoryImpl(dataSource);
    controller = OnboardingController(repository);
  });

  group('OnboardingController Tests', () {
    test('Initial state is slide 0, age 8, avatar lion, empty nickname', () {
      expect(controller.state.currentSlideIndex, equals(0));
      expect(controller.state.selectedAge, equals(8));
      expect(controller.state.selectedAvatarId, equals('lion'));
      expect(controller.state.nickname, isEmpty);
      expect(controller.state.isProfileValid, isFalse);
    });

    test('Can update slide index within bounds [0, 2]', () {
      controller.setSlideIndex(1);
      expect(controller.state.currentSlideIndex, equals(1));

      controller.setSlideIndex(2);
      expect(controller.state.currentSlideIndex, equals(2));

      // Out of bounds should be ignored
      controller.setSlideIndex(3);
      expect(controller.state.currentSlideIndex, equals(2));
      controller.setSlideIndex(-1);
      expect(controller.state.currentSlideIndex, equals(2));
    });

    test('Validates nickname properly', () {
      controller.updateNickname('A');
      expect(controller.state.isProfileValid, isFalse);

      controller.updateNickname('Alex');
      expect(controller.state.isProfileValid, isTrue);

      controller.updateNickname('   ');
      expect(controller.state.isProfileValid, isFalse);
    });

    test('Can select age within [7, 10]', () {
      controller.selectAge(9);
      expect(controller.state.selectedAge, equals(9));

      // Invalid age ignored
      controller.selectAge(15);
      expect(controller.state.selectedAge, equals(9));
    });

    test('Can select avatar', () {
      controller.selectAvatar('dino');
      expect(controller.state.selectedAvatarId, equals('dino'));
    });

    test('completeOnboarding fails if profile invalid', () async {
      final success = await controller.completeOnboarding();
      expect(success, isFalse);
      expect(controller.state.isCompleted, isFalse);
    });

    test('completeOnboarding succeeds with valid profile and persists', () async {
      controller.updateNickname('Alex');
      controller.selectAge(9);
      controller.selectAvatar('bear');

      final success = await controller.completeOnboarding();
      expect(success, isTrue);
      expect(controller.state.isCompleted, isTrue);
      expect(controller.state.profile, isNotNull);
      expect(controller.state.profile!.nickname, equals('Alex'));
      expect(controller.state.profile!.age, equals(9));
      expect(controller.state.profile!.avatarId, equals('bear'));

      // Check persistence in SharedPreferences
      expect(await repository.hasCompletedOnboarding(), isTrue);
      final saved = await repository.getKidProfile();
      expect(saved?.nickname, equals('Alex'));
    });
  });
}
