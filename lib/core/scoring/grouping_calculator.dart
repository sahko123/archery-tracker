import 'dart:math';

class GroupingStats {
  final double centroidX;
  final double centroidY;
  final double meanRadius;
  final double boundingCircleRadius;

  const GroupingStats({
    required this.centroidX,
    required this.centroidY,
    required this.meanRadius,
    required this.boundingCircleRadius,
  });
}

class GroupingCalculator {
  static GroupingStats? calculate(List<({double x, double y})> arrows) {
    if (arrows.length < 2) return null;

    // Centroid
    final centroidX = arrows.map((a) => a.x).reduce((a, b) => a + b) / arrows.length;
    final centroidY = arrows.map((a) => a.y).reduce((a, b) => a + b) / arrows.length;

    // Distances from centroid
    final distances = arrows.map((a) {
      final dx = a.x - centroidX;
      final dy = a.y - centroidY;
      return sqrt(dx * dx + dy * dy);
    }).toList();

    final meanRadius = distances.reduce((a, b) => a + b) / distances.length;
    final boundingCircleRadius = distances.reduce(max);

    return GroupingStats(
      centroidX: centroidX,
      centroidY: centroidY,
      meanRadius: meanRadius,
      boundingCircleRadius: boundingCircleRadius,
    );
  }
}
