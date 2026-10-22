import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_values.dart';

class GoalCircularProgress extends StatelessWidget {
  final int completedCount;
  final int totalCount;
  final double progress;

  const GoalCircularProgress({
    super.key,
    required this.completedCount,
    required this.totalCount,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppValues.sizeGoalProgressBox,
      height: AppValues.sizeGoalProgressBox,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Whimsical sparkles around ring
          const CustomPaint(
            size: Size(
              AppValues.sizeGoalProgressBox,
              AppValues.sizeGoalProgressBox,
            ),
            painter: _SparklesPainter(),
          ),

          // Circular Ring Progress
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.0, end: progress),
            duration: AppValues.durationPageTransition,
            curve: Curves.easeOutCubic,
            builder: (context, animatedValue, child) {
              return CustomPaint(
                size: const Size(AppValues.sizeGoalRing, AppValues.sizeGoalRing),
                painter: _RingProgressPainter(progress: animatedValue),
              );
            },
          ),

          // Center Content: 3D Mascot Star + Counts
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/mascot_star_goal.png',
                width: AppValues.sizeGoalMascotStar,
                height: AppValues.sizeGoalMascotStar,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: AppValues.radiusXs),
              Text(
                '$completedCount${AppStrings.ofSeparator}$totalCount',
                style: GoogleFonts.quicksand(
                  fontSize: AppValues.fontHeadlineLg,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDarkIndigo,
                ),
              ),
              Text(
                AppStrings.tasksCompleted,
                style: GoogleFonts.quicksand(
                  fontSize: AppValues.fontBodySm,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSlate,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RingProgressPainter extends CustomPainter {
  final double progress;

  _RingProgressPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - AppValues.space7) / 2;
    const strokeWidth = AppValues.strokeWidthRing;

    // Track Paint
    final trackPaint = Paint()
      ..color = AppColors.ringTrackLavender
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, trackPaint);

    if (progress > 0) {
      // Progress Arc Paint with Gradient
      final rect = Rect.fromCircle(center: center, radius: radius);
      final gradient = SweepGradient(
        startAngle: -math.pi / 2,
        endAngle: 3 * math.pi / 2,
        colors: const [
          AppColors.ringArcPurple,
          AppColors.brandPrimary,
          AppColors.ringArcIndigo,
        ],
      );

      final progressPaint = Paint()
        ..shader = gradient.createShader(rect)
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      final sweepAngle = 2 * math.pi * progress.clamp(0.0, 1.0);
      canvas.drawArc(
        rect,
        -math.pi / 2,
        sweepAngle,
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _RingProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class _SparklesPainter extends CustomPainter {
  const _SparklesPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final sparklePaint = Paint()
      ..color = AppColors.stateWarningAmber
      ..strokeWidth = AppValues.strokeWidthSparkle
      ..strokeCap = StrokeCap.round;

    // Fixed confetti sparkle ray angles
    final angles = [-1.3, -0.6, 0.4, 0.9, 2.2, 2.7, 3.8];
    for (final angle in angles) {
      final startR = (size.width / 2) - AppValues.radiusMd;
      final endR = (size.width / 2) + AppValues.borderWidthThick;
      final p1 = Offset(
        center.dx + startR * math.cos(angle),
        center.dy + startR * math.sin(angle),
      );
      final p2 = Offset(
        center.dx + endR * math.cos(angle),
        center.dy + endR * math.sin(angle),
      );
      canvas.drawLine(p1, p2, sparklePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
