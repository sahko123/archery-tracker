import 'package:flutter/material.dart';
import '../../../core/scoring/convex_hull.dart';

class GroupingOverlayPainter extends CustomPainter {
  final List<({double x, double y})> arrowPositions;
  final double expansion; // normalized units (e.g. 0.03 = 3% of target radius)

  GroupingOverlayPainter({
    required this.arrowPositions,
    this.expansion = 0.04,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (arrowPositions.length < 2) return;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.shortestSide / 2 * 0.95;

    // Compute convex hull
    var hull = ConvexHull.compute(arrowPositions);
    if (hull.length < 2) return;

    // Expand the hull
    hull = ConvexHull.expand(hull, expansion);

    // Convert to pixel coordinates
    final pixelPoints = hull
        .map((p) => Offset(center.dx + p.x * radius, center.dy + p.y * radius))
        .toList();

    // Draw filled hull with transparency
    final fillPath = Path();
    fillPath.moveTo(pixelPoints.first.dx, pixelPoints.first.dy);
    for (int i = 1; i < pixelPoints.length; i++) {
      fillPath.lineTo(pixelPoints[i].dx, pixelPoints[i].dy);
    }
    fillPath.close();

    // Smooth the shape by drawing with rounded corners
    final fillPaint = Paint()
      ..color = Colors.greenAccent.withAlpha(40)
      ..style = PaintingStyle.fill;
    canvas.drawPath(fillPath, fillPaint);

    // Draw hull outline
    final strokePaint = Paint()
      ..color = Colors.greenAccent.withAlpha(150)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(fillPath, strokePaint);

    // Draw centroid marker
    final cx = arrowPositions.map((p) => p.x).reduce((a, b) => a + b) /
        arrowPositions.length;
    final cy = arrowPositions.map((p) => p.y).reduce((a, b) => a + b) /
        arrowPositions.length;
    final centroidPixel = Offset(center.dx + cx * radius, center.dy + cy * radius);

    final centroidPaint = Paint()
      ..color = Colors.greenAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // Small crosshair at centroid
    const crossSize = 6.0;
    canvas.drawLine(
      Offset(centroidPixel.dx - crossSize, centroidPixel.dy),
      Offset(centroidPixel.dx + crossSize, centroidPixel.dy),
      centroidPaint,
    );
    canvas.drawLine(
      Offset(centroidPixel.dx, centroidPixel.dy - crossSize),
      Offset(centroidPixel.dx, centroidPixel.dy + crossSize),
      centroidPaint,
    );
  }

  @override
  bool shouldRepaint(GroupingOverlayPainter oldDelegate) =>
      oldDelegate.arrowPositions.length != arrowPositions.length;
}
