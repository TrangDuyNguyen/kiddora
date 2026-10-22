import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_values.dart';

class LoginSocialRow extends StatelessWidget {
  final VoidCallback onSocialTap;
  final String label;

  const LoginSocialRow({
    super.key,
    required this.onSocialTap,
    this.label = AppStrings.orContinueWith,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Divider "Or continue with" / "Or sign up with"
        Row(
          children: [
            const Expanded(
              child: Divider(
                color: AppColors.borderLight,
                thickness: AppValues.borderWidthThin,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppValues.space6,
              ),
              child: Text(
                label,
                style: GoogleFonts.quicksand(
                  fontSize: AppValues.fontLabelMd,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textMuted,
                ),
              ),
            ),
            const Expanded(
              child: Divider(
                color: AppColors.borderLight,
                thickness: AppValues.borderWidthThin,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppValues.space6),

        // Social Round Buttons (Google, Apple, Microsoft)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialButton(
              onTap: onSocialTap,
              child: const Text(
                'G',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: AppValues.fontSocialG,
                  fontWeight: FontWeight.w800,
                  color: AppColors.socialGoogleRed,
                ),
              ),
            ),
            const SizedBox(width: AppValues.space6),
            _buildSocialButton(
              onTap: onSocialTap,
              child: const Icon(
                Icons.apple_rounded,
                size: AppValues.iconSizeSocial,
                color: AppColors.socialAppleDark,
              ),
            ),
            const SizedBox(width: AppValues.space6),
            _buildSocialButton(
              onTap: onSocialTap,
              child: _buildMicrosoftLogo(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required VoidCallback onTap,
    required Widget child,
  }) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      child: Container(
        width: AppValues.sizeSocialButton,
        height: AppValues.sizeSocialButton,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(
            color: AppColors.borderLight,
            width: AppValues.borderWidthHairline,
          ),
          boxShadow: [
            const BoxShadow(
              color: Colors.white,
              offset: Offset(-2, -2),
              blurRadius: AppValues.radiusXs,
            ),
            BoxShadow(
              color: AppColors.clayShadeSubtle,
              offset: const Offset(0, 3),
              blurRadius: AppValues.radiusSm,
            ),
          ],
        ),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }

  Widget _buildMicrosoftLogo() {
    return SizedBox(
      width: AppValues.sizeMsLogoBox,
      height: AppValues.sizeMsLogoBox,
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: AppValues.borderWidthThick,
        crossAxisSpacing: AppValues.borderWidthThick,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          ColoredBox(color: AppColors.socialMsOrange),
          ColoredBox(color: AppColors.socialMsGreen),
          ColoredBox(color: AppColors.socialMsBlue),
          ColoredBox(color: AppColors.socialMsYellow),
        ],
      ),
    );
  }
}
