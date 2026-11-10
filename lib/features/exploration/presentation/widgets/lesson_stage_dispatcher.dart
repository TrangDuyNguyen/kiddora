import 'package:flutter/material.dart';
import 'package:kiddora/core/constants/app_colors.dart';
import 'package:kiddora/core/constants/app_strings.dart';
import 'package:kiddora/core/constants/app_values.dart';
import 'package:kiddora/features/exploration/domain/models/game_result.dart';
import 'package:kiddora/features/exploration/domain/models/lesson_stage.dart';
import 'package:kiddora/shared/ui_kit/buttons/clay_button.dart';
import 'package:kiddora/shared/ui_kit/games/games.dart';
import 'package:kiddora/shared/ui_kit/surfaces/clay_card.dart';

/// Dynamic dispatcher rendering the appropriate 5E stage view
class LessonStageDispatcher extends StatelessWidget {
  final String lessonId;
  final LessonStageConfig stage;
  final VoidCallback onNext;
  final ValueChanged<GameResult> onGameCompleted;

  const LessonStageDispatcher({
    super.key,
    required this.lessonId,
    required this.stage,
    required this.onNext,
    required this.onGameCompleted,
  });

  @override
  Widget build(BuildContext context) {
    switch (stage.stage5e.toLowerCase()) {
      case 'engage':
        return _buildEngageStage(context);
      case 'explore':
        return _buildExploreStage(context);
      case 'explain':
        return _buildExplainStage(context);
      case 'elaborate':
        return _buildElaborateStage(context);
      case 'evaluate':
        return _buildEvaluateStage(context);
      default:
        return _buildEngageStage(context);
    }
  }

  // E1: Engage (Mascot Dialogue Hook)
  Widget _buildEngageStage(BuildContext context) {
    final greeting = stage.config['greeting_text'] as String? ??
        'Cùng bắt đầu chuyến khám phá bài học mới nào!';
    final cta = stage.config['action_cta'] as String? ?? AppStrings.btnNextStage;

    return Padding(
      padding: const EdgeInsets.all(AppValues.space9),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Mascot Icon Avatar
          Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              color: AppColors.brandIndigoContainer,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.auto_awesome,
              size: 52,
              color: AppColors.brandPrimary,
            ),
          ),
          const SizedBox(height: AppValues.space9),
          // Dialogue Bubble
          ClayCard(
            borderRadius: AppValues.radiusXl,
            padding: const EdgeInsets.all(AppValues.space9),
            child: Text(
              greeting,
              style: const TextStyle(
                fontSize: AppValues.fontTitleHero,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
                height: AppValues.lineHeightNormal,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: AppValues.space10),
          ClayButton(
            onPressed: onNext,
            label: cta,
            backgroundColor: AppColors.brandPrimary,
            width: double.infinity,
          ),
        ],
      ),
    );
  }

  // E2: Explore (Interactive Exploration)
  Widget _buildExploreStage(BuildContext context) {
    final instruction = stage.config['instruction'] as String? ??
        'Chạm vào các hình ảnh để khám phá bí mật nhé!';

    return Padding(
      padding: const EdgeInsets.all(AppValues.space9),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            instruction,
            style: const TextStyle(
              fontSize: AppValues.fontTitleMd,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppValues.space9),
          ClayCard(
            borderRadius: AppValues.radiusXl,
            padding: const EdgeInsets.all(AppValues.space9),
            child: Column(
              children: [
                const Icon(
                  Icons.search_rounded,
                  size: 64,
                  color: AppColors.brandSky,
                ),
                const SizedBox(height: AppValues.space7),
                const Text(
                  'Bé hãy quan sát thật kỹ các đặc điểm xung quanh nhé!',
                  style: TextStyle(
                    fontSize: AppValues.fontBodyMd,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppValues.space10),
          ClayButton(
            onPressed: onNext,
            label: AppStrings.btnNextStage,
            backgroundColor: AppColors.brandPrimary,
            width: double.infinity,
          ),
        ],
      ),
    );
  }

  // E3: Explain (Concept Card 3D)
  Widget _buildExplainStage(BuildContext context) {
    final title = stage.config['title'] as String? ?? 'Kiến Thức Trọng Tâm';
    final takeaways = (stage.config['key_takeaways'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        ['Ghi nhớ kiến thức thú vị này nhé!'];

    return Padding(
      padding: const EdgeInsets.all(AppValues.space9),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClayCard(
            borderRadius: AppValues.radiusXl,
            padding: const EdgeInsets.all(AppValues.space9),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppValues.space5),
                  decoration: const BoxDecoration(
                    color: AppColors.brandAmberContainer,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.lightbulb_outline_rounded,
                    size: 36,
                    color: AppColors.brandSecondary,
                  ),
                ),
                const SizedBox(height: AppValues.space7),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: AppValues.fontHeadlineMd,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppValues.space7),
                ...takeaways.map((item) => Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppValues.space2,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.check_circle_rounded,
                            size: 18,
                            color: AppColors.brandMint,
                          ),
                          const SizedBox(width: AppValues.space4),
                          Expanded(
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: AppValues.fontBodyMd,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
          const SizedBox(height: AppValues.space10),
          ClayButton(
            onPressed: onNext,
            label: 'Vận dụng ngay!',
            backgroundColor: AppColors.brandPrimary,
            width: double.infinity,
          ),
        ],
      ),
    );
  }

  // E4: Elaborate (Tactile Mini-Game)
  Widget _buildElaborateStage(BuildContext context) {
    final mechanic = stage.config['mechanic'] as String? ?? 'clay_bubble_popper';

    if (mechanic == 'clay_drag_drop_sorter') {
      return ClayDragDropSorter(
        lessonId: lessonId,
        instruction: stage.config['instruction'] as String? ??
            AppStrings.dragDropInstruction,
        baskets: const [
          SorterBasket(
            id: 'polar',
            title: 'Băng Tuyết',
            themeColor: AppColors.brandSky,
            icon: Icons.ac_unit,
          ),
          SorterBasket(
            id: 'forest',
            title: 'Rừng Rậm',
            themeColor: AppColors.brandMint,
            icon: Icons.park,
          ),
        ],
        items: const [
          SorterItem(
            id: 'polar_bear',
            title: 'Gấu Bắc Cực',
            targetBasketId: 'polar',
            icon: Icons.pets,
          ),
          SorterItem(
            id: 'monkey',
            title: 'Khỉ Rừng',
            targetBasketId: 'forest',
            icon: Icons.cruelty_free,
          ),
          SorterItem(
            id: 'penguin',
            title: 'Chim Cánh Cụt',
            targetBasketId: 'polar',
            icon: Icons.egg,
          ),
        ],
        onCompleted: onGameCompleted,
      );
    }

    if (mechanic == 'clay_scale_balancer') {
      return ClayScaleBalancer(
        lessonId: lessonId,
        instruction: stage.config['instruction'] as String? ??
            AppStrings.scaleBalanceInstruction,
        targetWeight: 7,
        initialLeftWeight: 7,
        initialRightWeight: 3,
        availableWeights: const [2, 4, 6],
        correctWeight: 4,
        onCompleted: onGameCompleted,
      );
    }

    if (mechanic == 'magic_stroke_tracer') {
      return MagicStrokeTracer(
        lessonId: lessonId,
        instruction: stage.config['instruction'] as String? ??
            AppStrings.strokeTraceInstruction,
        guidePoints: const [
          Offset(0.2, 0.5),
          Offset(0.5, 0.2),
          Offset(0.8, 0.5),
        ],
        onCompleted: onGameCompleted,
      );
    }

    if (mechanic == 'clay_card_flipper') {
      return ClayCardFlipper(
        lessonId: lessonId,
        instruction: stage.config['instruction'] as String? ??
            AppStrings.cardFlipInstruction,
        cards: const [
          FlipCardItem(id: 'c1', pairKey: 'bear', title: 'Gấu', icon: Icons.pets),
          FlipCardItem(id: 'c2', pairKey: 'bear', title: 'Gấu', icon: Icons.pets),
          FlipCardItem(id: 'c3', pairKey: 'rabbit', title: 'Thỏ', icon: Icons.cruelty_free),
          FlipCardItem(id: 'c4', pairKey: 'rabbit', title: 'Thỏ', icon: Icons.cruelty_free),
        ],
        onCompleted: onGameCompleted,
      );
    }

    // Default: ClayBubblePopper
    return ClayBubblePopper(
      lessonId: lessonId,
      question: stage.config['instruction'] as String? ??
          AppStrings.bubblePopInstruction,
      bubbles: const [
        BubbleItem(id: 'b1', text: '2 + 2 = 5', isCorrect: false),
        BubbleItem(id: 'b2', text: '3 + 3 = 6', isCorrect: true),
        BubbleItem(id: 'b3', text: '4 + 1 = 6', isCorrect: false),
      ],
      onCompleted: onGameCompleted,
    );
  }

  // E5: Evaluate (Celebration & Completion)
  Widget _buildEvaluateStage(BuildContext context) {
    final quote = stage.config['motivational_quote'] as String? ??
        AppStrings.lessonCompletedCelebrate;

    return Padding(
      padding: const EdgeInsets.all(AppValues.space9),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.celebration_rounded,
            size: 72,
            color: AppColors.brandSecondary,
          ),
          const SizedBox(height: AppValues.space7),
          const Text(
            AppStrings.lessonCompletedCelebrate,
            style: TextStyle(
              fontSize: AppValues.fontHeadlineLg,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppValues.space4),
          Text(
            quote,
            style: const TextStyle(
              fontSize: AppValues.fontBodyMd,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppValues.space9),
          // Badge reward pill
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppValues.space7,
              vertical: AppValues.space4,
            ),
            decoration: BoxDecoration(
              color: AppColors.brandAmberContainer,
              borderRadius: BorderRadius.circular(AppValues.radiusPill),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.star_rounded,
                  size: 24,
                  color: AppColors.brandSecondary,
                ),
                SizedBox(width: AppValues.space4),
                Text(
                  AppStrings.earnedTenStars,
                  style: TextStyle(
                    fontSize: AppValues.fontBodyMd,
                    fontWeight: FontWeight.w700,
                    color: AppColors.brandSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppValues.space11),
          ClayButton(
            onPressed: onNext,
            label: AppStrings.btnCompleteLesson,
            backgroundColor: AppColors.brandMint,
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}
