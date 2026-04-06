import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/target_dimensions.dart';
import '../../../core/scoring/score_calculator.dart';
import 'target_painter.dart';
import 'arrow_marker_painter.dart';

class InteractiveTarget extends StatefulWidget {
  final TargetType targetType;
  final List<ArrowPlacement> arrows;
  final bool enabled;
  final void Function(double x, double y, int score)? onArrowPlaced;

  const InteractiveTarget({
    super.key,
    required this.targetType,
    required this.arrows,
    this.enabled = true,
    this.onArrowPlaced,
  });

  @override
  State<InteractiveTarget> createState() => _InteractiveTargetState();
}

class _InteractiveTargetState extends State<InteractiveTarget> {
  ArrowPlacement? _pendingArrow;
  // Offset the arrow position above the finger so it's visible
  static const double _fingerOffset = 160.0;

  Offset _toNormalized(Offset localPosition, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.shortestSide / 2 * 0.95;
    return Offset(
      (localPosition.dx - center.dx) / radius,
      (localPosition.dy - _fingerOffset - center.dy) / radius,
    );
  }

  void _handlePanStart(DragStartDetails details, Size size) {
    if (!widget.enabled) return;
    final normalized = _toNormalized(details.localPosition, size);
    final score = ScoreCalculator.calculateScore(
        normalized.dx, normalized.dy, widget.targetType);
    setState(() {
      _pendingArrow = ArrowPlacement(
        x: normalized.dx,
        y: normalized.dy,
        score: score,
        arrowNumber: widget.arrows.length + 1,
      );
    });
  }

  void _handlePanUpdate(DragUpdateDetails details, Size size) {
    if (!widget.enabled || _pendingArrow == null) return;
    final normalized = _toNormalized(details.localPosition, size);
    final score = ScoreCalculator.calculateScore(
        normalized.dx, normalized.dy, widget.targetType);
    setState(() {
      _pendingArrow = ArrowPlacement(
        x: normalized.dx,
        y: normalized.dy,
        score: score,
        arrowNumber: widget.arrows.length + 1,
      );
    });
  }

  void _handlePanEnd(DragEndDetails details) {
    if (!widget.enabled || _pendingArrow == null) return;
    HapticFeedback.mediumImpact();
    widget.onArrowPlaced?.call(
      _pendingArrow!.x,
      _pendingArrow!.y,
      _pendingArrow!.score,
    );
    setState(() {
      _pendingArrow = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxWidth);
        return SizedBox(
          width: size.width,
          height: size.height,
          child: GestureDetector(
            onPanStart: (d) => _handlePanStart(d, size),
            onPanUpdate: (d) => _handlePanUpdate(d, size),
            onPanEnd: _handlePanEnd,
            child: CustomPaint(
              painter: TargetPainter(targetType: widget.targetType),
              foregroundPainter: ArrowMarkerPainter(
                arrows: widget.arrows,
                pendingArrow: _pendingArrow,
              ),
              size: size,
            ),
          ),
        );
      },
    );
  }
}
