import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../shared/ui_kit/ui_kit.dart';
import '../../domain/models/game_result.dart';

/// Factory builder supplying interactive demo instances of the 5 mini-games
class PlaygroundGameBuilder {
  static Widget buildGame({
    required int index,
    required ValueChanged<GameResult> onCompleted,
  }) {
    switch (index) {
      case 0:
        return ClayDragDropSorter(
          lessonId: 'demo_sorter',
          instruction: AppStrings.dragDropInstruction,
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
          onCompleted: onCompleted,
        );
      case 1:
        return ClayScaleBalancer(
          lessonId: 'demo_balancer',
          instruction: AppStrings.scaleBalanceInstruction,
          targetWeight: 7,
          initialLeftWeight: 7,
          initialRightWeight: 3,
          availableWeights: const [2, 4, 6],
          correctWeight: 4,
          onCompleted: onCompleted,
        );
      case 2:
        return ClayBubblePopper(
          lessonId: 'demo_popper',
          question: AppStrings.bubblePopInstruction,
          bubbles: const [
            BubbleItem(id: 'b1', text: '2 + 2 = 5', isCorrect: false),
            BubbleItem(id: 'b2', text: '3 + 3 = 6', isCorrect: true),
            BubbleItem(id: 'b3', text: '4 + 1 = 6', isCorrect: false),
            BubbleItem(id: 'b4', text: '5 + 2 = 7', isCorrect: true),
          ],
          onCompleted: onCompleted,
        );
      case 3:
        return MagicStrokeTracer(
          lessonId: 'demo_tracer',
          instruction: AppStrings.strokeTraceInstruction,
          guidePoints: const [
            Offset(0.2, 0.6),
            Offset(0.5, 0.25),
            Offset(0.8, 0.6),
          ],
          onCompleted: onCompleted,
        );
      case 4:
      default:
        return ClayCardFlipper(
          lessonId: 'demo_flipper',
          instruction: AppStrings.cardFlipInstruction,
          cards: const [
            FlipCardItem(
              id: 'c1',
              pairKey: 'bear',
              title: 'Gấu',
              icon: Icons.pets,
            ),
            FlipCardItem(
              id: 'c2',
              pairKey: 'rabbit',
              title: 'Thỏ',
              icon: Icons.cruelty_free,
            ),
            FlipCardItem(
              id: 'c3',
              pairKey: 'bear',
              title: 'Gấu',
              icon: Icons.pets,
            ),
            FlipCardItem(
              id: 'c4',
              pairKey: 'rabbit',
              title: 'Thỏ',
              icon: Icons.cruelty_free,
            ),
          ],
          onCompleted: onCompleted,
        );
    }
  }
}

