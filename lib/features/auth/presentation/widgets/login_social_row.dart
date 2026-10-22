import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_values.dart';

class LoginSocialRow extends StatelessWidget {
  final VoidCallback onSocialTap;

  const LoginSocialRow({
    super.key,
    required this.onSocialTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Divider "Or continue with"
        Row(
          children: [
            const Expanded(
              child: Divider(color: Color(0xFFE2E8F0), thickness: 1),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Text(
                'Or continue with',
                style: GoogleFonts.quicksand(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF94A3B8),
                ),
              ),
            ),
            const Expanded(
              child: Divider(color: Color(0xFFE2E8F0), thickness: 1),
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
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFFEA4335),
                ),
              ),
            ),
            const SizedBox(width: AppValues.space6),
            _buildSocialButton(
              onTap: onSocialTap,
              child: const Icon(
                Icons.apple_rounded,
                size: 26,
                color: Color(0xFF0F172A),
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
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
          boxShadow: [
            const BoxShadow(
              color: Colors.white,
              offset: Offset(-2, -2),
              blurRadius: 3,
            ),
            BoxShadow(
              color: const Color(0xFF0F172A).withValues(alpha: 0.06),
              offset: const Offset(0, 3),
              blurRadius: 6,
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
      width: 18,
      height: 18,
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          ColoredBox(color: Color(0xFFF25022)),
          ColoredBox(color: Color(0xFF7FBA00)),
          ColoredBox(color: Color(0xFF00A4EF)),
          ColoredBox(color: Color(0xFFFFB900)),
        ],
      ),
    );
  }
}
