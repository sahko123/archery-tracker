import 'package:flutter/material.dart';
import '../../../core/constants/target_dimensions.dart';

class TargetPainter extends CustomPainter {
  final TargetType targetType;

  TargetPainter({required this.targetType});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.shortestSide / 2 * 0.95; // 5% margin

    final boundaries = targetType == TargetType.fullFace
        ? TargetDimensions.fullFaceRingBoundaries
        : TargetDimensions.fiveRingBoundaries;
    final colors = targetType == TargetType.fullFace
        ? TargetDimensions.fullFaceRingColors
        : TargetDimensions.fiveRingColors;
    final lineColors = targetType == TargetType.fullFace
        ? TargetDimensions.fullFaceLineColors
        : TargetDimensions.fiveRingLineColors;

    // Draw from outermost to innermost
    for (int i = boundaries.length - 1; i >= 0; i--) {
      final ringRadius = boundaries[i] * radius;

      // Fill
      final fillPaint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.fill;
      canvas.drawCircle(center, ringRadius, fillPaint);

      // Stroke
      final strokePaint = Paint()
        ..color = lineColors[i]
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0;
      canvas.drawCircle(center, ringRadius, strokePaint);
    }

    // Crosshair
    final crosshairPaint = Paint()
      ..color = Colors.black.withAlpha(80)
      ..strokeWidth = 0.5;
    canvas.drawLine(
      Offset(center.dx - radius, center.dy),
      Offset(center.dx + radius, center.dy),
      crosshairPaint,
    );
    canvas.drawLine(
      Offset(center.dx, center.dy - radius),
      Offset(center.dx, center.dy + radius),
      crosshairPaint,
    );
  }

  @override
  bool shouldRepaint(TargetPainter oldDelegate) => oldDelegate.targetType != targetType;
}
