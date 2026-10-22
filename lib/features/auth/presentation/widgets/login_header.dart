import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_values.dart';
import '../../../../core/router/app_router.gr.dart';
import '../../../../shared/ui_kit/ui_kit.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppValues.space7,
        vertical: AppValues.space4,
      ),
      child: Column(
        children: [
          // Top Back Button
          Align(
            alignment: Alignment.centerLeft,
            child: ClayIconButton(
              size: AppValues.sizeCircleButtonXl,
              backgroundColor: Colors.white,
              glowColor: AppColors.clayShadeSubtle,
              onPressed: () {
                if (context.router.canPop()) {
                  context.router.maybePop();
                } else {
                  context.router.replace(const HomeRoute());
                }
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: AppValues.iconSizeSm,
                color: AppColors.textPrimary,
              ),
            ),
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
            AppStrings.welcomeBack,
            style: GoogleFonts.quicksand(
              fontSize: AppValues.fontDisplayHero,
              fontWeight: FontWeight.w800,
              color: AppColors.textDarkIndigo,
            ),
          ),
          const SizedBox(height: AppValues.radiusXs),
          Text(
            AppStrings.welcomeBackSubtitle,
            style: GoogleFonts.quicksand(
              fontSize: AppValues.fontBodyMd,
              fontWeight: FontWeight.w500,
              color: AppColors.textSlate,
            ),
          ),
          const SizedBox(height: AppValues.space4),

          // 3D Mascot Boy Waving + Star
          SizedBox(
            height: AppValues.sizeLoginHeroMascotH,
            child: Image.asset(
              'assets/images/login_hero_mascot.png',
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
