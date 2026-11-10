import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_values.dart';
import '../../../../core/router/app_router.gr.dart';
import '../../../../shared/ui_kit/ui_kit.dart';

/// Tactile banner on HomeScreen introducing the 5 Mini-Game Playground
class HomeMiniGameBanner extends StatelessWidget {
  const HomeMiniGameBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return ClayCard(
      onTap: () => _openPlayground(context),
      backgroundColor: AppColors.brandIndigoContainer,
      padding: const EdgeInsets.all(AppValues.space6),
      child: Row(
        children: [
          Container(
            width: AppValues.space11,
            height: AppValues.space11,
            decoration: const BoxDecoration(
              color: AppColors.brandPrimary,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.sports_esports_rounded,
              color: AppColors.textInverse,
              size: AppValues.space7,
            ),
          ),
          const SizedBox(width: AppValues.space5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.playgroundBannerTitleEn,
                  style: GoogleFonts.quicksand(
                    fontSize: AppValues.fontTitleMd,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppValues.space1),
                Text(
                  AppStrings.playgroundBannerSubtitleEn,
                  style: GoogleFonts.quicksand(
                    fontSize: AppValues.fontCourseMeta,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppValues.space3),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: AppValues.space5,
            color: AppColors.brandPrimary,
          ),
        ],
      ),
    );
  }

  void _openPlayground(BuildContext context) {
    final hasRouter =
        context.findAncestorWidgetOfExactType<RouterScope>() != null;
    if (hasRouter) {
      context.router.push(const MiniGamePlaygroundRoute());
    }
  }
}
