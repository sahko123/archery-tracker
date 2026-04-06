import 'dart:math';
import '../constants/target_dimensions.dart';

class ScoreCalculator {
  static int calculateScore(double x, double y, TargetType targetType) {
    final distance = sqrt(x * x + y * y);

    final boundaries = targetType == TargetType.fullFace
        ? TargetDimensions.fullFaceRingBoundaries
        : TargetDimensions.fiveRingBoundaries;
    final scores = targetType == TargetType.fullFace
        ? TargetDimensions.fullFaceScores
        : TargetDimensions.fiveRingScores;

    for (int i = 0; i < boundaries.length; i++) {
      if (distance <= boundaries[i]) {
        return scores[i];
      }
    }
    return 0; // miss
  }

  static String scoreToString(int score) {
    if (score == 11) return 'X';
    if (score == 0) return 'M';
    return score.toString();
  }

  static int scoreValue(int score) {
    // X counts as 10 for scoring purposes
    if (score == 11) return 10;
    return score;
  }
}
