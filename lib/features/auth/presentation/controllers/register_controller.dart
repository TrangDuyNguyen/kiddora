import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_values.dart';

class RegisterState {
  final String fullName;
  final String email;
  final String password;
  final String confirmPassword;
  final bool agreeTerms;
  final bool isObscuredPassword;
  final bool isObscuredConfirmPassword;
  final bool isLoading;
  final String? errorMessage;

  const RegisterState({
    this.fullName = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.agreeTerms = false,
    this.isObscuredPassword = true,
    this.isObscuredConfirmPassword = true,
    this.isLoading = false,
    this.errorMessage,
  });

  RegisterState copyWith({
    String? fullName,
    String? email,
    String? password,
    String? confirmPassword,
    bool? agreeTerms,
    bool? isObscuredPassword,
    bool? isObscuredConfirmPassword,
    bool? isLoading,
    String? errorMessage,
  }) {
    return RegisterState(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      agreeTerms: agreeTerms ?? this.agreeTerms,
      isObscuredPassword: isObscuredPassword ?? this.isObscuredPassword,
      isObscuredConfirmPassword:
          isObscuredConfirmPassword ?? this.isObscuredConfirmPassword,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class RegisterController extends StateNotifier<RegisterState> {
  RegisterController() : super(const RegisterState());

  void updateFullName(String fullName) {
    state = state.copyWith(fullName: fullName, errorMessage: null);
  }

  void updateEmail(String email) {
    state = state.copyWith(email: email, errorMessage: null);
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password, errorMessage: null);
  }

  void updateConfirmPassword(String confirmPassword) {
    state = state.copyWith(confirmPassword: confirmPassword, errorMessage: null);
  }

  void toggleAgreeTerms() {
    state = state.copyWith(
      agreeTerms: !state.agreeTerms,
      errorMessage: null,
    );
  }

  void toggleObscuredPassword() {
    state = state.copyWith(isObscuredPassword: !state.isObscuredPassword);
  }

  void toggleObscuredConfirmPassword() {
    state = state.copyWith(
      isObscuredConfirmPassword: !state.isObscuredConfirmPassword,
    );
  }

  Future<bool> register() async {
    if (state.fullName.trim().isEmpty ||
        state.email.trim().isEmpty ||
        state.password.trim().isEmpty) {
      state = state.copyWith(errorMessage: AppStrings.pleaseFillAllFields);
      return false;
    }

    if (state.password != state.confirmPassword) {
      state = state.copyWith(errorMessage: AppStrings.passwordsDoNotMatch);
      return false;
    }

    if (!state.agreeTerms) {
      state = state.copyWith(errorMessage: AppStrings.mustAgreeTerms);
      return false;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);
    await Future.delayed(AppValues.durationPageTransition);
    state = state.copyWith(isLoading: false);
    return true;
  }
}

final registerControllerProvider =
    StateNotifierProvider<RegisterController, RegisterState>((ref) {
  return RegisterController();
});
