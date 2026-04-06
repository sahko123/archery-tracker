import 'package:flutter/material.dart';
import '../../../core/constants/target_dimensions.dart';
import '../../../core/database/app_database.dart';
import '../../../core/scoring/score_calculator.dart';
import '../../../core/health/health_service.dart';
import '../../target/widgets/arrow_marker_painter.dart';
import '../../target/widgets/interactive_target.dart';
import '../../summary/screens/session_summary_screen.dart';
import '../../../app/router.dart';

class ActiveSessionScreen extends StatefulWidget {
  final AppDatabase database;
  final int sessionId;
  final TargetType targetType;
  final int arrowsPerEnd; // 0 = free

  const ActiveSessionScreen({
    super.key,
    required this.database,
    required this.sessionId,
    required this.targetType,
    required this.arrowsPerEnd,
  });

  @override
  State<ActiveSessionScreen> createState() => _ActiveSessionScreenState();
}

class _ActiveSessionScreenState extends State<ActiveSessionScreen> {
  int _currentEndNumber = 1;
  int? _currentEndId;
  List<ArrowPlacement> _currentArrows = [];
  int _sessionTotalScore = 0;
  int _sessionTotalArrows = 0;
  bool _endFull = false;

  // Score scroll
  final ScrollController _scoreScrollController = ScrollController();
  bool _canScrollLeft = false;
  bool _canScrollRight = false;

  // Heart rate
  final HealthService _healthService = HealthService();
  bool _hrAvailable = false;
  DateTime? _endStartTime;
  HeartRateStats? _lastEndHr;
  HeartRateStats? _currentHr; // live-ish HR for current end

  @override
  void initState() {
    super.initState();
    _scoreScrollController.addListener(_updateScrollIndicators);
    _initHealth();
    _startNewEnd();
  }

  @override
  void dispose() {
    _scoreScrollController.dispose();
    super.dispose();
  }

  void _updateScrollIndicators() {
    if (!_scoreScrollController.hasClients) return;
    final pos = _scoreScrollController.position;
    setState(() {
      _canScrollLeft = pos.pixels > 0;
      _canScrollRight = pos.pixels < pos.maxScrollExtent;
    });
  }

  void _checkScrollAfterBuild() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateScrollIndicators();
    });
  }

  Future<void> _initHealth() async {
    final authorized = await _healthService.requestAuthorization();
    if (mounted) {
      setState(() => _hrAvailable = authorized);
    }
  }

  Future<void> _startNewEnd() async {
    final endId = await widget.database.createEnd(
      sessionId: widget.sessionId,
      endNumber: _currentEndNumber,
    );
    setState(() {
      _currentEndId = endId;
      _currentArrows = [];
      _endFull = false;
      _endStartTime = DateTime.now();
      _lastEndHr = null;
      _currentHr = null;
    });
  }

  bool get _isEndComplete {
    if (widget.arrowsPerEnd == 0) return false;
    return _currentArrows.length >= widget.arrowsPerEnd;
  }

  Future<void> _fetchCurrentHr() async {
    if (!_hrAvailable || _endStartTime == null) return;
    final hr = await _healthService.getHeartRateForPeriod(
      _endStartTime!,
      DateTime.now(),
    );
    if (mounted && hr != null) {
      setState(() => _currentHr = hr);
    }
  }

  Future<void> _onArrowPlaced(double x, double y, int score) async {
    if (_currentEndId == null || _endFull) return;

    final arrowNumber = _currentArrows.length + 1;
    final dbId = await widget.database.insertArrow(
      endId: _currentEndId!,
      x: x,
      y: y,
      score: score,
      arrowNumber: arrowNumber,
    );

    setState(() {
      _currentArrows.add(ArrowPlacement(
        x: x,
        y: y,
        score: score,
        arrowNumber: arrowNumber,
        dbId: dbId,
      ));
      _sessionTotalScore += ScoreCalculator.scoreValue(score);
      _sessionTotalArrows++;
      _endFull = _isEndComplete;
    });

    // Update end subtotal
    final subtotal = _currentArrows.fold<int>(
        0, (sum, a) => sum + ScoreCalculator.scoreValue(a.score));
    await widget.database.updateEndSubtotal(_currentEndId!, subtotal);

    // Scroll to end and update indicators
    _checkScrollAfterBuild();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scoreScrollController.hasClients) {
        _scoreScrollController.animateTo(
          _scoreScrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });

    // Refresh HR data
    _fetchCurrentHr();
  }

  Future<void> _undoLastArrow() async {
    if (_currentArrows.isEmpty) return;

    final lastArrow = _currentArrows.last;
    if (lastArrow.dbId != null) {
      await widget.database.deleteArrow(lastArrow.dbId!);
    }

    setState(() {
      _sessionTotalScore -= ScoreCalculator.scoreValue(lastArrow.score);
      _sessionTotalArrows--;
      _currentArrows.removeLast();
      _endFull = false;
    });

    final subtotal = _currentArrows.fold<int>(
        0, (sum, a) => sum + ScoreCalculator.scoreValue(a.score));
    await widget.database.updateEndSubtotal(_currentEndId!, subtotal);
  }

  Future<void> _finishCurrentEnd() async {
    if (_currentEndId == null) return;

    // Mark end as finished with timestamp
    await widget.database.finishEnd(_currentEndId!);

    // Fetch and save HR for the full end duration
    if (_hrAvailable && _endStartTime != null) {
      final hr = await _healthService.getHeartRateForPeriod(
        _endStartTime!,
        DateTime.now(),
      );

      if (hr != null) {
        await widget.database.updateEndHeartRate(
          _currentEndId!,
          avg: hr.avgBpm,
          min: hr.minBpm,
          max: hr.maxBpm,
        );
        setState(() => _lastEndHr = hr);
      }
    }
  }

  Future<void> _nextEnd() async {
    await _finishCurrentEnd();
    setState(() {
      _currentEndNumber++;
    });
    await _startNewEnd();
  }

  Future<void> _finishSession() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Finish Session?'),
        content: Text(
          'End session with $_sessionTotalArrows arrows and $_sessionTotalScore total score?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Finish'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    // If current end has arrows, save it; otherwise delete the empty end
    if (_currentArrows.isNotEmpty) {
      await _finishCurrentEnd();
    } else if (_currentEndId != null) {
      await widget.database.deleteEmptyEnd(_currentEndId!);
    }
    await widget.database.finishSession(widget.sessionId);

    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => SessionSummaryScreen(
          database: widget.database,
          sessionId: widget.sessionId,
          fromSession: true,
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    final choice = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Leave Session?'),
        content: const Text('Do you want to save and finish this session, or discard it?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, 'cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, 'discard'),
            child: const Text('Discard', style: TextStyle(color: Colors.red)),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, 'save'),
            child: const Text('Save & Exit'),
          ),
        ],
      ),
    );

    if (choice == null || choice == 'cancel' || !mounted) return false;

    if (choice == 'discard') {
      await widget.database.deleteSession(widget.sessionId);
      if (!mounted) return false;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => AppShell(database: widget.database),
        ),
        (route) => false,
      );
      return false;
    }

    if (choice == 'save') {
      if (_currentArrows.isNotEmpty) {
        await _finishCurrentEnd();
      } else if (_currentEndId != null) {
        await widget.database.deleteEmptyEnd(_currentEndId!);
      }
      // If no arrows were shot at all, just delete the session
      if (_sessionTotalArrows == 0) {
        await widget.database.deleteSession(widget.sessionId);
      } else {
        await widget.database.finishSession(widget.sessionId);
      }
      if (!mounted) return false;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => AppShell(database: widget.database),
        ),
        (route) => false,
      );
      return false;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    final endSubtotal = _currentArrows.fold<int>(
        0, (sum, a) => sum + ScoreCalculator.scoreValue(a.score));

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _onBackPressed();
      },
      child: Scaffold(
      appBar: AppBar(
        title: Text('End $_currentEndNumber'),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Text(
                'Total: $_sessionTotalScore  |  Arrows: $_sessionTotalArrows',
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Interactive target
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: InteractiveTarget(
                targetType: widget.targetType,
                arrows: _currentArrows,
                enabled: !_endFull,
                onArrowPlaced: _onArrowPlaced,
              ),
            ),
          ),

          // Heart rate display
          if (_hrAvailable && _currentHr != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.red.withAlpha(30),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.favorite, color: Colors.red, size: 18),
                    const SizedBox(width: 6),
                    Text(
                      'Avg ${_currentHr!.avgBpm.round()} bpm',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '${_currentHr!.minBpm}-${_currentHr!.maxBpm} bpm',
                      style: TextStyle(
                          color: Colors.grey.shade400, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),

          if (_hrAvailable && _lastEndHr != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Text(
                'Last end: avg ${_lastEndHr!.avgBpm.round()} bpm (${_lastEndHr!.minBpm}-${_lastEndHr!.maxBpm})',
                style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
              ),
            ),

          // Current end scores
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Column(
              children: [
                Row(
                  children: [
                    // Left scroll indicator
                    AnimatedOpacity(
                      opacity: _canScrollLeft ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 150),
                      child: Icon(Icons.chevron_left,
                          size: 20, color: Colors.grey.shade400),
                    ),
                    // Scrollable scores
                    Expanded(
                      child: SingleChildScrollView(
                        controller: _scoreScrollController,
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (final arrow in _currentArrows)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 3),
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: _scoreColor(arrow.score),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    ScoreCalculator.scoreToString(arrow.score),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                            if (widget.arrowsPerEnd > 0)
                              for (int i = _currentArrows.length;
                                  i < widget.arrowsPerEnd;
                                  i++)
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 3),
                                  child: Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade800,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    alignment: Alignment.center,
                                    child: const Text('-',
                                        style: TextStyle(fontSize: 14)),
                                  ),
                                ),
                          ],
                        ),
                      ),
                    ),
                    // Right scroll indicator
                    AnimatedOpacity(
                      opacity: _canScrollRight ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 150),
                      child: Icon(Icons.chevron_right,
                          size: 20, color: Colors.grey.shade400),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'End subtotal: $endSubtotal  (${_currentArrows.length} arrows)',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),

          // Action buttons
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              children: [
                IconButton.outlined(
                  onPressed: _currentArrows.isEmpty ? null : _undoLastArrow,
                  icon: const Icon(Icons.undo),
                  tooltip: 'Undo last arrow',
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: FilledButton.tonal(
                    onPressed: _currentArrows.isEmpty ? null : _nextEnd,
                    child: const Text('Next End'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: FilledButton(
                    onPressed:
                        _sessionTotalArrows == 0 ? null : _finishSession,
                    child: const Text('Finish'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }

  Color _scoreColor(int score) {
    if (score >= 9) return const Color(0xFFFFD700);
    if (score >= 7) return const Color(0xFFE8302B);
    if (score >= 5) return const Color(0xFF29ABE2);
    if (score >= 3) return const Color(0xFF222222);
    if (score >= 1) return Colors.grey.shade400;
    return Colors.grey.shade700;
  }
}
