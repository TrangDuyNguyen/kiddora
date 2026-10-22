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
              child: const SizedBox(
                width: AppValues.iconSizeLg,
                height: AppValues.iconSizeLg,
                child: CustomPaint(
                  painter: GoogleGLogoPainter(),
                ),
              ),
            ),
            const SizedBox(width: AppValues.space7),
            _buildSocialButton(
              onTap: onSocialTap,
              child: const Icon(
                Icons.apple_rounded,
                size: AppValues.fontHeadlineXl,
                color: AppColors.socialAppleDark,
              ),
            ),
            const SizedBox(width: AppValues.space7),
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
        width: AppValues.sizeSocialButtonLg,
        height: AppValues.sizeSocialButtonLg,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            const BoxShadow(
              color: Colors.white,
              offset: Offset(-2, -2),
              blurRadius: AppValues.radiusSm,
            ),
            BoxShadow(
              color: AppColors.clayShadeDeep.withValues(alpha: 0.08),
              offset: const Offset(0, 4),
              blurRadius: AppValues.radiusLg,
            ),
            BoxShadow(
              color: AppColors.clayShadeSubtle,
              offset: const Offset(0, 1),
              blurRadius: AppValues.radiusXs,
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

class GoogleGLogoPainter extends CustomPainter {
  const GoogleGLogoPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final strokeWidth = size.width * 0.22;
    final rect =
        Rect.fromCircle(center: center, radius: radius - strokeWidth / 2);

    final bluePaint = Paint()
      ..color = AppColors.socialGoogleBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final greenPaint = Paint()
      ..color = AppColors.socialGoogleGreen
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final yellowPaint = Paint()
      ..color = AppColors.socialGoogleYellow
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final redPaint = Paint()
      ..color = AppColors.socialGoogleRed
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    // Arcs
    canvas.drawArc(rect, -0.785, -1.57, false, redPaint);
    canvas.drawArc(rect, -2.356, -1.18, false, yellowPaint);
    canvas.drawArc(rect, 0.785, 1.57, false, greenPaint);
    canvas.drawArc(rect, 0.0, 0.785, false, bluePaint);

    // Crossbar for G
    final barPaint = Paint()
      ..color = AppColors.socialGoogleBlue
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromLTRB(center.dx - strokeWidth * 0.2, center.dy - strokeWidth / 2,
          center.dx + radius, center.dy + strokeWidth / 2),
      barPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
