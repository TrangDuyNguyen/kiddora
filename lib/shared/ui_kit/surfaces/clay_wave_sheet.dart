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
      AppValues.waveSheetTopPadding,
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
    path.moveTo(0, AppValues.waveHeaderEdgeH);
    path.cubicTo(
      size.width * 0.20,
      AppValues.waveHeaderCrestH,
      size.width * 0.35,
      AppValues.waveHeaderDipH,
      size.width * 0.50,
      AppValues.waveHeaderDipH,
    );
    path.cubicTo(
      size.width * 0.65,
      AppValues.waveHeaderDipH,
      size.width * 0.82,
      AppValues.waveHeaderCrestH,
      size.width,
      AppValues.waveHeaderEdgeH,
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
    path.moveTo(0, AppValues.waveHeaderEdgeH);
    path.cubicTo(
      size.width * 0.20,
      AppValues.waveHeaderCrestH,
      size.width * 0.35,
      AppValues.waveHeaderDipH,
      size.width * 0.50,
      AppValues.waveHeaderDipH,
    );
    path.cubicTo(
      size.width * 0.65,
      AppValues.waveHeaderDipH,
      size.width * 0.82,
      AppValues.waveHeaderCrestH,
      size.width,
      AppValues.waveHeaderEdgeH,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    final shadowPaint = Paint()
      ..color = AppColors.shadowIndigoSubtle
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, AppValues.space5);

    canvas.drawPath(
      path.shift(const Offset(0, -AppValues.space1)),
      shadowPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
