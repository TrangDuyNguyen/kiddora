import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kiddora/core/constants/app_colors.dart';
import 'package:kiddora/core/constants/app_strings.dart';
import 'package:kiddora/core/constants/app_values.dart';
import 'package:kiddora/features/exploration/domain/models/game_result.dart';
import 'package:kiddora/shared/ui_kit/surfaces/clay_card.dart';

/// Specification for a target basket in the sorter game
class SorterBasket {
  final String id;
  final String title;
  final Color themeColor;
  final IconData icon;

  const SorterBasket({
    required this.id,
    required this.title,
    required this.themeColor,
    required this.icon,
  });
}

/// Specification for a draggable item to be sorted
class SorterItem {
  final String id;
  final String title;
  final String targetBasketId;
  final String? assetUrl;
  final IconData? icon;

  const SorterItem({
    required this.id,
    required this.title,
    required this.targetBasketId,
    this.assetUrl,
    this.icon,
  });
}

/// Tactile Clay Drag-and-Drop Sorter Widget (Play-Doh Style)
class ClayDragDropSorter extends StatefulWidget {
  final String lessonId;
  final String? instruction;
  final List<SorterBasket> baskets;
  final List<SorterItem> items;
  final ValueChanged<GameResult>? onCompleted;

  const ClayDragDropSorter({
    super.key,
    required this.lessonId,
    this.instruction,
    required this.baskets,
    required this.items,
    this.onCompleted,
  });

  @override
  State<ClayDragDropSorter> createState() => _ClayDragDropSorterState();
}

class _ClayDragDropSorterState extends State<ClayDragDropSorter>
    with SingleTickerProviderStateMixin {
  late final List<SorterItem> _remainingItems;
  final Set<String> _highlightedBasketIds = {};
  Timer? _hintTimer;
  int _hintsUsed = 0;
  int _attemptsCount = 0;
  DateTime? _startTime;
  bool _showHint = false;

  @override
  void initState() {
    super.initState();
    _remainingItems = List.from(widget.items);
    _startTime = DateTime.now();
    _startHintTimer();
  }

  void _startHintTimer() {
    _hintTimer?.cancel();
    _hintTimer = Timer(
      const Duration(seconds: AppValues.gameSmartHintSeconds),
      () {
        if (mounted && _remainingItems.isNotEmpty) {
          setState(() {
            _showHint = true;
            _hintsUsed++;
          });
        }
      },
    );
  }

  void _resetHintTimer() {
    if (_showHint) {
      setState(() => _showHint = false);
    }
    _startHintTimer();
  }

  @override
  void dispose() {
    _hintTimer?.cancel();
    super.dispose();
  }

  void _handleItemDropped(SorterItem item, SorterBasket basket) {
    _attemptsCount++;
    _resetHintTimer();

    if (item.targetBasketId == basket.id) {
      HapticFeedback.lightImpact();
      setState(() {
        _remainingItems.removeWhere((i) => i.id == item.id);
        _highlightedBasketIds.add(basket.id);
      });

      Future.delayed(
        const Duration(milliseconds: AppValues.gameAnimDurationMs),
        () {
          if (mounted) {
            setState(() => _highlightedBasketIds.remove(basket.id));
          }
        },
      );

      if (_remainingItems.isEmpty) {
        final duration = _startTime != null
            ? DateTime.now().difference(_startTime!).inSeconds
            : 0;
        widget.onCompleted?.call(
          GameResult(
            lessonId: widget.lessonId,
            isCompleted: true,
            starsEarned: 10,
            attemptsCount: _attemptsCount,
            hintsUsed: _hintsUsed,
            durationSeconds: duration,
            completedAt: DateTime.now(),
          ),
        );
      }
    } else {
      HapticFeedback.selectionClick();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.instruction != null)
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppValues.space7,
              vertical: AppValues.space4,
            ),
            child: Text(
              widget.instruction!,
              style: const TextStyle(
                fontSize: AppValues.fontBodyMd,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        const SizedBox(height: AppValues.space7),
        // Baskets Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: widget.baskets.map(_buildBasket).toList(),
        ),
        const Spacer(),
        // Draggable Items Dock
        _buildItemsDock(),
      ],
    );
  }

  Widget _buildBasket(SorterBasket basket) {
    final isHighlighted = _highlightedBasketIds.contains(basket.id);
    final isHintTarget = _showHint &&
        _remainingItems.isNotEmpty &&
        _remainingItems.first.targetBasketId == basket.id;

    return DragTarget<SorterItem>(
      onWillAcceptWithDetails: (details) => true,
      onAcceptWithDetails: (details) =>
          _handleItemDropped(details.data, basket),
      builder: (context, candidateData, rejectedData) {
        final isHovered = candidateData.isNotEmpty;

        return AnimatedContainer(
          duration: const Duration(milliseconds: AppValues.gameAnimDurationMs),
          curve: Curves.elasticOut,
          width: AppValues.gameBasketWidth,
          height: AppValues.gameBasketHeight,
          transform: Matrix4.identity()
            ..scale(isHovered || isHighlighted ? 1.05 : 1.0),
          decoration: BoxDecoration(
            color: isHintTarget
                ? AppColors.brandAmberContainer
                : AppColors.surfaceContainer,
            borderRadius: BorderRadius.circular(AppValues.gameBasketRadius),
            border: Border.all(
              color: isHintTarget
                  ? AppColors.brandSecondary
                  : isHovered
                      ? basket.themeColor
                      : basket.themeColor.withValues(alpha: 0.3),
              width: isHovered || isHintTarget
                  ? AppValues.gameBasketBorderWidth
                  : 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: basket.themeColor.withValues(alpha: 0.15),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(basket.icon, size: 36, color: basket.themeColor),
              const SizedBox(height: AppValues.space4),
              Text(
                basket.title,
                style: TextStyle(
                  fontSize: AppValues.fontBodySm,
                  fontWeight: FontWeight.w700,
                  color: basket.themeColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildItemsDock() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppValues.space7,
        vertical: AppValues.space9,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppValues.radiusXl),
        ),
      ),
      child: _remainingItems.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(AppValues.space7),
                child: Text(
                  AppStrings.gameAwesome,
                  style: TextStyle(
                    fontSize: AppValues.fontHeadlineLg,
                    fontWeight: FontWeight.w700,
                    color: AppColors.brandMint,
                  ),
                ),
              ),
            )
          : Wrap(
              alignment: WrapAlignment.center,
              spacing: AppValues.space7,
              runSpacing: AppValues.space4,
              children: _remainingItems.map(_buildDraggableItem).toList(),
            ),
    );
  }

  Widget _buildDraggableItem(SorterItem item) {
    final isHintItem =
        _showHint && _remainingItems.isNotEmpty && _remainingItems.first.id == item.id;

    final childWidget = ClayCard(
      borderRadius: AppValues.gameItemRadius,
      backgroundColor: isHintItem
          ? AppColors.brandAmberContainer
          : AppColors.surfaceContainer,
      child: Container(
        width: AppValues.gameItemSize,
        height: AppValues.gameItemSize,
        padding: const EdgeInsets.all(AppValues.space4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (item.assetUrl != null)
              Image.asset(
                item.assetUrl!,
                width: 32,
                height: 32,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) =>
                    Icon(item.icon ?? Icons.star, size: 28, color: AppColors.brandPrimary),
              )
            else
              Icon(item.icon ?? Icons.star, size: 28, color: AppColors.brandPrimary),
            const SizedBox(height: 2),
            Text(
              item.title,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );

    return Draggable<SorterItem>(
      data: item,
      feedback: Transform.scale(
        scale: AppValues.gameTouchScale,
        child: Material(
          color: Colors.transparent,
          child: childWidget,
        ),
      ),
      childWhenDragging: Opacity(opacity: 0.3, child: childWidget),
      onDragStarted: () => HapticFeedback.selectionClick(),
      child: childWidget,
    );
  }
}
