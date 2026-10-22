import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_values.dart';

/// 3D Tactile Clay Pedestal for Kid Mascot Companions (US-04.3)
/// Pure White Clay surface with seamless blend (Zero square patch artifact).
class AvatarClayPedestal extends StatelessWidget {
  final String name;
  final String path;
  final bool isSelected;
  final Color? auraColor;
  final VoidCallback onTap;

  const AvatarClayPedestal({
    super.key,
    required this.name,
    required this.path,
    required this.isSelected,
    this.auraColor,
    required this.onTap,
  });

  void _handleTap() {
    SystemSound.play(SystemSoundType.click);
    HapticFeedback.lightImpact();
    onTap();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveAura = isSelected
        ? AppColors.brandIndigoContainer
        : (auraColor ?? AppColors.surfaceCanvas);

    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedContainer(
        duration: AppValues.durationNormal,
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.all(AppValues.space6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppValues.radiusXl),
          border: Border.all(
            color: isSelected ? AppColors.brandPrimary : AppColors.borderDefault,
            width: isSelected ? 2.5 : 1.5,
          ),
          boxShadow: isSelected
              ? [
                  const BoxShadow(
                    color: Color(0xFF3730A3),
                    offset: Offset(0, 3.5),
                    blurRadius: 0,
                  ),
                  BoxShadow(
                    color: AppColors.brandPrimary.withValues(alpha: 0.25),
                    offset: const Offset(0, 8),
                    blurRadius: 16,
                  ),
                ]
              : [
                  const BoxShadow(
                    color: AppColors.clayCardShade,
                    offset: Offset(0, 2.5),
                    blurRadius: 0,
                  ),
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    offset: const Offset(0, 4),
                    blurRadius: 8,
                  ),
                ],
        ),
        child: Stack(
          children: [
            Column(
              children: [
                // Mascot 3D Image sitting on circular pastel stage
                Expanded(
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: AnimatedContainer(
                        duration: AppValues.durationNormal,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: effectiveAura,
                        ),
                        padding: const EdgeInsets.all(AppValues.space2),
                        child: Image.asset(
                          path,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppValues.space3),

                // Tactile Name Tag (symmetrical across all cards)
                AnimatedContainer(
                  duration: AppValues.durationFast,
                  height: 34,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: AppValues.space4),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.brandPrimary
                        : const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(AppValues.radiusPill),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.brandPrimary
                          : const Color(0xFFE2E8F0),
                      width: 1.5,
                    ),
                  ),
                  child: Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.quicksand(
                      fontSize: AppValues.fontTitleMd,
                      fontWeight: FontWeight.w800,
                      color: isSelected ? Colors.white : AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),

            // Top-right Selection Badge
            Positioned(
              top: 0,
              right: 0,
              child: AnimatedScale(
                scale: isSelected ? 1.0 : 0.0,
                duration: AppValues.durationFast,
                curve: Curves.easeOutBack,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: AppColors.brandPrimary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.brandPrimary.withValues(alpha: 0.35),
                        offset: const Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
