import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/token_storage.dart';
import '../../../onboarding/data/datasources/onboarding_local_datasource.dart';
import '../../../onboarding/domain/models/kid_profile.dart';
import '../../../onboarding/presentation/controllers/onboarding_controller.dart';
import '../../domain/models/auth_models.dart';
import '../../domain/repositories/i_auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements IAuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final TokenStorage _tokenStorage;
  final OnboardingLocalDataSource _localDataSource;

  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required TokenStorage tokenStorage,
    required OnboardingLocalDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _tokenStorage = tokenStorage,
        _localDataSource = localDataSource;

  @override
  Future<AuthSession> register({
    required String email,
    required String password,
    String? fullName,
  }) async {
    final session = await _remoteDataSource.register(
      email: email,
      password: password,
      fullName: fullName,
    );

    await _tokenStorage.saveTokens(
      accessToken: session.accessToken,
      refreshToken: session.refreshToken,
    );

    return session;
  }

  @override
  Future<AuthSession> login({
    required String email,
    required String password,
  }) async {
    final session = await _remoteDataSource.login(
      email: email,
      password: password,
    );

    await _tokenStorage.saveTokens(
      accessToken: session.accessToken,
      refreshToken: session.refreshToken,
    );

    if (session.kidProfile != null) {
      await _localDataSource.saveKidProfile(session.kidProfile!);
      await _localDataSource.setCompletedOnboarding(true);
    }

    return session;
  }

  @override
  Future<KidProfile> createOrUpdateKidProfile({
    required String nickname,
    required int age,
    required String mascotId,
  }) async {
    final profile = await _remoteDataSource.createOrUpdateKidProfile(
      nickname: nickname,
      age: age,
      mascotId: mascotId,
    );

    await _localDataSource.saveKidProfile(profile);
    await _localDataSource.setCompletedOnboarding(true);
    return profile;
  }

  @override
  Future<AuthSession?> getCurrentSession() async {
    final access = await _tokenStorage.getAccessToken();
    final refresh = await _tokenStorage.getRefreshToken();
    if (access == null || refresh == null) {
      return null;
    }

    final session = await _remoteDataSource.getMe(access, refresh);
    if (session != null && session.kidProfile != null) {
      await _localDataSource.saveKidProfile(session.kidProfile!);
    }
    return session;
  }

  @override
  Future<void> logout() async {
    await _tokenStorage.clearTokens();
    await _localDataSource.clear();
  }

}

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  final client = ref.watch(apiClientProvider);
  return AuthRemoteDataSource(client);
});

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  final remote = ref.watch(authRemoteDataSourceProvider);
  final tokenStorage = ref.watch(tokenStorageProvider);
  final local = ref.watch(onboardingLocalDataSourceProvider);

  return AuthRepositoryImpl(
    remoteDataSource: remote,
    tokenStorage: tokenStorage,
    localDataSource: local,
  );
});
