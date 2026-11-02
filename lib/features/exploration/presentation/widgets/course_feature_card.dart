import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_values.dart';

class CourseFeatureCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;

  const CourseFeatureCard({
    super.key,
    required this.title,
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppValues.radiusCardLg),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: AppValues.space4,
        horizontal: AppValues.space2,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: AppValues.iconSizeLg,
            color: iconColor,
          ),
          const SizedBox(height: AppValues.space2),
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.quicksand(
              fontSize: AppValues.fontCaptionSm,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              height: AppValues.lineHeightCompact,
            ),
          ),
        ],
      ),
    );
  }
}

