import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_values.dart';
import '../../../../shared/ui_kit/indicators/star_counter_badge.dart';

class HomeHeader extends StatelessWidget {
  final String kidName;
  final String avatarAsset;
  final int starPoints;
  final int notificationCount;
  final VoidCallback? onAvatarTap;
  final VoidCallback onNotificationTap;
  final VoidCallback onLogoutTap;

  const HomeHeader({
    super.key,
    this.kidName = AppStrings.defaultKidName,
    this.avatarAsset = 'assets/images/zodiac_dragon.png',
    this.starPoints = 120,
    this.notificationCount = 3,
    this.onAvatarTap,
    required this.onNotificationTap,
    required this.onLogoutTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left: Avatar & Greeting
        Expanded(
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact();
                  onAvatarTap?.call();
                },
                child: Container(
                  width: AppValues.sizeAvatarLg,
                  height: AppValues.sizeAvatarLg,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: AppValues.borderWidthThick,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.clayShadeSubtle,
                        blurRadius: AppValues.radiusMd,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      avatarAsset,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Image.asset(
                        'assets/images/zodiac_dragon.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppValues.radiusLg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${AppStrings.hiPrefix}$kidName${AppStrings.exclamationMark}',
                      style: GoogleFonts.quicksand(
                        fontSize: AppValues.fontTitleHero,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textDarkIndigo,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      AppStrings.greatToSeeYou,
                      style: GoogleFonts.quicksand(
                        fontSize: AppValues.fontBodySm,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSlate,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Right: Star Counter Badge, Notification Bell & Logout
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            StarCounterBadge(count: starPoints),
            const SizedBox(width: AppValues.space3),

            // Notification Bell with Badge
            GestureDetector(
              onTap: () {
                HapticFeedback.lightImpact();
                onNotificationTap();
              },
              child: Container(
                width: AppValues.sizeCircleButtonLg,
                height: AppValues.sizeCircleButtonLg,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.clayShadeSubtle,
                      blurRadius: AppValues.radiusSm,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Icon(
                      Icons.notifications_outlined,
                      size: AppValues.iconSizeXl,
                      color: AppColors.textPrimary,
                    ),
                    if (notificationCount > 0)
                      Positioned(
                        top: AppValues.radiusSm,
                        right: AppValues.radiusSm,
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: const BoxDecoration(
                            color: AppColors.brandTertiary,
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: AppValues.sizeNotificationBadgeMin,
                            minHeight: AppValues.sizeNotificationBadgeMin,
                          ),
                          child: Text(
                            '$notificationCount',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: AppValues.fontBadgeXs,
                              fontWeight: FontWeight.w800,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: AppValues.space3),

            // Logout Button
            GestureDetector(
              onTap: () {
                HapticFeedback.lightImpact();
                onLogoutTap();
              },
              child: Container(
                width: AppValues.sizeCircleButtonLg,
                height: AppValues.sizeCircleButtonLg,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.clayShadeSubtle,
                      blurRadius: AppValues.radiusSm,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.logout_rounded,
                  size: AppValues.iconSizeLg,
                  color: AppColors.textSlate,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
