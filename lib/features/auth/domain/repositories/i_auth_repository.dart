import '../models/auth_models.dart';
import 'package:kiddora/features/onboarding/domain/models/kid_profile.dart';



abstract class IAuthRepository {
  Future<AuthSession> register({
    required String email,
    required String password,
    String? fullName,
  });

  Future<AuthSession> login({
    required String email,
    required String password,
  });

  Future<KidProfile> createOrUpdateKidProfile({
    required String nickname,
    required int age,
    required String mascotId,
  });

  Future<AuthSession?> getCurrentSession();

  Future<void> logout();
}
