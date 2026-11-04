import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kiddora/core/constants/app_colors.dart';
import 'package:kiddora/core/constants/app_strings.dart';
import 'package:kiddora/core/constants/app_values.dart';
import 'package:kiddora/features/exploration/domain/models/game_result.dart';
import 'package:kiddora/shared/ui_kit/surfaces/clay_card.dart';

/// Tactile Scale Balancer Mini-Game Widget (Play-Doh Style)
class ClayScaleBalancer extends StatefulWidget {
  final String lessonId;
  final String? instruction;
  final int targetWeight;
  final int initialLeftWeight;
  final int initialRightWeight;
  final List<int> availableWeights;
  final int correctWeight;
  final ValueChanged<GameResult>? onCompleted;

  const ClayScaleBalancer({
    super.key,
    required this.lessonId,
    this.instruction,
    required this.targetWeight,
    required this.initialLeftWeight,
    required this.initialRightWeight,
    required this.availableWeights,
    required this.correctWeight,
    this.onCompleted,
  });

  @override
  State<ClayScaleBalancer> createState() => _ClayScaleBalancerState();
}

class _ClayScaleBalancerState extends State<ClayScaleBalancer>
    with SingleTickerProviderStateMixin {
  late int _rightWeight;
  int? _chosenWeight;
  int _attemptsCount = 0;
  DateTime? _startTime;
  bool _isBalanced = false;

  @override
  void initState() {
    super.initState();
    _rightWeight = widget.initialRightWeight;
    _startTime = DateTime.now();
  }

  void _selectWeight(int weight) {
    if (_isBalanced) return;

    _attemptsCount++;
    setState(() {
      _chosenWeight = weight;
      _rightWeight = widget.initialRightWeight + weight;
      _isBalanced = _rightWeight == widget.initialLeftWeight;
    });

    if (_isBalanced) {
      HapticFeedback.mediumImpact();
      final duration = _startTime != null
          ? DateTime.now().difference(_startTime!).inSeconds
          : 0;

      Future.delayed(
        const Duration(milliseconds: AppValues.gameAnimDurationMs + 200),
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
    } else {
      HapticFeedback.lightImpact();
    }
  }

  double _calculateTiltAngle() {
    final diff = widget.initialLeftWeight - _rightWeight;
    if (diff == 0) return 0.0;
    // Max tilt angle capped at ~0.18 radians (approx 10 degrees)
    return (diff > 0 ? -0.18 : 0.18);
  }

  @override
  Widget build(BuildContext context) {
    final angle = _calculateTiltAngle();

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
        const SizedBox(height: AppValues.space9),
        // Balance Scale Visual
        _buildScaleVisual(angle),
        const Spacer(),
        // Weights Options Tray
        _buildWeightsTray(),
      ],
    );
  }

  Widget _buildScaleVisual(double angle) {
    return SizedBox(
      height: 220,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Center Fulcrum (Pillar)
          Positioned(
            bottom: 20,
            child: Container(
              width: 32,
              height: AppValues.gameScalePillarHeight,
              decoration: BoxDecoration(
                color: AppColors.gameScaleFulcrum,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.clayShadow,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
            ),
          ),
          // Animated Tilting Beam with Pans
          Positioned(
            top: 40,
            child: AnimatedRotation(
              turns: angle / (2 * 3.14159),
              duration: const Duration(milliseconds: AppValues.gameAnimDurationMs + 100),
              curve: Curves.elasticOut,
              child: SizedBox(
                width: AppValues.gameScaleBeamWidth,
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    // Horizontal Beam
                    Container(
                      height: AppValues.gameScaleBeamHeight,
                      decoration: BoxDecoration(
                        color: _isBalanced
                            ? AppColors.brandSecondary
                            : AppColors.gameScaleBeam,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          if (_isBalanced)
                            BoxShadow(
                              color: AppColors.brandSecondary.withValues(alpha: 0.5),
                              blurRadius: 12,
                              spreadRadius: 2,
                            ),
                        ],
                      ),
                    ),
                    // Left Pan
                    Positioned(
                      left: 0,
                      top: 6,
                      child: _buildPan(
                        weight: widget.initialLeftWeight,
                        isTarget: false,
                      ),
                    ),
                    // Right Pan
                    Positioned(
                      right: 0,
                      top: 6,
                      child: _buildPan(
                        weight: _rightWeight,
                        isTarget: true,
                        chosen: _chosenWeight,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPan({required int weight, required bool isTarget, int? chosen}) {
    return Column(
      children: [
        Container(
          width: 2,
          height: 35,
          color: AppColors.borderDefault,
        ),
        ClayCard(
          borderRadius: 16,
          backgroundColor: isTarget && _isBalanced
              ? AppColors.brandMintContainer
              : AppColors.surfaceContainer,
          child: Container(
            width: AppValues.gameScalePanSize,
            height: 60,
            padding: const EdgeInsets.all(AppValues.space4),
            child: Center(
              child: Text(
                '$weight',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: isTarget && _isBalanced
                      ? AppColors.brandMint
                      : AppColors.brandPrimary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWeightsTray() {
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
      child: Column(
        children: [
          const Text(
            AppStrings.scaleBalanceInstruction,
            style: TextStyle(
              fontSize: AppValues.fontBodySm,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppValues.space7),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: widget.availableWeights.map((w) {
              final isSelected = _chosenWeight == w;
              return ClayCard(
                onTap: () => _selectWeight(w),
                borderRadius: AppValues.gameItemRadius,
                backgroundColor: isSelected
                    ? AppColors.brandIndigoContainer
                    : AppColors.surfaceContainer,
                child: Container(
                  width: AppValues.gameItemSize,
                  height: AppValues.gameItemSize,
                  alignment: Alignment.center,
                  child: Text(
                    '+$w',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: isSelected
                          ? AppColors.brandPrimary
                          : AppColors.textPrimary,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
