import 'package:flutter/material.dart';

enum TargetType {
  fullFace, // 10-ring (1-10 + X)
  fiveRing, // 5-ring (6-10 + X)
}

class TargetDimensions {
  // 10-ring target: equal ring widths at 0.1 intervals
  // Ring boundaries as fraction of target radius (center = 0, edge = 1.0)
  static const List<double> fullFaceRingBoundaries = [
    0.05, // X (inner 10)
    0.10, // 10
    0.20, // 9
    0.30, // 8
    0.40, // 7
    0.50, // 6
    0.60, // 5
    0.70, // 4
    0.80, // 3
    0.90, // 2
    1.00, // 1
  ];

  // Scores corresponding to each boundary (index matches above)
  static const List<int> fullFaceScores = [11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1];

  // 5-ring target: rings 6-10 + X, at 0.2 intervals
  static const List<double> fiveRingBoundaries = [
    0.10, // X
    0.20, // 10
    0.40, // 9
    0.60, // 8
    0.80, // 7
    1.00, // 6
  ];

  static const List<int> fiveRingScores = [11, 10, 9, 8, 7, 6];

  // Ring colors from outside in for full face
  // Rings 1-2: white, 3-4: black, 5-6: blue, 7-8: red, 9-10: gold, X: gold
  static const List<Color> fullFaceRingColors = [
    Color(0xFFFFD700), // X - gold
    Color(0xFFFFD700), // 10 - gold
    Color(0xFFFFD700), // 9 - gold
    Color(0xFFE8302B), // 8 - red
    Color(0xFFE8302B), // 7 - red
    Color(0xFF29ABE2), // 6 - blue
    Color(0xFF29ABE2), // 5 - blue
    Color(0xFF222222), // 4 - black
    Color(0xFF222222), // 3 - black
    Color(0xFFF0F0F0), // 2 - white
    Color(0xFFF0F0F0), // 1 - white
  ];

  // Ring line colors (for visibility against ring color)
  static const List<Color> fullFaceLineColors = [
    Color(0xFF222222), // X
    Color(0xFF222222), // 10
    Color(0xFF222222), // 9
    Color(0xFF222222), // 8
    Color(0xFF222222), // 7
    Color(0xFF222222), // 6
    Color(0xFF222222), // 5
    Color(0xFFFFFFFF), // 4
    Color(0xFFFFFFFF), // 3
    Color(0xFF222222), // 2
    Color(0xFF222222), // 1
  ];

  // 5-ring colors (only inner 5 rings + X)
  static const List<Color> fiveRingColors = [
    Color(0xFFFFD700), // X - gold
    Color(0xFFFFD700), // 10 - gold
    Color(0xFFFFD700), // 9 - gold
    Color(0xFFE8302B), // 8 - red
    Color(0xFFE8302B), // 7 - red
    Color(0xFF29ABE2), // 6 - blue
  ];

  static const List<Color> fiveRingLineColors = [
    Color(0xFF222222), // X
    Color(0xFF222222), // 10
    Color(0xFF222222), // 9
    Color(0xFF222222), // 8
    Color(0xFF222222), // 7
    Color(0xFF222222), // 6
  ];
}
