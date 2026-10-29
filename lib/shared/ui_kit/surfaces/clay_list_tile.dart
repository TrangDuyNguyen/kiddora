import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_values.dart';

/// Composable Tactile Clay List Row
/// Powers both Profile Menu Tiles (`Help & Support`, `Log Out`) and Session/Test Action Cards.
class ClayListTile extends StatelessWidget {
  final Widget? leading;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool showChevron;
  final Color titleColor;

  const ClayListTile({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.showChevron = false,
    this.titleColor = AppColors.textDarkIndigo,
  });

  Widget _buildTextColumn() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.quicksand(
              fontSize: AppValues.fontBodyLg,
              fontWeight: FontWeight.w700,
              color: titleColor,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: AppValues.borderWidthThick),
            Text(
              subtitle!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.quicksand(
                fontSize: AppValues.fontBodySm,
                fontWeight: FontWeight.w600,
                color: AppColors.textSlate,
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final effectiveTrailing = trailing ??
        (showChevron
            ? const Icon(
                Icons.chevron_right_rounded,
                size: AppValues.iconSizeXl,
                color: AppColors.textMuted,
              )
            : null);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap == null
          ? null
          : () {
              HapticFeedback.lightImpact();
              onTap!();
            },
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: AppValues.minTouchTarget),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppValues.space2),
          child: Row(
            children: [
              if (leading != null) ...[
                leading!,
                const SizedBox(width: AppValues.space6),
              ],
              _buildTextColumn(),
              if (effectiveTrailing != null) ...[
                const SizedBox(width: AppValues.space4),
                effectiveTrailing,
              ],
            ],
          ),
        ),
      ),
    );
  }
}

