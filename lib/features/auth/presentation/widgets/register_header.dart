import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_values.dart';
import '../../../../core/router/app_router.gr.dart';
import '../../../../shared/ui_kit/ui_kit.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppValues.space7,
        AppValues.space4,
        AppValues.space7,
        0,
      ),
      child: Column(
        children: [
          // Top Action Bar: Back Button (Left) & Debug Onboarding Button (Right)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClayIconButton(
                size: AppValues.sizeCircleButtonXl,
                backgroundColor: Colors.white,
                glowColor: AppColors.clayShadeSubtle,
                onPressed: () {
                  context.router.maybePop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: AppValues.iconSizeSm,
                  color: AppColors.textPrimary,
                ),
              ),
              Tooltip(
                message: AppStrings.debugOnboarding,
                child: ClayIconButton(
                  size: AppValues.sizeCircleButtonXl,
                  backgroundColor: Colors.white,
                  glowColor: AppColors.clayShadeSubtle,
                  onPressed: () {
                    context.router.push(OnboardingRoute());
                  },
                  icon: const Icon(
                    Icons.auto_stories_rounded,
                    size: AppValues.iconSizeMd,
                    color: AppColors.brandIndigoLight,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppValues.space4),

          // Kiddora Logo & Tagline
          Image.asset(
            'assets/images/kiddora_logo.png',
            height: AppValues.sizeLoginLogoH,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: AppValues.borderWidthThick),
          Text(
            AppStrings.learnPlayAchieve,
            style: GoogleFonts.quicksand(
              fontSize: AppValues.fontBodySm,
              fontWeight: FontWeight.w600,
              color: AppColors.textSlate,
              letterSpacing: AppValues.letterSpacingWide,
            ),
          ),
          const SizedBox(height: AppValues.space5),

          // Main Title & Subtitle
          Text(
            AppStrings.createAccount,
            style: GoogleFonts.quicksand(
              fontSize: AppValues.fontDisplayHero,
              fontWeight: FontWeight.w800,
              color: AppColors.textDarkIndigo,
            ),
          ),
          const SizedBox(height: AppValues.radiusXs),
          Text(
            AppStrings.createAccountSubtitle,
            style: GoogleFonts.quicksand(
              fontSize: AppValues.fontBodyMd,
              fontWeight: FontWeight.w500,
              color: AppColors.textSlate,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppValues.space4),

          // 3D Mascot Boy with Book & Fist Pump
          Transform.translate(
            offset: const Offset(0, AppValues.space5),
            child: SizedBox(
              height: AppValues.sizeLoginHeroMascotH,
              child: Image.asset(
                'assets/images/mascot_boy_register.png',
                fit: BoxFit.contain,
                alignment: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
