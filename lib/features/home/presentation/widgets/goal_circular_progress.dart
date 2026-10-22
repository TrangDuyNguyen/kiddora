import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';

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
      width: 220,
      height: 220,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Whimsical yellow sparkles around ring
          CustomPaint(
            size: const Size(220, 220),
            painter: _SparklesPainter(),
          ),

          // Circular Ring Progress
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.0, end: progress),
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOutCubic,
            builder: (context, animatedValue, child) {
              return CustomPaint(
                size: const Size(180, 180),
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
                width: 52,
                height: 52,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 4),
              Text(
                '$completedCount of $totalCount',
                style: GoogleFonts.quicksand(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF1E1B4B),
                ),
              ),
              Text(
                'Tasks Completed',
                style: GoogleFonts.quicksand(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF6E6D7A),
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
    final radius = (size.width - 16) / 2;
    const strokeWidth = 14.0;

    // Track Paint
    final trackPaint = Paint()
      ..color = const Color(0xFFEDE9FE)
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
          Color(0xFF818CF8),
          AppColors.brandPrimary,
          Color(0xFF4F46E5),
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
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final sparklePaint = Paint()
      ..color = const Color(0xFFFBBF24)
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round;

    // Fixed confetti sparkle ray angles
    final angles = [-1.3, -0.6, 0.4, 0.9, 2.2, 2.7, 3.8];
    for (final angle in angles) {
      final startR = (size.width / 2) - 8;
      final endR = (size.width / 2) + 2;
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
