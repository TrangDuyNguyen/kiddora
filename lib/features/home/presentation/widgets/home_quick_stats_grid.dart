import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_values.dart';

class HomeQuickStatsGrid extends StatelessWidget {
  final VoidCallback onMyProgressTap;

  const HomeQuickStatsGrid({
    super.key,
    required this.onMyProgressTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                icon: Icons.bar_chart_rounded,
                iconBg: const Color(0xFFD1FAE5),
                iconColor: const Color(0xFF10B981),
                title: 'My Progress',
                subtitle: "You're doing great!",
                onTap: onMyProgressTap,
              ),
            ),
            const SizedBox(width: AppValues.space4),
            Expanded(
              child: _buildStatCard(
                icon: Icons.menu_book_rounded,
                iconBg: const Color(0xFFE0F2FE),
                iconColor: const Color(0xFF0EA5E9),
                title: 'Current Courses',
                subtitle: '3 Active Courses',
                onTap: () {},
              ),
            ),
          ],
        ),
        const SizedBox(height: AppValues.space4),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                icon: Icons.calendar_month_rounded,
                iconBg: const Color(0xFFFCE7F3),
                iconColor: const Color(0xFFEC4899),
                title: 'Upcoming Session',
                subtitle: 'Math with Coach Alex',
                onTap: () {},
              ),
            ),
            const SizedBox(width: AppValues.space4),
            Expanded(
              child: _buildStatCard(
                icon: Icons.emoji_events_rounded,
                iconBg: const Color(0xFFFEF3C7),
                iconColor: const Color(0xFFF59E0B),
                title: 'My Badges',
                subtitle: '5 Badges Earned',
                onTap: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.all(AppValues.space5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppValues.radiusXl),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF4F46E5).withValues(alpha: 0.05),
              offset: const Offset(0, 3),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: iconBg,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(icon, size: 20, color: iconColor),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: GoogleFonts.quicksand(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1E1B4B),
              ),
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                Expanded(
                  child: Text(
                    subtitle,
                    style: GoogleFonts.quicksand(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF6E6D7A),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  size: 14,
                  color: Color(0xFF94A3B8),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
