import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_values.dart';
import '../../../core/constants/app_strings.dart';
import '../../../shared/ui_kit/ui_kit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppValues.space7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppValues.space4),
              // Header with Profile & Rewards
              _buildTopHeader(),
              const SizedBox(height: AppValues.space8),

              // Live Class Spotlight Card
              _buildLiveClassSpotlight(),
              const SizedBox(height: AppValues.space9),

              // Subject Worlds Hub
              Text(
                'Thế Giới Khám Phá',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: AppValues.space5),
              _buildSubjectGrid(),
              const SizedBox(height: AppValues.space9),

              // Daily Quest Card
              _buildDailyQuestCard(context),
              const SizedBox(height: AppValues.space11),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.brandPrimary.withValues(alpha: 0.15),
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.brandPrimary, width: 2),
              ),
              child: const Center(
                child: Text('🦁', style: TextStyle(fontSize: 24)),
              ),
            ),
            const SizedBox(width: AppValues.space5),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Chào Alex! 🚀',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  'Cấp độ 3 • Thám hiểm viên',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ],
        ),
        const Row(
          children: [
            StarCounterBadge(count: 5, isStreak: true),
            SizedBox(width: AppValues.space4),
            StarCounterBadge(count: 140),
          ],
        ),
      ],
    );
  }

  Widget _buildLiveClassSpotlight() {
    return ClayCard(
      glowColor: AppColors.brandSky.withValues(alpha: 0.2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.brandMint,
                  borderRadius: BorderRadius.circular(AppValues.radiusPill),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.circle, color: Colors.white, size: 8),
                    SizedBox(width: 4),
                    Text(
                      'TRỰC TUYẾN',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              const Row(
                children: [
                  Icon(Icons.people_alt_rounded, size: 16, color: AppColors.textSecondary),
                  SizedBox(width: 4),
                  Text(
                    '24 bạn đang học',
                    style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppValues.space6),
          const Text(
            'Khám Phá Bí Mật Sao Hỏa 🪐',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppValues.space2),
          const Text(
            'Thầy Alex • Lớp Khoa học STEM tương tác',
            style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppValues.space7),
          SizedBox(
            width: double.infinity,
            child: ClayButton(
              label: AppStrings.enterLiveClass,
              backgroundColor: AppColors.brandPrimary,
              icon: const Icon(Icons.play_circle_fill_rounded, color: Colors.white),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectGrid() {
    return Row(
      children: [
        Expanded(
          child: _buildSubjectCard(
            title: AppStrings.mathTitle,
            emoji: '🧮',
            color: AppColors.brandPrimary,
            lessonsCount: '12 Nhiệm vụ',
          ),
        ),
        const SizedBox(width: AppValues.space5),
        Expanded(
          child: _buildSubjectCard(
            title: AppStrings.stemTitle,
            emoji: '🔬',
            color: AppColors.brandTertiary,
            lessonsCount: '8 Thí nghiệm',
          ),
        ),
      ],
    );
  }

  Widget _buildSubjectCard({
    required String title,
    required String emoji,
    required Color color,
    required String lessonsCount,
  }) {
    return ClayCard(
      glowColor: color.withValues(alpha: 0.15),
      padding: const EdgeInsets.all(AppValues.space6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppValues.radiusLg),
            ),
            child: Text(emoji, style: const TextStyle(fontSize: 28)),
          ),
          const SizedBox(height: AppValues.space5),
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppValues.space1),
          Text(
            lessonsCount,
            style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyQuestCard(BuildContext context) {
    return ClayCard(
      backgroundColor: const Color(0xFFF0FDF4),
      glowColor: AppColors.brandMint.withValues(alpha: 0.2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Nhiệm Vụ Hôm Nay ⭐',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.brandMint.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(AppValues.radiusPill),
                ),
                child: const Text(
                  '+30 Sao',
                  style: TextStyle(
                    color: AppColors.brandMint,
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppValues.space3),
          const Text(
            'Hoàn thành 3 câu đố tư duy toán học',
            style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppValues.space6),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppValues.radiusPill),
            child: const LinearProgressIndicator(
              value: 0.66,
              minHeight: 12,
              backgroundColor: Color(0xFFDCFCE7),
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.brandMint),
            ),
          ),
        ],
      ),
    );
  }
}
