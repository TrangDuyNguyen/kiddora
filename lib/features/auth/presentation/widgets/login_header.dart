import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
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
              size: 44,
              backgroundColor: Colors.white,
              glowColor: Colors.black.withValues(alpha: 0.04),
              onPressed: () {
                if (context.router.canPop()) {
                  context.router.maybePop();
                } else {
                  context.router.replace(const HomeRoute());
                }
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const SizedBox(height: AppValues.space4),

          // Kiddora Logo & Tagline
          Image.asset(
            'assets/images/kiddora_logo.png',
            height: 48,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 2),
          Text(
            'Learn • Play • Achieve',
            style: GoogleFonts.quicksand(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF6E6D7A),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: AppValues.space5),

          // Main Title & Subtitle
          Text(
            'Welcome Back!',
            style: GoogleFonts.quicksand(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF1E1B4B),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Let's continue your learning journey",
            style: GoogleFonts.quicksand(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF6E6D7A),
            ),
          ),
          const SizedBox(height: AppValues.space4),

          // 3D Mascot Boy Waving + Star
          SizedBox(
            height: 145,
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
