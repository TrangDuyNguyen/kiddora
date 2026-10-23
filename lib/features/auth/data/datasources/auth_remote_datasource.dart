import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';
import '../../domain/models/auth_models.dart';
import 'package:kiddora/features/onboarding/domain/models/kid_profile.dart';




class AuthRemoteDataSource {
  final ApiClient _client;

  AuthRemoteDataSource(this._client);

  Future<AuthSession> register({
    required String email,
    required String password,
    String? fullName,
  }) async {
    try {
      final res = await _client.dio.post(
        '/api/v1/auth/register',
        data: {
          'email': email.trim(),
          'password': password,
          'full_name': fullName?.trim(),
        },
      );
      return AuthSession.fromMap(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      if (e.error is ApiException) {
        throw e.error!;
      }
      throw ApiException('Không thể đăng ký tài khoản');
    }
  }

  Future<AuthSession> login({
    required String email,
    required String password,
  }) async {
    try {
      final res = await _client.dio.post(
        '/api/v1/auth/login',
        data: {
          'email': email.trim(),
          'password': password,
        },
      );
      return AuthSession.fromMap(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      if (e.error is ApiException) {
        throw e.error!;
      }
      throw ApiException('Đăng nhập thất bại');
    }
  }

  Future<KidProfile> createOrUpdateKidProfile({
    required String nickname,
    required int age,
    required String mascotId,
  }) async {
    try {
      final res = await _client.dio.post(
        '/api/v1/auth/kid-profile',
        data: {
          'nickname': nickname.trim(),
          'age': age,
          'mascot_id': mascotId,
        },
      );
      return KidProfile.fromMap(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      if (e.error is ApiException) {
        throw e.error!;
      }
      throw ApiException('Không thể lưu hồ sơ bé');
    }
  }

  Future<AuthSession?> getMe(String accessToken, String refreshToken) async {
    try {
      final res = await _client.dio.get('/api/v1/auth/me');
      final data = res.data as Map<String, dynamic>;
      final user = UserModel.fromMap(data['user'] as Map<String, dynamic>? ?? {});
      final kidProfile = data['kid_profile'] != null
          ? KidProfile.fromMap(data['kid_profile'] as Map<String, dynamic>)
          : null;

      return AuthSession(
        accessToken: accessToken,
        refreshToken: refreshToken,
        user: user,
        kidProfile: kidProfile,
      );
    } catch (_) {
      return null;
    }
  }
}
