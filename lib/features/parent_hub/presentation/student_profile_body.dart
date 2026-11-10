import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_values.dart';
import '../../../shared/ui_kit/ui_kit.dart';

class StudentProfileBody extends StatelessWidget {
  final String nickname;
  final int age;
  final VoidCallback onLogoutTap;
  final ValueChanged<String>? onSnack;

  const StudentProfileBody({
    super.key,
    required this.nickname,
    this.age = 8,
    required this.onLogoutTap,
    this.onSnack,
  });

  void _notify(BuildContext context, String msg) {
    if (onSnack != null) {
      onSnack!(msg);
    } else {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(msg),
          duration: AppValues.durationSnackBar,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppValues.space6,
        vertical: AppValues.space4,
      ),
      children: [
        _buildHeader(),
        const SizedBox(height: AppValues.space6),
        _buildKidHeroCard(),
        const SizedBox(height: AppValues.space7),
        _buildStatsGrid(),
        const SizedBox(height: AppValues.space7),
        _buildParentGateCard(context),
        const SizedBox(height: AppValues.space7),
        _buildSettingsSection(context),
        const SizedBox(height: AppValues.space10),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.profileTitle,
          style: GoogleFonts.quicksand(
            fontSize: AppValues.fontHeadlineMid,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppValues.space1),
        Text(
          AppStrings.profileSubtitle,
          style: GoogleFonts.quicksand(
            fontSize: AppValues.fontBodySm,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildKidHeroCard() {
    return ClayCard(
      padding: const EdgeInsets.all(AppValues.space6),
      child: Row(
        children: [
          Container(
            width: AppValues.space11 + AppValues.space7,
            height: AppValues.space11 + AppValues.space7,
            decoration: BoxDecoration(
              color: AppColors.brandIndigoLight.withValues(alpha: 0.15),
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.brandPrimary,
                width: AppValues.borderWidthThick,
              ),
            ),
            child: const Icon(
              Icons.face_rounded,
              size: AppValues.space10,
              color: AppColors.brandPrimary,
            ),
          ),
          const SizedBox(width: AppValues.space6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nickname,
                  style: GoogleFonts.quicksand(
                    fontSize: AppValues.fontHeadlineMd,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppValues.space1),
                Text(
                  '$age ${AppStrings.ageUnit}',
                  style: GoogleFonts.quicksand(
                    fontSize: AppValues.fontBodySm,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppValues.space2),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppValues.space3,
                    vertical: AppValues.space1,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.brandAmberContainer,
                    borderRadius: BorderRadius.circular(AppValues.radiusPill),
                  ),
                  child: Text(
                    AppStrings.kidLevelBadge,
                    style: GoogleFonts.quicksand(
                      fontSize: AppValues.fontBadgeXs,
                      fontWeight: FontWeight.bold,
                      color: AppColors.clayExtrusionAmber,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid() {
    return ClayCard(
      padding: const EdgeInsets.all(AppValues.space6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatColumn(
            label: AppStrings.statStarPoints,
            value: AppStrings.statStarPointsValue,
            icon: Icons.star_rounded,
            color: AppColors.brandAmber,
          ),
          _buildStatColumn(
            label: AppStrings.statStreakDays,
            value: AppStrings.statStreakDaysValue,
            icon: Icons.local_fire_department_rounded,
            color: AppColors.stateError,
          ),
          _buildStatColumn(
            label: AppStrings.statActiveCourses,
            value: AppStrings.statActiveCoursesValue,
            icon: Icons.menu_book_rounded,
            color: AppColors.brandPrimary,
          ),
          _buildStatColumn(
            label: AppStrings.statBadgesEarned,
            value: AppStrings.statBadgesEarnedValue,
            icon: Icons.emoji_events_rounded,
            color: AppColors.brandTertiary,
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: AppValues.iconSizeMd),
        const SizedBox(height: AppValues.space2),
        Text(
          value,
          style: GoogleFonts.quicksand(
            fontSize: AppValues.fontTitleHero,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppValues.space1),
        Text(
          label,
          style: GoogleFonts.quicksand(
            fontSize: AppValues.fontBadgeXs,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildParentGateCard(BuildContext context) {
    return ClayCard(
      backgroundColor: AppColors.surfaceContainerHigh,
      padding: const EdgeInsets.all(AppValues.space6),
      child: Row(
        children: [
          Container(
            width: AppValues.minTouchTarget,
            height: AppValues.minTouchTarget,
            decoration: BoxDecoration(
              color: AppColors.brandPrimary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(AppValues.radiusLg),
            ),
            child: const Icon(
              Icons.lock_rounded,
              color: AppColors.brandPrimary,
              size: AppValues.iconSizeLg,
            ),
          ),
          const SizedBox(width: AppValues.space4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.parentGateCardTitle,
                  style: GoogleFonts.quicksand(
                    fontSize: AppValues.fontBodyMd,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppValues.space1),
                Text(
                  AppStrings.parentGateCardSubtitle,
                  style: GoogleFonts.quicksand(
                    fontSize: AppValues.fontCaptionSm,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppValues.space2),
          ClayButton.compact(
            label: AppStrings.btnUnlockParentGate,
            onPressed: () => _notify(context, AppStrings.parentGateCardTitle),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.settingsSectionTitle,
          style: GoogleFonts.quicksand(
            fontSize: AppValues.fontTitleHero,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppValues.space4),
        ClayCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              _buildSettingTile(
                title: AppStrings.settingSoundHaptics,
                icon: Icons.volume_up_rounded,
                onTap: () => _notify(context, AppStrings.settingSoundHaptics),
              ),
              const Divider(height: 1, color: AppColors.dividerSubtle),
              _buildSettingTile(
                title: AppStrings.settingNotifications,
                icon: Icons.notifications_rounded,
                onTap: () => _notify(context, AppStrings.settingNotifications),
              ),
              const Divider(height: 1, color: AppColors.dividerSubtle),
              _buildSettingTile(
                title: AppStrings.settingCompanion,
                icon: Icons.smart_toy_rounded,
                onTap: () => _notify(context, AppStrings.settingCompanion),
              ),
              const Divider(height: 1, color: AppColors.dividerSubtle),
              _buildSettingTile(
                title: AppStrings.settingHelpCenter,
                icon: Icons.help_outline_rounded,
                onTap: () => _notify(context, AppStrings.settingHelpCenter),
              ),
              const Divider(height: 1, color: AppColors.dividerSubtle),
              _buildSettingTile(
                title: AppStrings.settingLogout,
                icon: Icons.logout_rounded,
                iconColor: AppColors.stateError,
                textColor: AppColors.stateError,
                onTap: onLogoutTap,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSettingTile({
    required String title,
    required IconData icon,
    Color iconColor = AppColors.brandPrimary,
    Color textColor = AppColors.textPrimary,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(
        title,
        style: GoogleFonts.quicksand(
          fontSize: AppValues.fontBodyMd,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right_rounded,
        color: AppColors.textMuted,
        size: AppValues.iconSizeSm,
      ),
      onTap: onTap,
    );
  }
}

