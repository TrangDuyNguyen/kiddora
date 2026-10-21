import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_values.dart';
import '../../../../core/router/app_router.gr.dart';
import '../controllers/onboarding_controller.dart';
import '../widgets/clay_page_indicator.dart';

@RoutePage()
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Pre-cache ảnh cho cả 3 slide để vuốt mượt mà 60 FPS
    precacheImage(const AssetImage('assets/images/onboarding_1.png'), context);
    precacheImage(const AssetImage('assets/images/onboarding_2.png'), context);
    precacheImage(const AssetImage('assets/images/onboarding_3.png'), context);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNextTap() {
    HapticFeedback.lightImpact();
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
      );
    } else {
      context.router.push(const KidProfileSetupRoute());
    }
  }

  void _onSkipTap() {
    HapticFeedback.lightImpact();
    context.router.push(const KidProfileSetupRoute());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF9FE),
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar với nút Skip
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildBrandHeader(),
                  if (_currentPage < 2)
                    TextButton(
                      onPressed: _onSkipTap,
                      child: const Text(
                        'Bỏ qua',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    )
                  else
                    const SizedBox(height: 48),
                ],
              ),
            ),

            // PageView chứa 3 Slides
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (page) {
                  setState(() => _currentPage = page);
                  ref.read(onboardingControllerProvider.notifier).setSlideIndex(page);
                },
                children: [
                  _buildSlide(
                    imagePath: 'assets/images/onboarding_1.png',
                    title: 'Fun Learning for a\nBrighter Tomorrow',
                    subtitle:
                        'Khám phá khoá học bổ ích, lớp học trực tuyến, chơi vui và rèn luyện tư duy mỗi ngày!',
                  ),
                  _buildSlide(
                    imagePath: 'assets/images/onboarding_2.png',
                    title: 'Discover & Learn',
                    subtitle:
                        'Chương trình học thú vị dành riêng cho con. Tự do học theo tốc độ cá nhân và phát triển kỹ năng.',
                  ),
                  _buildSlide(
                    imagePath: 'assets/images/onboarding_3.png',
                    title: 'Learn with\nLive Coaches',
                    subtitle:
                        'Tham gia lớp trực tiếp, bấm chuông trả lời câu hỏi và học hỏi từ các thầy cô xuất sắc.',
                  ),
                ],
              ),
            ),

            // Bottom Navigation Card
            _buildBottomControls(),
          ],
        ),
      ),
    );
  }

  Widget _buildBrandHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kiddora',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w900,
            color: AppColors.brandPrimary,
            letterSpacing: -0.5,
          ),
        ),
        Text(
          'Learn • Play • Achieve',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildSlide({
    required String imagePath,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const Spacer(),
          // 3D Illustration Area
          Hero(
            tag: imagePath,
            child: Container(
              height: 290,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const Spacer(),
          // Title & Subtitle Text
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: AppColors.textPrimary,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildBottomControls() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 8, 28, 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClayPageIndicator(currentPage: _currentPage),
          _buildActionButton(),
        ],
      ),
    );
  }

  Widget _buildActionButton() {
    final isLastPage = _currentPage == 2;
    return GestureDetector(
      onTap: _onNextTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 56,
        padding: EdgeInsets.symmetric(horizontal: isLastPage ? 24 : 16),
        decoration: BoxDecoration(
          color: AppColors.brandPrimary,
          borderRadius: BorderRadius.circular(AppValues.radiusPill),
          boxShadow: [
            BoxShadow(
              color: AppColors.brandPrimary.withValues(alpha: 0.35),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
            const BoxShadow(
              color: Colors.white,
              blurRadius: 4,
              offset: Offset(-2, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isLastPage) ...[
              const Text(
                'Bắt đầu ngay',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 8),
            ],
            const Icon(
              Icons.arrow_forward_rounded,
              color: Colors.white,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
