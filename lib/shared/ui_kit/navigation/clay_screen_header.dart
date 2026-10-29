import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_values.dart';
import '../buttons/clay_icon_button.dart';

/// Standard Tactile Clay Sub-Screen Header (`Back` + Optional `Trailing` + `Title` + `Subtitle`)
class ClayScreenHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onBackPressed;
  final Widget? trailing;
  final bool centerTitle;

  const ClayScreenHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.onBackPressed,
    this.trailing,
    this.centerTitle = false,
  });

  Widget _buildBackButton(BuildContext context) {
    final effectiveBack =
        onBackPressed ?? () => Navigator.of(context).maybePop();
    return Semantics(
      button: true,
      label: AppStrings.backButtonLabel,
      child: SizedBox(
        width: AppValues.minTouchTarget,
        height: AppValues.minTouchTarget,
        child: Align(
          alignment: Alignment.centerLeft,
          child: ClayIconButton(
            size: AppValues.sizeCircleButtonXl,
            backgroundColor: AppColors.surfaceContainer,
            glowColor: AppColors.clayContactShadow,
            onPressed: effectiveBack,
            icon: const Icon(
              Icons.arrow_back_rounded,
              size: AppValues.iconSizeMd,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final align =
        centerTitle ? CrossAxisAlignment.center : CrossAxisAlignment.start;
    final textAlign = centerTitle ? TextAlign.center : TextAlign.start;

    return Column(
      crossAxisAlignment: align,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildBackButton(context),
            if (trailing != null) trailing!,
          ],
        ),
        const SizedBox(height: AppValues.space4),
        Text(
          title,
          textAlign: textAlign,
          style: GoogleFonts.quicksand(
            fontSize: AppValues.fontHeadlineLg,
            fontWeight: FontWeight.w800,
            color: AppColors.textDarkIndigo,
            letterSpacing: AppValues.letterSpacingCondensed,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: AppValues.radiusXs),
          Text(
            subtitle!,
            textAlign: textAlign,
            style: GoogleFonts.quicksand(
              fontSize: AppValues.fontBodyMd,
              fontWeight: FontWeight.w500,
              color: AppColors.textSlate,
            ),
          ),
        ],
      ],
    );
  }
}

