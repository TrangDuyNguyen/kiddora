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
import '../../onboarding/presentation/widgets/onboarding_pastel_blobs.dart';
import 'controllers/login_controller.dart';
import 'widgets/login_header.dart';

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
      backgroundColor: AppColors.surface,
      body: Stack(
        children: [
          // Ambient Pastel Blobs
          const OnboardingPastelBlobs(),

          // Main Interactive Content
          SafeArea(
            bottom: false,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Header & 3D Mascot Section
                          const LoginHeader(),

                          // White Porcelain Clay Wave Bottom Sheet
                          Expanded(
                            child: ClayWaveSheet(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  // Email or Username Input
                                  ClayTextField(
                                    controller: _emailController,
                                    hintText: AppStrings.emailOrUsername,
                                    prefixIcon: const Icon(
                                      Icons.mail_outline_rounded,
                                      color: AppColors.brandIndigoLight,
                                      size: AppValues.iconSizeXl,
                                    ),
                                    onChanged: (val) => ref
                                        .read(loginControllerProvider.notifier)
                                        .updateEmail(val),
                                  ),
                                  const SizedBox(height: AppValues.space6),

                                  // Password Input with Visibility Toggle
                                  ClayTextField(
                                    controller: _passwordController,
                                    hintText: AppStrings.password,
                                    obscureText: state.isObscured,
                                    prefixIcon: const Icon(
                                      Icons.lock_outline_rounded,
                                      color: AppColors.brandIndigoLight,
                                      size: AppValues.iconSizeXl,
                                    ),
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        HapticFeedback.selectionClick();
                                        ref
                                            .read(loginControllerProvider
                                                .notifier)
                                            .toggleObscured();
                                      },
                                      child: Icon(
                                        state.isObscured
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: AppColors.textMuted,
                                        size: AppValues.iconSizeMd,
                                      ),
                                    ),
                                    onChanged: (val) => ref
                                        .read(loginControllerProvider.notifier)
                                        .updatePassword(val),
                                  ),
                                  const SizedBox(height: AppValues.space5),

                                  // Remember Me & Forgot Password Row
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: GestureDetector(
                                          onTap: () {
                                            HapticFeedback.selectionClick();
                                            ref
                                                .read(loginControllerProvider
                                                    .notifier)
                                                .toggleRememberMe();
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              AnimatedContainer(
                                                duration:
                                                    AppValues.durationFeedback,
                                                width: AppValues.sizeCheckbox,
                                                height: AppValues.sizeCheckbox,
                                                decoration: BoxDecoration(
                                                  color: state.rememberMe
                                                      ? AppColors.brandIndigoLight
                                                      : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    AppValues.radiusCheckbox,
                                                  ),
                                                  border: Border.all(
                                                    color: state.rememberMe
                                                        ? AppColors
                                                            .brandIndigoLight
                                                        : AppColors.borderSubtle,
                                                    width: AppValues
                                                        .borderWidthHairline,
                                                  ),
                                                  boxShadow: [
                                                    if (state.rememberMe)
                                                      BoxShadow(
                                                        color: AppColors
                                                            .brandIndigoLight
                                                            .withValues(
                                                                alpha: 0.3),
                                                        blurRadius:
                                                            AppValues.radiusXs,
                                                        offset:
                                                            const Offset(0, 2),
                                                      ),
                                                  ],
                                                ),
                                                child: state.rememberMe
                                                    ? const Icon(
                                                        Icons.check_rounded,
                                                        size: AppValues
                                                            .iconSizeCompact,
                                                        color: Colors.white,
                                                      )
                                                    : null,
                                              ),
                                              const SizedBox(
                                                  width: AppValues.space4),
                                              Flexible(
                                                child: Text(
                                                  AppStrings.rememberMe,
                                                  style: GoogleFonts.quicksand(
                                                    fontSize:
                                                        AppValues.fontLabelMd,
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        AppColors.textSlateDark,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          HapticFeedback.lightImpact();
                                        },
                                        style: TextButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          minimumSize: Size.zero,
                                          tapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                        ),
                                        child: Text(
                                          AppStrings.forgotPassword,
                                          style: GoogleFonts.quicksand(
                                            fontSize: AppValues.fontLabelMd,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.brandIndigoLight,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  ClayErrorText(state.errorMessage),
                                  const SizedBox(height: AppValues.space7),

                                  // Log In Primary Tactile Button with Trailing Arrow
                                  ClayButton(
                                    label: AppStrings.logIn,
                                    onPressed:
                                        state.isLoading ? null : _handleLogin,
                                    isLoading: state.isLoading,
                                    trailingIcon: const Icon(
                                      Icons.arrow_forward_rounded,
                                      color: Colors.white,
                                      size: AppValues.iconSizeLg,
                                    ),
                                    customGradient: const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        AppColors.buttonGradientStart,
                                        AppColors.buttonGradientEnd,
                                      ],
                                    ),
                                    height: AppValues.sizeButtonPrimaryH,
                                  ),
                                  const SizedBox(height: AppValues.space7),

                                  // Bottom Sign Up Text with Wrap
                                  Wrap(
                                    alignment: WrapAlignment.center,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      Text(
                                        AppStrings.dontHaveAccount,
                                        style: GoogleFonts.quicksand(
                                          fontSize: AppValues.fontBodyMd,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.textSlate,
                                        ),
                                      ),
                                      const SizedBox(width: AppValues.space2),
                                      GestureDetector(
                                        onTap: () {
                                          HapticFeedback.lightImpact();
                                          context.router
                                              .push(const RegisterRoute());
                                        },
                                        child: Text(
                                          AppStrings.signUp,
                                          style: GoogleFonts.quicksand(
                                            fontSize: AppValues.fontBodyMd,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.brandIndigoLight,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: AppValues.space7),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
