import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_values.dart';

/// Displays a backend-provided error message; renders nothing when null.
class ClayErrorText extends StatelessWidget {
  const ClayErrorText(this.message, {super.key});

  final String? message;

  @override
  Widget build(BuildContext context) {
    final text = message;
    if (text == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: AppValues.space4),
      child: Semantics(
        liveRegion: true,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.quicksand(
            fontSize: AppValues.fontLabelMd,
            fontWeight: FontWeight.w600,
            color: AppColors.feedbackError,
          ),
        ),
      ),
    );
  }
}
