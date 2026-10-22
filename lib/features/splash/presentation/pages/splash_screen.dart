import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_values.dart';
import '../../../../core/router/app_router.gr.dart';
import '../controllers/splash_controller.dart';

@RoutePage()
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animCtrl;
  late Animation<double> _logoScale;
  late Animation<double> _logoFade;
  late Animation<double> _taglineSlide;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: AppValues.splashAnimDuration,
    );
    _logoScale = Tween<double>(
      begin: AppValues.splashScaleStart,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animCtrl,
      curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
    ));
    _logoFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animCtrl,
        curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
      ),
    );
    _taglineSlide = Tween<double>(
      begin: AppValues.splashTaglineOffset,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animCtrl,
      curve: const Interval(0.5, 1.0, curve: Curves.easeOutCubic),
    ));
    _animCtrl.forward().then((_) => _navigate());
  }

  void _navigate() {
    if (!mounted) return;
    final ctrl = ref.read(splashControllerProvider.notifier);
    if (ctrl.hasCompletedOnboarding) {
      context.router.replace(const HomeRoute());
    } else {
      context.router.replace(OnboardingRoute());
    }
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.brandPrimary,
      body: Center(
        child: AnimatedBuilder(
          animation: _animCtrl,
          builder: (context, _) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FadeTransition(
                opacity: _logoFade,
                child: ScaleTransition(
                  scale: _logoScale,
                  child: const _SplashLogo(),
                ),
              ),
              SizedBox(height: AppValues.space9),
              Transform.translate(
                offset: Offset(0, _taglineSlide.value),
                child: Opacity(
                  opacity: _logoFade.value,
                  child: const _SplashTagline(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SplashLogo extends StatelessWidget {
  const _SplashLogo();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppValues.splashLogoSize,
      height: AppValues.splashLogoSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppValues.splashLogoRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.clayShadow,
            blurRadius: AppValues.splashShadowBlur,
            offset: const Offset(0, AppValues.splashShadowOffsetY),
          ),
          BoxShadow(
            color: AppColors.clayHighlight.withAlpha(77),
            blurRadius: AppValues.space4,
            offset: const Offset(
              -AppValues.space2,
              -AppValues.space2,
            ),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(
        AppValues.splashLogoAsset,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _SplashTagline extends StatelessWidget {
  const _SplashTagline();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppStrings.appName,
          style: TextStyle(
            fontFamily: AppValues.fontFamilyQuicksand,
            fontSize: AppValues.fontDisplayHero,
            fontWeight: FontWeight.w700,
            color: AppColors.textInverse,
            letterSpacing: AppValues.letterSpacingCondensed,
          ),
        ),
        SizedBox(height: AppValues.space2),
        Text(
          AppStrings.appTagline,
          style: TextStyle(
            fontFamily: AppValues.fontFamilyQuicksand,
            fontSize: AppValues.fontBodyMd,
            fontWeight: FontWeight.w500,
            color: AppColors.clayHighlightMedium,
            letterSpacing: AppValues.letterSpacingWide,
          ),
        ),
      ],
    );
  }
}
