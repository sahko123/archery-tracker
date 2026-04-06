import 'package:flutter/material.dart';
import '../../../core/constants/target_dimensions.dart';
import '../../../core/database/app_database.dart';
import '../../../core/scoring/score_calculator.dart';
import '../../../core/scoring/grouping_calculator.dart';
import '../../../core/health/health_service.dart';
import '../../../shared/widgets/hr_chart.dart';
import '../../target/widgets/arrow_marker_painter.dart';
import '../../target/widgets/target_painter.dart';
import '../../target/widgets/grouping_overlay_painter.dart';
import '../../../app/router.dart';

class SessionSummaryScreen extends StatefulWidget {
  final AppDatabase database;
  final int sessionId;
  final bool fromSession; // true when coming from active session, false from history

  const SessionSummaryScreen({
    super.key,
    required this.database,
    required this.sessionId,
    this.fromSession = false,
  });

  @override
  State<SessionSummaryScreen> createState() => _SessionSummaryScreenState();
}

class _SessionSummaryScreenState extends State<SessionSummaryScreen> {
  Session? _session;
  List<End> _ends = [];
  Map<int, List<Arrow>> _arrowsByEnd = {};
  List<Arrow> _allArrows = [];
  GroupingStats? _groupingStats;
  Map<int, List<HeartRateSample>> _hrSamplesByEnd = {};
  final HealthService _healthService = HealthService();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final session = await widget.database.getSession(widget.sessionId);
    final ends = await widget.database.getEndsForSession(widget.sessionId);
    final arrowsByEnd = <int, List<Arrow>>{};
    final allArrows = <Arrow>[];

    for (final end in ends) {
      final arrows = await widget.database.getArrowsForEnd(end.id);
      arrowsByEnd[end.id] = arrows;
      allArrows.addAll(arrows);
    }

    // Calculate grouping for all arrows
    GroupingStats? grouping;
    if (allArrows.length >= 2) {
      grouping = GroupingCalculator.calculate(
        allArrows.map((a) => (x: a.x, y: a.y)).toList(),
      );
    }

    setState(() {
      _session = session;
      _ends = ends;
      _arrowsByEnd = arrowsByEnd;
      _allArrows = allArrows;
      _groupingStats = grouping;
    });

    // Fetch HR samples for each end from Health Connect
    _loadHrSamples(ends);
  }

  Future<void> _loadHrSamples(List<End> ends) async {
    final authorized = await _healthService.requestAuthorization();
    if (!authorized) return;

    final hrByEnd = <int, List<HeartRateSample>>{};

    for (final end in ends) {
      // Use end's start timestamp and endedAt for the time window
      final endTime = end.endedAt ?? end.timestamp.add(const Duration(minutes: 5));
      final hr = await _healthService.getHeartRateForPeriod(
        end.timestamp,
        endTime,
      );
      if (hr != null && hr.samples.isNotEmpty) {
        hrByEnd[end.id] = hr.samples;
      }
    }

    if (mounted) {
      setState(() => _hrSamplesByEnd = hrByEnd);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_session == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final targetType = TargetType.values[_session!.targetType];

    return PopScope(
      canPop: !widget.fromSession,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && widget.fromSession) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (_) => AppShell(database: widget.database),
            ),
            (route) => false,
          );
        }
      },
      child: Scaffold(
      appBar: AppBar(title: const Text('Session Summary')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Stats cards
            Row(
              children: [
                _StatCard(
                  label: 'Total Score',
                  value: _session!.totalScore.toString(),
                ),
                const SizedBox(width: 8),
                _StatCard(
                  label: 'Arrows',
                  value: _session!.totalArrows.toString(),
                ),
                const SizedBox(width: 8),
                _StatCard(
                  label: 'Ends',
                  value: _ends.length.toString(),
                ),
              ],
            ),
            if (_session!.totalArrows > 0) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  _StatCard(
                    label: 'Avg/Arrow',
                    value: (_session!.totalScore / _session!.totalArrows)
                        .toStringAsFixed(1),
                  ),
                  const SizedBox(width: 8),
                  if (_ends.isNotEmpty)
                    _StatCard(
                      label: 'Avg/End',
                      value: (_session!.totalScore / _ends.length)
                          .toStringAsFixed(1),
                    ),
                  const SizedBox(width: 8),
                  if (_groupingStats != null)
                    _StatCard(
                      label: 'Grouping',
                      value:
                          '${(_groupingStats!.meanRadius * 100).toStringAsFixed(1)}%',
                    ),
                ],
              ),
            ],

            // Session heart rate summary
            if (_ends.any((e) => e.hrAvg != null)) ...[
              const SizedBox(height: 8),
              _buildSessionHrCard(),
            ],

            const SizedBox(height: 16),

            // Target with all arrows
            const Text('All Arrows',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            SizedBox(
              height: 300,
              child: Stack(
                children: [
                  // Target face
                  CustomPaint(
                    painter: TargetPainter(targetType: targetType),
                    size: const Size(300, 300),
                  ),
                  // Convex hull grouping overlay
                  if (_allArrows.length >= 2)
                    CustomPaint(
                      painter: GroupingOverlayPainter(
                        arrowPositions: _allArrows
                            .map((a) => (x: a.x, y: a.y))
                            .toList(),
                      ),
                      size: const Size(300, 300),
                    ),
                  // Arrow markers on top
                  CustomPaint(
                    painter: ArrowMarkerPainter(
                      arrows: _allArrows
                          .map((a) => ArrowPlacement(
                                x: a.x,
                                y: a.y,
                                score: a.score,
                                arrowNumber: 0,
                              ))
                          .toList(),
                    ),
                    size: const Size(300, 300),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // End-by-end breakdown
            const Text('End Breakdown',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            for (final end in _ends) _buildEndCard(end),

            const SizedBox(height: 24),

            FilledButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (_) => AppShell(database: widget.database),
                  ),
                  (route) => false,
                );
              },
              child: const Text('Done'),
            ),
          ],
        ),
      ),
      ),
    );
  }

  String _formatDuration(Duration d) {
    final mins = d.inMinutes;
    final secs = d.inSeconds % 60;
    if (mins > 0) return '${mins}m ${secs}s';
    return '${secs}s';
  }

  Widget _buildSessionHrCard() {
    final endsWithHr = _ends.where((e) => e.hrAvg != null).toList();
    if (endsWithHr.isEmpty) return const SizedBox.shrink();

    final avgBpm = endsWithHr.map((e) => e.hrAvg!).reduce((a, b) => a + b) /
        endsWithHr.length;
    final minBpm = endsWithHr.map((e) => e.hrMin!).reduce((a, b) => a < b ? a : b);
    final maxBpm = endsWithHr.map((e) => e.hrMax!).reduce((a, b) => a > b ? a : b);

    return Card(
      color: Colors.red.withAlpha(20),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            const Icon(Icons.favorite, color: Colors.red, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Session Heart Rate',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(
                    'Avg ${avgBpm.round()} bpm  |  Min $minBpm  |  Max $maxBpm',
                    style: const TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEndCard(End end) {
    final arrows = _arrowsByEnd[end.id] ?? [];
    final timeStr =
        '${end.timestamp.hour.toString().padLeft(2, '0')}:${end.timestamp.minute.toString().padLeft(2, '0')}';

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'End ${end.endNumber}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(width: 8),
                Text(timeStr,
                    style:
                        TextStyle(color: Colors.grey.shade400, fontSize: 12)),
                const SizedBox(width: 12),
                Expanded(
                  child: Wrap(
                    spacing: 4,
                    children: arrows
                        .map((a) => Text(
                              ScoreCalculator.scoreToString(a.score),
                              style: const TextStyle(fontSize: 14),
                            ))
                        .toList(),
                  ),
                ),
                Text(
                  '= ${end.subtotal}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
            if (end.hrAvg != null)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Row(
                  children: [
                    const Icon(Icons.favorite, color: Colors.red, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      'Avg ${end.hrAvg!.round()} bpm (${end.hrMin}-${end.hrMax})',
                      style: TextStyle(
                          fontSize: 12, color: Colors.grey.shade400),
                    ),
                    if (end.endedAt != null) ...[
                      const SizedBox(width: 8),
                      Text(
                        _formatDuration(end.endedAt!.difference(end.timestamp)),
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey.shade500),
                      ),
                    ],
                  ],
                ),
              ),
            // HR timeline chart for this end
            if (_hrSamplesByEnd.containsKey(end.id))
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: HrMiniChart(
                    samples: _hrSamplesByEnd[end.id]!,
                    height: 50,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;

  const _StatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Column(
            children: [
              Text(value,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(label,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade400)),
            ],
          ),
        ),
      ),
    );
  }
}
