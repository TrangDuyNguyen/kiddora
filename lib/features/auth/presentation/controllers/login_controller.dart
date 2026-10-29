import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/network/api_client.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/i_auth_repository.dart';

class LoginState {
  final String email;
  final String password;
  final bool rememberMe;
  final bool isObscured;
  final bool isLoading;
  final String? errorMessage;

  const LoginState({
    this.email = 'parent@kiddora.com',
    this.password = 'Password123!',
    this.rememberMe = true,
    this.isObscured = true,
    this.isLoading = false,
    this.errorMessage,
  });

  LoginState copyWith({
    String? email,
    String? password,
    bool? rememberMe,
    bool? isObscured,
    bool? isLoading,
    String? errorMessage,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      rememberMe: rememberMe ?? this.rememberMe,
      isObscured: isObscured ?? this.isObscured,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class LoginController extends StateNotifier<LoginState> {
  final IAuthRepository _authRepository;

  LoginController(this._authRepository) : super(const LoginState());

  void updateEmail(String email) {
    state = state.copyWith(email: email, errorMessage: null);
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password, errorMessage: null);
  }

  void toggleRememberMe() {
    state = state.copyWith(rememberMe: !state.rememberMe);
  }

  void toggleObscured() {
    state = state.copyWith(isObscured: !state.isObscured);
  }

  Future<bool> login() async {
    if (state.email.trim().isEmpty || state.password.trim().isEmpty) {
      state = state.copyWith(errorMessage: AppStrings.loginEmptyFields);
      return false;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await _authRepository.login(
        email: state.email.trim(),
        password: state.password,
      );
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      debugPrint('[LOGIN-ERR] $e');
      final msg = e is ApiException ? e.message : AppStrings.loginFailed;
      state = state.copyWith(isLoading: false, errorMessage: msg);
      return false;
    }
  }
}

final loginControllerProvider =
    StateNotifierProvider<LoginController, LoginState>((ref) {
  final repo = ref.watch(authRepositoryProvider);
  return LoginController(repo);
});
