import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_values.dart';
import '../../../core/router/app_router.gr.dart';
import '../../../shared/ui_kit/ui_kit.dart';
import 'controllers/register_controller.dart';
import 'widgets/login_social_row.dart';
import 'widgets/register_header.dart';

@RoutePage()
class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    final state = ref.read(registerControllerProvider);
    _nameController = TextEditingController(text: state.fullName);
    _emailController = TextEditingController(text: state.email);
    _passwordController = TextEditingController(text: state.password);
    _confirmPasswordController =
        TextEditingController(text: state.confirmPassword);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    HapticFeedback.mediumImpact();
    final success =
        await ref.read(registerControllerProvider.notifier).register();
    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppStrings.registerSuccessAlert,
            style: GoogleFonts.quicksand(
              fontWeight: FontWeight.w600,
              fontSize: AppValues.fontBodyMd,
            ),
          ),
          backgroundColor: AppColors.stateSuccessGreen,
          behavior: SnackBarBehavior.floating,
        ),
      );
      context.router.replace(const HomeRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(registerControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.surfaceLoginCanvas,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Mascot Header
              const RegisterHeader(),

              // White Porcelain Bottom Clay Sheet
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(AppValues.radiusSheetTop),
                    topRight: Radius.circular(AppValues.radiusSheetTop),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadowIndigoSubtle,
                      offset: const Offset(0, -6),
                      blurRadius: AppValues.radiusXl,
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppValues.space7,
                  vertical: AppValues.space8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Full Name Field
                    ClayTextField(
                      controller: _nameController,
                      hintText: AppStrings.fullName,
                      prefixIcon: const Icon(
                        Icons.person_outline_rounded,
                        color: AppColors.brandPrimary,
                        size: AppValues.iconSizeXl,
                      ),
                      onChanged: (val) => ref
                          .read(registerControllerProvider.notifier)
                          .updateFullName(val),
                    ),
                    const SizedBox(height: AppValues.space5),

                    // Email Field
                    ClayTextField(
                      controller: _emailController,
                      hintText: AppStrings.emailAddress,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: const Icon(
                        Icons.mail_outline_rounded,
                        color: AppColors.brandPrimary,
                        size: AppValues.iconSizeXl,
                      ),
                      onChanged: (val) => ref
                          .read(registerControllerProvider.notifier)
                          .updateEmail(val),
                    ),
                    const SizedBox(height: AppValues.space5),

                    // Password Field
                    ClayTextField(
                      controller: _passwordController,
                      hintText: AppStrings.password,
                      obscureText: state.isObscuredPassword,
                      prefixIcon: const Icon(
                        Icons.lock_outline_rounded,
                        color: AppColors.brandPrimary,
                        size: AppValues.iconSizeXl,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          HapticFeedback.selectionClick();
                          ref
                              .read(registerControllerProvider.notifier)
                              .toggleObscuredPassword();
                        },
                        child: Icon(
                          state.isObscuredPassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: AppColors.textMuted,
                          size: AppValues.iconSizeMd,
                        ),
                      ),
                      onChanged: (val) => ref
                          .read(registerControllerProvider.notifier)
                          .updatePassword(val),
                    ),
                    const SizedBox(height: AppValues.space5),

                    // Confirm Password Field
                    ClayTextField(
                      controller: _confirmPasswordController,
                      hintText: AppStrings.confirmPassword,
                      obscureText: state.isObscuredConfirmPassword,
                      prefixIcon: const Icon(
                        Icons.lock_reset_rounded,
                        color: AppColors.brandPrimary,
                        size: AppValues.iconSizeXl,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          HapticFeedback.selectionClick();
                          ref
                              .read(registerControllerProvider.notifier)
                              .toggleObscuredConfirmPassword();
                        },
                        child: Icon(
                          state.isObscuredConfirmPassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: AppColors.textMuted,
                          size: AppValues.iconSizeMd,
                        ),
                      ),
                      onChanged: (val) => ref
                          .read(registerControllerProvider.notifier)
                          .updateConfirmPassword(val),
                    ),
                    const SizedBox(height: AppValues.space5),

                    // Terms & Privacy Checkbox
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.selectionClick();
                        ref
                            .read(registerControllerProvider.notifier)
                            .toggleAgreeTerms();
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AnimatedContainer(
                            duration: AppValues.durationFeedback,
                            width: AppValues.sizeCheckbox,
                            height: AppValues.sizeCheckbox,
                            decoration: BoxDecoration(
                              color: state.agreeTerms
                                  ? AppColors.brandPrimary
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(
                                AppValues.radiusCheckbox,
                              ),
                              border: Border.all(
                                color: state.agreeTerms
                                    ? AppColors.brandPrimary
                                    : AppColors.borderSubtle,
                                width: AppValues.borderWidthHairline,
                              ),
                              boxShadow: [
                                if (state.agreeTerms)
                                  BoxShadow(
                                    color: AppColors.brandPrimary
                                        .withValues(alpha: 0.3),
                                    blurRadius: AppValues.radiusXs,
                                    offset: const Offset(0, 2),
                                  ),
                              ],
                            ),
                            child: state.agreeTerms
                                ? const Icon(
                                    Icons.check_rounded,
                                    size: AppValues.iconSizeCompact,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                          const SizedBox(width: AppValues.space4),
                          Expanded(
                            child: Text(
                              AppStrings.agreeTerms,
                              style: GoogleFonts.quicksand(
                                fontSize: AppValues.fontBodySm,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textSlateDark,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Error Message
                    if (state.errorMessage != null) ...[
                      const SizedBox(height: AppValues.space4),
                      Text(
                        state.errorMessage!,
                        style: GoogleFonts.quicksand(
                          fontSize: AppValues.fontLabelMd,
                          fontWeight: FontWeight.w600,
                          color: AppColors.feedbackError,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],

                    const SizedBox(height: AppValues.space8),

                    // Sign Up Primary Tactile Button
                    ClayButton(
                      label: AppStrings.signUp,
                      onPressed: state.isLoading ? null : _handleRegister,
                      isLoading: state.isLoading,
                      icon: const Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                        size: AppValues.iconSizeMd,
                      ),
                      backgroundColor: AppColors.brandPrimary,
                      height: AppValues.sizeButtonPrimaryH,
                    ),
                    const SizedBox(height: AppValues.space7),

                    // Social Auth Row
                    LoginSocialRow(
                      label: AppStrings.orSignUpWith,
                      onSocialTap: _handleRegister,
                    ),
                    const SizedBox(height: AppValues.space7),

                    // Bottom Log In Text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.alreadyHaveAccount,
                          style: GoogleFonts.quicksand(
                            fontSize: AppValues.fontBodyMd,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSlate,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            HapticFeedback.lightImpact();
                            context.router.replace(const LoginRoute());
                          },
                          child: Text(
                            AppStrings.logIn,
                            style: GoogleFonts.quicksand(
                              fontSize: AppValues.fontBodyMd,
                              fontWeight: FontWeight.w700,
                              color: AppColors.brandPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppValues.space7),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
