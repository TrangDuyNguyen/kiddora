import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_values.dart';

/// Tactile Clay Wave Bottom Sheet — DESIGN.md Level 1 Porcelain
///
/// Provides a soft, undulating organic wave curve at the top edge that
/// seamlessly nests under 3D character illustrations, with specular highlights
/// and soft ambient shadow, extending completely to the bottom of the device.
class ClayWaveSheet extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const ClayWaveSheet({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.fromLTRB(
      AppValues.space8,
      AppValues.space9,
      AppValues.space8,
      AppValues.space8,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: const ClayWaveShadowPainter(),
      child: ClipPath(
        clipper: const ClayWaveClipper(),
        child: Container(
          width: double.infinity,
          color: Colors.white,
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}

/// Organic Wave Clipper forming natural S-Curve top edge
class ClayWaveClipper extends CustomClipper<Path> {
  const ClayWaveClipper();

  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, AppValues.waveHeaderDipH);
    path.cubicTo(
      size.width * 0.18,
      AppValues.space2,
      size.width * 0.38,
      AppValues.waveHeaderDipH + AppValues.space5,
      size.width * 0.58,
      AppValues.waveHeaderDipH + AppValues.space5,
    );
    path.cubicTo(
      size.width * 0.74,
      AppValues.waveHeaderDipH + AppValues.space5,
      size.width * 0.86,
      AppValues.space5,
      size.width,
      AppValues.waveHeaderDipH,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

/// Ambient Shadow Painter along the organic wave curve
class ClayWaveShadowPainter extends CustomPainter {
  const ClayWaveShadowPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(0, AppValues.waveHeaderDipH);
    path.cubicTo(
      size.width * 0.18,
      AppValues.space2,
      size.width * 0.38,
      AppValues.waveHeaderDipH + AppValues.space5,
      size.width * 0.58,
      AppValues.waveHeaderDipH + AppValues.space5,
    );
    path.cubicTo(
      size.width * 0.74,
      AppValues.waveHeaderDipH + AppValues.space5,
      size.width * 0.86,
      AppValues.space5,
      size.width,
      AppValues.waveHeaderDipH,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    final shadowPaint = Paint()
      ..color = AppColors.shadowIndigoSubtle
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, AppValues.space7);

    canvas.drawPath(
      path.shift(const Offset(0, -AppValues.space2)),
      shadowPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
