import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_values.dart';
import '../../../../shared/ui_kit/ui_kit.dart';
import '../../domain/models/game_result.dart';
import '../widgets/playground_game_builder.dart';

@RoutePage()
class MiniGamePlaygroundScreen extends StatefulWidget {
  const MiniGamePlaygroundScreen({super.key});

  @override
  State<MiniGamePlaygroundScreen> createState() =>
      _MiniGamePlaygroundScreenState();
}

class _MiniGamePlaygroundScreenState extends State<MiniGamePlaygroundScreen> {
  int _activeGameIndex = 0;
  int _replayKey = 0;

  final List<String> _gameTitles = [
    AppStrings.gameTabSorter,
    AppStrings.gameTabBalancer,
    AppStrings.gameTabPopper,
    AppStrings.gameTabTracer,
    AppStrings.gameTabFlipper,
  ];

  void _onGameCompleted(GameResult result) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.star_rounded, color: AppColors.brandAmber),
            const SizedBox(width: AppValues.space2),
            Expanded(
              child: Text(
                '${AppStrings.gameCompleted} (+${result.starsEarned})',
                style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textInverse,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.brandMint,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _restartCurrentGame() {
    setState(() => _replayKey++);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            _buildGameTabs(),
            const SizedBox(height: AppValues.space4),
            Expanded(
              child: KeyedSubtree(
                key: ValueKey('game_${_activeGameIndex}_$_replayKey'),
                child: PlaygroundGameBuilder.buildGame(
                  index: _activeGameIndex,
                  onCompleted: _onGameCompleted,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppValues.space6,
        vertical: AppValues.space4,
      ),
      child: Row(
        children: [
          ClayIconButton(
            size: AppValues.minTouchTarget,
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: AppColors.brandPrimary,
            ),
            onPressed: () {
              if (context.findAncestorWidgetOfExactType<RouterScope>() != null) {
                context.router.maybePop();
              } else {
                Navigator.of(context).maybePop();
              }
            },
          ),
          const SizedBox(width: AppValues.space4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.playgroundTitle,
                  style: GoogleFonts.quicksand(
                    fontSize: AppValues.fontTitleHero,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  AppStrings.playgroundSubtitle,
                  style: GoogleFonts.quicksand(
                    fontSize: AppValues.fontCourseMeta,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          ClayIconButton(
            size: AppValues.minTouchTarget,
            icon: const Icon(Icons.refresh_rounded, color: AppColors.brandPrimary),
            onPressed: _restartCurrentGame,
          ),
        ],
      ),
    );
  }

  Widget _buildGameTabs() {
    return SizedBox(
      height: AppValues.minTouchTarget,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: AppValues.space6),
        scrollDirection: Axis.horizontal,
        itemCount: _gameTitles.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppValues.space3),
        itemBuilder: (context, index) {
          final isSelected = index == _activeGameIndex;
          return GestureDetector(
            onTap: () => setState(() {
              _activeGameIndex = index;
              _replayKey++;
            }),
            child: AnimatedContainer(
              duration: const Duration(
                milliseconds: AppValues.gameAnimDurationMs,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppValues.space6,
                vertical: AppValues.space2,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.brandPrimary
                    : AppColors.surfaceContainer,
                borderRadius: BorderRadius.circular(AppValues.radiusPill),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColors.brandPrimary.withValues(alpha: 0.3),
                          offset: const Offset(0, 2),
                          blurRadius: 4,
                        ),
                      ]
                    : null,
              ),
              alignment: Alignment.center,
              child: Text(
                _gameTitles[index],
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
}
