import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kiddora/core/constants/app_colors.dart';
import 'package:kiddora/core/constants/app_values.dart';
import 'package:kiddora/features/exploration/domain/models/game_result.dart';

/// Tactile Magic Stroke Tracer Mini-Game Widget
class MagicStrokeTracer extends StatefulWidget {
  final String lessonId;
  final String? instruction;
  final List<Offset> guidePoints;
  final ValueChanged<GameResult>? onCompleted;

  const MagicStrokeTracer({
    super.key,
    required this.lessonId,
    this.instruction,
    required this.guidePoints,
    this.onCompleted,
  });

  @override
  State<MagicStrokeTracer> createState() => _MagicStrokeTracerState();
}

class _MagicStrokeTracerState extends State<MagicStrokeTracer> {
  final List<Offset> _tracedPoints = [];
  final Set<int> _reachedCheckpoints = {};
  DateTime? _startTime;
  bool _isCompleted = false;

  @override
  void initState() {
    super.initState();
    _startTime = DateTime.now();
  }

  void _onPanUpdate(DragUpdateDetails details, Size size) {
    if (_isCompleted) return;

    final localPos = details.localPosition;
    setState(() => _tracedPoints.add(localPos));

    // Check hit against guide points (scaled to canvas size)
    for (int i = 0; i < widget.guidePoints.length; i++) {
      final target = Offset(
        widget.guidePoints[i].dx * size.width,
        widget.guidePoints[i].dy * size.height,
      );
      if ((localPos - target).distance < 36.0) {
        if (!_reachedCheckpoints.contains(i)) {
          HapticFeedback.lightImpact();
          _reachedCheckpoints.add(i);
        }
      }
    }

    // Verify completion (over 80% of guide points covered)
    if (_reachedCheckpoints.length >= (widget.guidePoints.length * 0.8).ceil()) {
      _isCompleted = true;
      HapticFeedback.mediumImpact();

      final duration = _startTime != null
          ? DateTime.now().difference(_startTime!).inSeconds
          : 0;

      widget.onCompleted?.call(
        GameResult(
          lessonId: widget.lessonId,
          isCompleted: true,
          starsEarned: 10,
          durationSeconds: duration,
          completedAt: DateTime.now(),
        ),
      );
    }
  }

  void _onPanEnd(DragEndDetails details) {
    if (!_isCompleted) {
      // Clear trace if not completed, allow retry
      setState(() {
        _tracedPoints.clear();
        _reachedCheckpoints.clear();
      });
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
          child: LayoutBuilder(
            builder: (context, constraints) {
              final size = Size(constraints.maxWidth, constraints.maxHeight);
              return GestureDetector(
                onPanUpdate: (details) => _onPanUpdate(details, size),
                onPanEnd: _onPanEnd,
                child: CustomPaint(
                  size: size,
                  painter: _StrokePainter(
                    guidePoints: widget.guidePoints,
                    tracedPoints: _tracedPoints,
                    reachedCheckpoints: _reachedCheckpoints,
                    isCompleted: _isCompleted,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _StrokePainter extends CustomPainter {
  final List<Offset> guidePoints;
  final List<Offset> tracedPoints;
  final Set<int> reachedCheckpoints;
  final bool isCompleted;

  _StrokePainter({
    required this.guidePoints,
    required this.tracedPoints,
    required this.reachedCheckpoints,
    required this.isCompleted,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final dotPaint = Paint()
      ..color = AppColors.borderDefault
      ..style = PaintingStyle.fill;

    final reachedDotPaint = Paint()
      ..color = isCompleted ? AppColors.brandMint : AppColors.brandSecondary
      ..style = PaintingStyle.fill;

    for (int i = 0; i < guidePoints.length; i++) {
      final pt = Offset(
        guidePoints[i].dx * size.width,
        guidePoints[i].dy * size.height,
      );
      canvas.drawCircle(
        pt,
        8,
        reachedCheckpoints.contains(i) ? reachedDotPaint : dotPaint,
      );
    }

    // Draw user traced stroke with neon magic glow
    if (tracedPoints.length > 1) {
      final glowPaint = Paint()
        ..color = (isCompleted ? AppColors.brandMint : AppColors.gameMagicGlow)
            .withValues(alpha: 0.4)
        ..strokeWidth = AppValues.gameStrokeWidth + 8
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;

      final strokePaint = Paint()
        ..color = isCompleted ? AppColors.brandMint : AppColors.brandPrimary
        ..strokeWidth = AppValues.gameStrokeWidth
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;

      final path = Path()..moveTo(tracedPoints.first.dx, tracedPoints.first.dy);
      for (int i = 1; i < tracedPoints.length; i++) {
        path.lineTo(tracedPoints[i].dx, tracedPoints[i].dy);
      }

      canvas.drawPath(path, glowPaint);
      canvas.drawPath(path, strokePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _StrokePainter oldDelegate) => true;
}
