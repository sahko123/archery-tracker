import 'dart:math';

class ConvexHull {
  /// Computes the convex hull of a set of 2D points using Graham scan.
  /// Returns points in counter-clockwise order.
  static List<({double x, double y})> compute(
      List<({double x, double y})> points) {
    if (points.length < 3) return List.from(points);

    // Find the bottom-most point (lowest y, then leftmost x)
    var pivot = points[0];
    for (final p in points) {
      if (p.y < pivot.y || (p.y == pivot.y && p.x < pivot.x)) {
        pivot = p;
      }
    }

    // Sort by polar angle with respect to pivot
    final sorted = List<({double x, double y})>.from(points);
    sorted.sort((a, b) {
      final angleA = atan2(a.y - pivot.y, a.x - pivot.x);
      final angleB = atan2(b.y - pivot.y, b.x - pivot.x);
      if (angleA != angleB) return angleA.compareTo(angleB);
      // If same angle, closer point first
      final distA = (a.x - pivot.x) * (a.x - pivot.x) +
          (a.y - pivot.y) * (a.y - pivot.y);
      final distB = (b.x - pivot.x) * (b.x - pivot.x) +
          (b.y - pivot.y) * (b.y - pivot.y);
      return distA.compareTo(distB);
    });

    final hull = <({double x, double y})>[];
    for (final p in sorted) {
      while (hull.length >= 2 && _cross(hull[hull.length - 2], hull.last, p) <= 0) {
        hull.removeLast();
      }
      hull.add(p);
    }

    return hull;
  }

  /// Cross product of vectors OA and OB where O is the origin point.
  static double _cross(
      ({double x, double y}) o,
      ({double x, double y}) a,
      ({double x, double y}) b) {
    return (a.x - o.x) * (b.y - o.y) - (a.y - o.y) * (b.x - o.x);
  }

  /// Expands a convex hull outward by [amount] (in the same coordinate space).
  /// Works by moving each edge outward along its normal, then finding
  /// the new intersections.
  static List<({double x, double y})> expand(
      List<({double x, double y})> hull, double amount) {
    if (hull.length < 3) {
      // For 1-2 points, create a circle-like shape around centroid
      if (hull.isEmpty) return hull;
      final cx = hull.map((p) => p.x).reduce((a, b) => a + b) / hull.length;
      final cy = hull.map((p) => p.y).reduce((a, b) => a + b) / hull.length;
      // Return an octagon around the centroid
      final result = <({double x, double y})>[];
      for (int i = 0; i < 8; i++) {
        final angle = i * pi / 4;
        result.add((x: cx + amount * cos(angle), y: cy + amount * sin(angle)));
      }
      return result;
    }

    // Compute centroid
    final cx = hull.map((p) => p.x).reduce((a, b) => a + b) / hull.length;
    final cy = hull.map((p) => p.y).reduce((a, b) => a + b) / hull.length;

    // Expand each point away from centroid
    final expanded = <({double x, double y})>[];
    for (final p in hull) {
      final dx = p.x - cx;
      final dy = p.y - cy;
      final dist = sqrt(dx * dx + dy * dy);
      if (dist == 0) {
        expanded.add(p);
      } else {
        expanded.add((
          x: p.x + (dx / dist) * amount,
          y: p.y + (dy / dist) * amount,
        ));
      }
    }

    return expanded;
  }
}
