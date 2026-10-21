import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

/// Paints true CSS-style inset shadows on a rounded rectangle to achieve
/// the Tactile Claymorphism dual-axis illumination from DESIGN.md §2.5:
///
///   Specular Rim (Top-Left):  inset  3px  3px  5px rgba(255,255,255,0.85)
///   Bevel Shade (Bottom-Right): inset -3px -3px  5px rgba(13,12,34, 0.06)
///
/// Flutter's [BoxDecoration.boxShadow] only draws outer shadows, so this
/// painter fills that gap by clipping to the shape and drawing offset blurred
/// rectangles that simulate inner glow / inner shade.
class ClayInsetPainter extends CustomPainter {
  const ClayInsetPainter({
    required this.borderRadius,
    this.highlightColor = AppColors.clayHighlight,
    this.shadeColor = AppColors.clayShade,
    this.highlightOffset = const Offset(3, 3),
    this.shadeOffset = const Offset(-3, -3),
    this.highlightBlur = 5.0,
    this.shadeBlur = 5.0,
    this.isCircle = false,
  });

  final double borderRadius;
  final Color highlightColor;
  final Color shadeColor;
  final Offset highlightOffset;
  final Offset shadeOffset;
  final double highlightBlur;
  final double shadeBlur;
  final bool isCircle;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    final RRect clipRRect;
    if (isCircle) {
      final radius = size.shortestSide / 2;
      clipRRect = RRect.fromRectAndRadius(rect, Radius.circular(radius));
    } else {
      clipRRect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));
    }

    canvas.save();
    canvas.clipRRect(clipRRect);

    // 1. Specular Rim (top-left highlight) — inset white glow
    _paintInsetShadow(
      canvas,
      rect,
      offset: highlightOffset,
      blur: highlightBlur,
      color: highlightColor,
    );

    // 2. Bevel Shade (bottom-right) — inset compression shadow
    _paintInsetShadow(
      canvas,
      rect,
      offset: shadeOffset,
      blur: shadeBlur,
      color: shadeColor,
    );

    canvas.restore();
  }

  void _paintInsetShadow(
    Canvas canvas,
    Rect rect, {
    required Offset offset,
    required double blur,
    required Color color,
  }) {
    // Draw a large rect around the clipped area with a hole punched out,
    // then blur it. The "shadow" bleeds inward from the edges.
    final sigma = ui.Shadow.convertRadiusToSigma(blur);
    final paint = Paint()
      ..color = color
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, sigma);

    // Outer encompassing rect (big enough to cover blur spread)
    final outer = rect.inflate(blur * 2 + 20);
    // Inner rect shifted by offset — the "hole" through which light/shadow
    // does NOT appear, creating the inset effect.
    final inner = rect.shift(offset);

    // Path = outer minus inner → shadow only appears at the edges
    final path = Path()
      ..addRect(outer)
      ..addRect(inner);
    path.fillType = PathFillType.evenOdd;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant ClayInsetPainter oldDelegate) =>
      oldDelegate.borderRadius != borderRadius ||
      oldDelegate.highlightColor != highlightColor ||
      oldDelegate.shadeColor != shadeColor ||
      oldDelegate.highlightOffset != highlightOffset ||
      oldDelegate.shadeOffset != shadeOffset ||
      oldDelegate.highlightBlur != highlightBlur ||
      oldDelegate.shadeBlur != shadeBlur ||
      oldDelegate.isCircle != isCircle;
}
