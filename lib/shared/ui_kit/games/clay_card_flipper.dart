import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kiddora/core/constants/app_colors.dart';
import 'package:kiddora/core/constants/app_values.dart';
import 'package:kiddora/features/exploration/domain/models/game_result.dart';
import 'package:kiddora/shared/ui_kit/surfaces/clay_card.dart';

/// Item specification for a flippable matching card
class FlipCardItem {
  final String id;
  final String pairKey;
  final String title;
  final IconData? icon;
  final String? assetUrl;

  const FlipCardItem({
    required this.id,
    required this.pairKey,
    required this.title,
    this.icon,
    this.assetUrl,
  });
}

/// Tactile 3D Card Flipper Memory Mini-Game Widget
class ClayCardFlipper extends StatefulWidget {
  final String lessonId;
  final String? instruction;
  final List<FlipCardItem> cards;
  final ValueChanged<GameResult>? onCompleted;

  const ClayCardFlipper({
    super.key,
    required this.lessonId,
    this.instruction,
    required this.cards,
    this.onCompleted,
  });

  @override
  State<ClayCardFlipper> createState() => _ClayCardFlipperState();
}

class _ClayCardFlipperState extends State<ClayCardFlipper> {
  final Set<String> _revealedCardIds = {};
  final Set<String> _matchedCardIds = {};
  final List<FlipCardItem> _currentlyFlipped = [];
  bool _isProcessingMatch = false;
  int _attemptsCount = 0;
  DateTime? _startTime;

  @override
  void initState() {
    super.initState();
    _startTime = DateTime.now();
  }

  void _handleCardTap(FlipCardItem card) {
    if (_isProcessingMatch ||
        _matchedCardIds.contains(card.id) ||
        _revealedCardIds.contains(card.id)) {
      return;
    }

    HapticFeedback.selectionClick();
    setState(() {
      _revealedCardIds.add(card.id);
      _currentlyFlipped.add(card);
    });

    if (_currentlyFlipped.length == 2) {
      _attemptsCount++;
      _isProcessingMatch = true;

      final card1 = _currentlyFlipped[0];
      final card2 = _currentlyFlipped[1];

      if (card1.pairKey == card2.pairKey) {
        // Matched!
        HapticFeedback.lightImpact();
        setState(() {
          _matchedCardIds.add(card1.id);
          _matchedCardIds.add(card2.id);
          _currentlyFlipped.clear();
          _isProcessingMatch = false;
        });

        // Check overall completion
        if (_matchedCardIds.length == widget.cards.length) {
          final duration = _startTime != null
              ? DateTime.now().difference(_startTime!).inSeconds
              : 0;
          widget.onCompleted?.call(
            GameResult(
              lessonId: widget.lessonId,
              isCompleted: true,
              starsEarned: 10,
              attemptsCount: _attemptsCount,
              durationSeconds: duration,
              completedAt: DateTime.now(),
            ),
          );
        }
      } else {
        // Not matched: flip back after delay
        Future.delayed(const Duration(milliseconds: 800), () {
          if (mounted) {
            setState(() {
              _revealedCardIds.remove(card1.id);
              _revealedCardIds.remove(card2.id);
              _currentlyFlipped.clear();
              _isProcessingMatch = false;
            });
          }
        });
      }
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
        Expanded(
          child: Center(
            child: SingleChildScrollView(
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: AppValues.space7,
                runSpacing: AppValues.space7,
                children: widget.cards.map((card) {
                  final isRevealed = _revealedCardIds.contains(card.id);
                  final isMatched = _matchedCardIds.contains(card.id);
                  return _buildCardWidget(card, isRevealed, isMatched);
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCardWidget(FlipCardItem card, bool isRevealed, bool isMatched) {
    return SizedBox(
      key: ValueKey('flip_card_${card.id}'),
      width: AppValues.gameCardWidth,
      height: AppValues.gameCardHeight,
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0.0, end: isRevealed ? 1.0 : 0.0),
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        builder: (context, value, child) {
          final isBack = value < 0.5;
          final angle = value * math.pi;

          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()..rotateY(angle),
            child: isBack
                ? _buildBackFace(card)
                : Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..rotateY(math.pi),
                    child: _buildFrontFace(card, isMatched),
                  ),
          );
        },
      ),
    );
  }

  Widget _buildBackFace(FlipCardItem card) {
    return ClayCard(
      onTap: () => _handleCardTap(card),
      padding: EdgeInsets.zero,
      borderRadius: AppValues.gameCardRadius,
      backgroundColor: AppColors.gameCardBack,
      child: const Center(
        child: Icon(
          Icons.star_rounded,
          size: 36,
          color: AppColors.surfaceContainer,
        ),
      ),
    );
  }

  Widget _buildFrontFace(FlipCardItem card, bool isMatched) {
    return ClayCard(
      padding: const EdgeInsets.all(AppValues.space2),
      borderRadius: AppValues.gameCardRadius,
      backgroundColor: isMatched ? AppColors.brandMintContainer : AppColors.surfaceContainer,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (card.assetUrl != null)
            Image.asset(
              card.assetUrl!,
              width: 32,
              height: 32,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) =>
                  Icon(card.icon ?? Icons.auto_awesome, size: 28, color: AppColors.brandPrimary),
            )
          else
            Icon(card.icon ?? Icons.auto_awesome, size: 28, color: AppColors.brandPrimary),
          const SizedBox(height: AppValues.space2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppValues.space2),
            child: Text(
              card.title,
              style: TextStyle(
                fontSize: AppValues.fontCaptionSm,
                fontWeight: FontWeight.w700,
                color: isMatched
                    ? AppColors.brandMint
                    : AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
