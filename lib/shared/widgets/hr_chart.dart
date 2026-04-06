import 'package:flutter/material.dart';
import '../../core/health/health_service.dart';

class HrMiniChart extends StatelessWidget {
  final List<HeartRateSample> samples;
  final double height;

  const HrMiniChart({
    super.key,
    required this.samples,
    this.height = 60,
  });

  @override
  Widget build(BuildContext context) {
    if (samples.length < 2) {
      return SizedBox(
        height: height,
        child: const Center(child: Text('Not enough HR data')),
      );
    }

    return SizedBox(
      height: height,
      child: CustomPaint(
        painter: _HrChartPainter(samples: samples),
        size: Size.infinite,
      ),
    );
  }
}

class _HrChartPainter extends CustomPainter {
  final List<HeartRateSample> samples;

  _HrChartPainter({required this.samples});

  @override
  void paint(Canvas canvas, Size size) {
    if (samples.length < 2) return;

    final bpms = samples.map((s) => s.bpm).toList();
    final minBpm = (bpms.reduce((a, b) => a < b ? a : b) - 5).toDouble();
    final maxBpm = (bpms.reduce((a, b) => a > b ? a : b) + 5).toDouble();
    final range = maxBpm - minBpm;
    if (range == 0) return;

    final startTime = samples.first.time.millisecondsSinceEpoch.toDouble();
    final endTime = samples.last.time.millisecondsSinceEpoch.toDouble();
    final timeRange = endTime - startTime;
    if (timeRange == 0) return;

    // Background gradient
    final bgPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.red.withAlpha(30),
          Colors.red.withAlpha(5),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    // Build path
    final path = Path();
    final fillPath = Path();

    for (int i = 0; i < samples.length; i++) {
      final x = ((samples[i].time.millisecondsSinceEpoch - startTime) /
              timeRange) *
          size.width;
      final y = size.height -
          ((samples[i].bpm - minBpm) / range) * (size.height * 0.85) -
          size.height * 0.075;

      if (i == 0) {
        path.moveTo(x, y);
        fillPath.moveTo(x, size.height);
        fillPath.lineTo(x, y);
      } else {
        path.lineTo(x, y);
        fillPath.lineTo(x, y);
      }
    }

    // Fill under the line
    fillPath.lineTo(size.width, size.height);
    fillPath.close();
    final fillPaint = Paint()
      ..color = Colors.red.withAlpha(25)
      ..style = PaintingStyle.fill;
    canvas.drawPath(fillPath, fillPaint);

    // Draw the line
    final linePaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(path, linePaint);

    // Min/max labels
    final avgBpm = bpms.reduce((a, b) => a + b) / bpms.length;
    _drawLabel(canvas, size, '${avgBpm.round()}', Alignment.centerRight);
  }

  void _drawLabel(Canvas canvas, Size size, String text, Alignment align) {
    final tp = TextPainter(
      text: TextSpan(
        text: '$text bpm',
        style: TextStyle(
          color: Colors.red.withAlpha(180),
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    tp.layout();

    final x = align == Alignment.centerRight ? size.width - tp.width - 4 : 4.0;
    tp.paint(canvas, Offset(x, 2));
  }

  @override
  bool shouldRepaint(_HrChartPainter oldDelegate) =>
      oldDelegate.samples.length != samples.length;
}
