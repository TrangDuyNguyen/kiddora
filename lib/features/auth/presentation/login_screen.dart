import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_values.dart';
import '../../../core/router/app_router.gr.dart';
import '../../../shared/ui_kit/ui_kit.dart';
import 'controllers/login_controller.dart';
import 'widgets/login_header.dart';
import 'widgets/login_social_row.dart';

@RoutePage()
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    final state = ref.read(loginControllerProvider);
    _emailController = TextEditingController(text: state.email);
    _passwordController = TextEditingController(text: state.password);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    HapticFeedback.mediumImpact();
    final success = await ref.read(loginControllerProvider.notifier).login();
    if (success && mounted) {
      context.router.replace(const HomeRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginControllerProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF3EEFC),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header & 3D Mascot Section
              const LoginHeader(),

              // White Porcelain Form Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppValues.space8,
                  vertical: AppValues.space8,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(36),
                    topRight: Radius.circular(36),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x0F4F46E5),
                      offset: Offset(0, -6),
                      blurRadius: 18,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Email or Username Input
                    ClayTextField(
                      controller: _emailController,
                      hintText: 'Email or Username',
                      prefixIcon: const Icon(
                        Icons.mail_outline_rounded,
                        color: AppColors.brandPrimary,
                        size: 22,
                      ),
                      onChanged: (val) => ref
                          .read(loginControllerProvider.notifier)
                          .updateEmail(val),
                    ),
                    const SizedBox(height: AppValues.space5),

                    // Password Input with Visibility Toggle
                    ClayTextField(
                      controller: _passwordController,
                      hintText: 'Password',
                      obscureText: state.isObscured,
                      prefixIcon: const Icon(
                        Icons.lock_outline_rounded,
                        color: AppColors.brandPrimary,
                        size: 22,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          HapticFeedback.selectionClick();
                          ref
                              .read(loginControllerProvider.notifier)
                              .toggleObscured();
                        },
                        child: Icon(
                          state.isObscured
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: const Color(0xFF94A3B8),
                          size: 20,
                        ),
                      ),
                      onChanged: (val) => ref
                          .read(loginControllerProvider.notifier)
                          .updatePassword(val),
                    ),
                    const SizedBox(height: AppValues.space5),

                    // Remember Me & Forgot Password Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            HapticFeedback.selectionClick();
                            ref
                                .read(loginControllerProvider.notifier)
                                .toggleRememberMe();
                          },
                          child: Row(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 150),
                                width: 22,
                                height: 22,
                                decoration: BoxDecoration(
                                  color: state.rememberMe
                                      ? AppColors.brandPrimary
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: state.rememberMe
                                        ? AppColors.brandPrimary
                                        : const Color(0xFFCBD5E1),
                                    width: 1.5,
                                  ),
                                  boxShadow: [
                                    if (state.rememberMe)
                                      BoxShadow(
                                        color: AppColors.brandPrimary
                                            .withValues(alpha: 0.3),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                  ],
                                ),
                                child: state.rememberMe
                                    ? const Icon(
                                        Icons.check_rounded,
                                        size: 16,
                                        color: Colors.white,
                                      )
                                    : null,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Remember me',
                                style: GoogleFonts.quicksand(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF475569),
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            HapticFeedback.lightImpact();
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            'Forgot Password?',
                            style: GoogleFonts.quicksand(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppColors.brandPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppValues.space7),

                    // Log In Primary Tactile Button
                    ClayButton(
                      label: 'Log In',
                      onPressed: state.isLoading ? null : _handleLogin,
                      isLoading: state.isLoading,
                      icon: const Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                      backgroundColor: AppColors.brandPrimary,
                      height: 54,
                    ),
                    const SizedBox(height: AppValues.space7),

                    // Social Auth Row
                    LoginSocialRow(onSocialTap: _handleLogin),
                    const SizedBox(height: AppValues.space7),

                    // Bottom Sign Up Text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: GoogleFonts.quicksand(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF6E6D7A),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            HapticFeedback.lightImpact();
                            context.router.replace(OnboardingRoute());
                          },
                          child: Text(
                            'Sign Up',
                            style: GoogleFonts.quicksand(
                              fontSize: 14,
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
