import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_values.dart';
import '../../../shared/ui_kit/ui_kit.dart';

class SessionsHubBody extends StatefulWidget {
  final ValueChanged<String>? onSnack;

  const SessionsHubBody({super.key, this.onSnack});

  @override
  State<SessionsHubBody> createState() => _SessionsHubBodyState();
}

class _SessionsHubBodyState extends State<SessionsHubBody> {
  int _selectedDayIndex = 0;

  final List<String> _days = [
    AppStrings.tabToday,
    AppStrings.tabTomorrow,
    AppStrings.tabThursday,
    AppStrings.tabFriday,
  ];

  void _notify(String msg) {
    if (widget.onSnack != null) {
      widget.onSnack!(msg);
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
        _buildLiveNowBanner(),
        const SizedBox(height: AppValues.space7),
        _buildDayFilter(),
        const SizedBox(height: AppValues.space7),
        _buildUpcomingSection(),
        const SizedBox(height: AppValues.space10),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.sessionsHubTitle,
          style: GoogleFonts.quicksand(
            fontSize: AppValues.fontHeadlineMid,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppValues.space1),
        Text(
          AppStrings.sessionsHubSubtitle,
          style: GoogleFonts.quicksand(
            fontSize: AppValues.fontBodySm,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildLiveNowBanner() {
    return ClayCard(
      backgroundColor: AppColors.brandIndigoLight.withValues(alpha: 0.1),
      glowColor: AppColors.brandIndigoLight,
      padding: const EdgeInsets.all(AppValues.space6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppValues.space3,
                  vertical: AppValues.space1,
                ),
                decoration: BoxDecoration(
                  color: AppColors.stateError,
                  borderRadius: BorderRadius.circular(AppValues.radiusPill),
                ),
                child: Text(
                  AppStrings.liveNowBadge,
                  style: GoogleFonts.quicksand(
                    fontSize: AppValues.fontBadgeXs,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textInverse,
                  ),
                ),
              ),
              const SizedBox(width: AppValues.space3),
              const Icon(
                Icons.people_rounded,
                size: AppValues.iconSizeSm,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: AppValues.space1),
              Text(
                AppStrings.liveNowWatchingCount,
                style: GoogleFonts.quicksand(
                  fontSize: AppValues.fontCaptionSm,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppValues.space4),
          Text(
            AppStrings.liveNowTitle,
            style: GoogleFonts.quicksand(
              fontSize: AppValues.fontTitleLg,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppValues.space2),
          Text(
            AppStrings.liveNowCoach,
            style: GoogleFonts.quicksand(
              fontSize: AppValues.fontBodySm,
              color: AppColors.brandPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppValues.space6),
          Align(
            alignment: Alignment.centerRight,
            child: ClayButton.compact(
              label: AppStrings.btnJoinLiveNow,
              onPressed: () => _notify(AppStrings.joiningSessionAlert),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayFilter() {
    return SizedBox(
      height: AppValues.minTouchTarget,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _days.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppValues.space3),
        itemBuilder: (context, index) {
          final isSelected = index == _selectedDayIndex;
          return GestureDetector(
            onTap: () => setState(() => _selectedDayIndex = index),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppValues.space6,
                vertical: AppValues.space2,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.brandPrimary
                    : AppColors.surfaceContainer,
                borderRadius: BorderRadius.circular(AppValues.radiusPill),
              ),
              alignment: Alignment.center,
              child: Text(
                _days[index],
                style: GoogleFonts.quicksand(
                  fontSize: AppValues.fontBodyMd,
                  fontWeight: FontWeight.bold,
                  color: isSelected
                      ? AppColors.textInverse
                      : AppColors.textSecondary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  static const _sessions = [
    (
      title: AppStrings.sessionMathTitle,
      coach: AppStrings.sessionMathCoach,
      time: AppStrings.sessionMathTime,
      icon: Icons.calculate_rounded,
      color: AppColors.brandPrimary,
    ),
    (
      title: AppStrings.sessionStemTitle,
      coach: AppStrings.sessionStemCoach,
      time: AppStrings.sessionStemTime,
      icon: Icons.science_rounded,
      color: AppColors.brandTertiary,
    ),
    (
      title: AppStrings.sessionArtTitle,
      coach: AppStrings.sessionArtCoach,
      time: AppStrings.sessionArtTime,
      icon: Icons.palette_rounded,
      color: AppColors.brandSecondary,
    ),
  ];

  Widget _buildUpcomingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.upcomingSessionsTitle,
          style: GoogleFonts.quicksand(
            fontSize: AppValues.fontTitleHero,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppValues.space4),
        for (final s in _sessions) ...[
          _buildSessionCard(
            title: s.title,
            coach: s.coach,
            time: s.time,
            icon: s.icon,
            accentColor: s.color,
          ),
          const SizedBox(height: AppValues.space4),
        ],
      ],
    );
  }

  Widget _buildSessionCard({
    required String title,
    required String coach,
    required String time,
    required IconData icon,
    required Color accentColor,
  }) {
    return ClayCard(
      padding: const EdgeInsets.all(AppValues.space6),
      child: Row(
        children: [
          Container(
            width: AppValues.minTouchTarget,
            height: AppValues.minTouchTarget,
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(AppValues.radiusLg),
            ),
            child: Icon(icon, color: accentColor, size: AppValues.iconSizeLg),
          ),
          const SizedBox(width: AppValues.space4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.quicksand(
                    fontSize: AppValues.fontBodyMd,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppValues.space1),
                Text(
                  '$coach • $time',
                  style: GoogleFonts.quicksand(
                    fontSize: AppValues.fontCaptionSm,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          ClayButton.compact(
            label: AppStrings.btnEnterWaitingRoom,
            backgroundColor: AppColors.surfaceContainerHigh,
            textColor: AppColors.brandPrimary,
            onPressed: () => _notify('$title - ${AppStrings.btnEnterWaitingRoom}'),
          ),
        ],
      ),
    );
  }
}
