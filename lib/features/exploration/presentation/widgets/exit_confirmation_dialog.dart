import 'package:flutter/material.dart';
import 'package:kiddora/core/constants/app_colors.dart';
import 'package:kiddora/core/constants/app_strings.dart';
import 'package:kiddora/core/constants/app_values.dart';
import 'package:kiddora/shared/ui_kit/buttons/clay_button.dart';
import 'package:kiddora/shared/ui_kit/surfaces/clay_card.dart';

/// Friendly tactile confirmation dialog for exiting a lesson safely
class ExitConfirmationDialog extends StatelessWidget {
  const ExitConfirmationDialog({super.key});

  static Future<bool> show(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => const ExitConfirmationDialog(),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: AppValues.space9),
      child: ClayCard(
        borderRadius: AppValues.radiusXl,
        padding: const EdgeInsets.all(AppValues.space9),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: const BoxDecoration(
                color: AppColors.brandAmberContainer,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.pause_rounded,
                size: 32,
                color: AppColors.brandSecondary,
              ),
            ),
            const SizedBox(height: AppValues.space7),
            const Text(
              AppStrings.exitLessonTitle,
              style: TextStyle(
                fontSize: AppValues.fontHeadlineMd,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppValues.space4),
            const Text(
              AppStrings.exitLessonMessage,
              style: TextStyle(
                fontSize: AppValues.fontBodyMd,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppValues.space9),
            // Actions
            ClayButton(
              onPressed: () => Navigator.of(context).pop(false),
              label: AppStrings.btnKeepLearning,
              backgroundColor: AppColors.brandPrimary,
              width: double.infinity,
            ),
            const SizedBox(height: AppValues.space4),
            ClayButton.secondary(
              onPressed: () => Navigator.of(context).pop(true),
              label: AppStrings.btnSaveAndExit,
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
