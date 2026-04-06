import 'package:flutter/material.dart';
import '../../../core/scoring/score_calculator.dart';

class ArrowPlacement {
  final double x; // normalized -1 to 1
  final double y; // normalized -1 to 1
  final int score;
  final int arrowNumber;
  final int? dbId;

  const ArrowPlacement({
    required this.x,
    required this.y,
    required this.score,
    required this.arrowNumber,
    this.dbId,
  });
}

class ArrowMarkerPainter extends CustomPainter {
  final List<ArrowPlacement> arrows;
  final ArrowPlacement? pendingArrow; // arrow being dragged

  ArrowMarkerPainter({required this.arrows, this.pendingArrow});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.shortestSide / 2 * 0.95;

    // Draw confirmed arrows
    for (final arrow in arrows) {
      _drawArrow(canvas, center, radius, arrow, false);
    }

    // Draw pending arrow (being dragged)
    if (pendingArrow != null) {
      _drawArrow(canvas, center, radius, pendingArrow!, true);
    }
  }

  void _drawArrow(Canvas canvas, Offset center, double radius,
      ArrowPlacement arrow, bool isPending) {
    final pixelX = center.dx + arrow.x * radius;
    final pixelY = center.dy + arrow.y * radius;
    final pos = Offset(pixelX, pixelY);

    // Outer circle (white border)
    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(pos, 8, borderPaint);

    // Inner circle
    final fillPaint = Paint()
      ..color = isPending ? Colors.orange : Colors.green
      ..style = PaintingStyle.fill;
    canvas.drawCircle(pos, 6, fillPaint);

    // Arrow number text
    final textPainter = TextPainter(
      text: TextSpan(
        text: ScoreCalculator.scoreToString(arrow.score),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(pixelX - textPainter.width / 2, pixelY - 22),
    );
  }

  @override
  bool shouldRepaint(ArrowMarkerPainter oldDelegate) =>
      oldDelegate.arrows.length != arrows.length ||
      oldDelegate.pendingArrow != pendingArrow;
}
