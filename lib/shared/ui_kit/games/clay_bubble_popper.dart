import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kiddora/core/constants/app_colors.dart';
import 'package:kiddora/core/constants/app_values.dart';
import 'package:kiddora/features/exploration/domain/models/game_result.dart';

/// Item specification for a floating clay bubble
class BubbleItem {
  final String id;
  final String text;
  final bool isCorrect;

  const BubbleItem({
    required this.id,
    required this.text,
    required this.isCorrect,
  });
}

/// Tactile Clay Bubble Popper Mini-Game Widget
class ClayBubblePopper extends StatefulWidget {
  final String lessonId;
  final String? question;
  final List<BubbleItem> bubbles;
  final ValueChanged<GameResult>? onCompleted;

  const ClayBubblePopper({
    super.key,
    required this.lessonId,
    this.question,
    required this.bubbles,
    this.onCompleted,
  });

  @override
  State<ClayBubblePopper> createState() => _ClayBubblePopperState();
}

class _ClayBubblePopperState extends State<ClayBubblePopper>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  final Set<String> _poppedBubbleIds = {};
  final Set<String> _wigglingBubbleIds = {};
  int _attemptsCount = 0;
  DateTime? _startTime;

  @override
  void initState() {
    super.initState();
    _startTime = DateTime.now();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _handleTapBubble(BubbleItem bubble) {
    if (_poppedBubbleIds.contains(bubble.id)) return;

    _attemptsCount++;
    if (bubble.isCorrect) {
      HapticFeedback.lightImpact();
      setState(() => _poppedBubbleIds.add(bubble.id));

      final remainingCorrect = widget.bubbles
          .where((b) => b.isCorrect && !_poppedBubbleIds.contains(b.id))
          .isEmpty;

      if (remainingCorrect) {
        final duration = _startTime != null
            ? DateTime.now().difference(_startTime!).inSeconds
            : 0;
        Future.delayed(
          const Duration(milliseconds: AppValues.gameAnimDurationMs + 100),
          () {
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
          },
        );
      }
    } else {
      HapticFeedback.selectionClick();
      setState(() => _wigglingBubbleIds.add(bubble.id));
      Future.delayed(const Duration(milliseconds: 400), () {
        if (mounted) {
          setState(() => _wigglingBubbleIds.remove(bubble.id));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.question != null)
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppValues.space7,
              vertical: AppValues.space4,
            ),
            child: Text(
              widget.question!,
              style: const TextStyle(
                fontSize: AppValues.fontBodyMd,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        const SizedBox(height: AppValues.space9),
        Expanded(
          child: AnimatedBuilder(
            animation: _animController,
            builder: (context, child) {
              return Stack(
                alignment: Alignment.center,
                children: widget.bubbles.asMap().entries.map((entry) {
                  final index = entry.key;
                  final bubble = entry.value;
                  return _buildFloatingBubble(bubble, index);
                }).toList(),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFloatingBubble(BubbleItem bubble, int index) {
    if (_poppedBubbleIds.contains(bubble.id)) {
      return const SizedBox.shrink();
    }

    final isWiggling = _wigglingBubbleIds.contains(bubble.id);
    final phase = index * (2 * math.pi / widget.bubbles.length);
    final waveOffset = math.sin(_animController.value * 2 * math.pi + phase) * 16.0;

    // Distribute horizontally
    final total = widget.bubbles.length;
    final horizontalFraction = (index + 0.5) / total;

    return Align(
      alignment: Alignment(
        (horizontalFraction * 2) - 1.0,
        (waveOffset / 60.0) + (index.isEven ? -0.2 : 0.2),
      ),
      child: GestureDetector(
        onTap: () => _handleTapBubble(bubble),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.identity()
            ..rotateZ(isWiggling ? 0.1 : 0.0),
          width: AppValues.gameBubbleSize,
          height: AppValues.gameBubbleSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.gameBubbleBg,
            border: Border.all(
              color: isWiggling
                  ? AppColors.feedbackError
                  : AppColors.gameBubbleBorder,
              width: 3,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.brandPrimary.withValues(alpha: 0.15),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
              const BoxShadow(
                color: AppColors.surfaceContainer,
                blurRadius: 4,
                offset: Offset(-2, -2),
              ),
            ],
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(AppValues.space4),
              child: Text(
                bubble.text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.brandPrimary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
