import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_values.dart';
import '../../../../core/network/token_storage.dart';
import '../../../../core/router/app_router.gr.dart';
import '../../../../shared/ui_kit/buttons/clay_button.dart';
import '../../../../shared/ui_kit/surfaces/clay_card.dart';

final isGuestModeProvider = FutureProvider<bool>((ref) async {
  final tokenStorage = ref.watch(tokenStorageProvider);
  return await tokenStorage.isGuestMode();
});

class GuestClaimBanner extends ConsumerWidget {
  const GuestClaimBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isGuestAsync = ref.watch(isGuestModeProvider);

    return isGuestAsync.maybeWhen(
      data: (isGuest) {
        if (!isGuest) return const SizedBox.shrink();

        return Padding(
          padding: const EdgeInsets.only(bottom: AppValues.space6),
          child: ClayCard(
            backgroundColor: AppColors.brandAmberContainer,
            borderRadius: AppValues.radiusXl,
            padding: const EdgeInsets.all(AppValues.space5),
            child: Row(
              children: [
                Container(
                  width: AppValues.actionButtonSmall,
                  height: AppValues.actionButtonSmall,
                  decoration: const BoxDecoration(
                    color: AppColors.brandSecondary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.star_rounded,
                    color: Colors.white,
                    size: AppValues.iconSizeMd,
                  ),
                ),
                const SizedBox(width: AppValues.space4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        AppStrings.guestBannerTitle,
                        style: GoogleFonts.quicksand(
                          fontSize: AppValues.fontBodyMd,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: AppValues.space1),
                      Text(
                        AppStrings.guestBannerSubtitle,
                        style: GoogleFonts.quicksand(
                          fontSize: AppValues.fontBodySm,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppValues.space3),
                ClayButton(
                  label: AppStrings.registerNow,
                  height: AppValues.actionButtonSmall,
                  customGradient: const LinearGradient(
                    colors: [
                      AppColors.brandSecondary,
                      AppColors.clayExtrusionAmber,
                    ],
                  ),
                  onPressed: () {

                    HapticFeedback.lightImpact();
                    context.router.push(const RegisterRoute());
                  },
                ),
              ],
            ),
          ),
        );
      },
      orElse: () => const SizedBox.shrink(),
    );
  }
}
