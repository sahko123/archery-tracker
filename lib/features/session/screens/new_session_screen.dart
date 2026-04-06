import 'package:flutter/material.dart';
import '../../../core/constants/target_dimensions.dart';
import '../../../core/database/app_database.dart';
import 'active_session_screen.dart';

class NewSessionScreen extends StatefulWidget {
  final AppDatabase database;

  const NewSessionScreen({super.key, required this.database});

  @override
  State<NewSessionScreen> createState() => _NewSessionScreenState();
}

class _NewSessionScreenState extends State<NewSessionScreen> {
  TargetType _targetType = TargetType.fullFace;
  int _arrowsPerEnd = 3; // 0 = free shooting

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Session')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Target Type',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            SegmentedButton<TargetType>(
              segments: const [
                ButtonSegment(
                  value: TargetType.fullFace,
                  label: Text('10-Ring'),
                  icon: Icon(Icons.circle_outlined),
                ),
                ButtonSegment(
                  value: TargetType.fiveRing,
                  label: Text('5-Ring'),
                  icon: Icon(Icons.adjust),
                ),
              ],
              selected: {_targetType},
              onSelectionChanged: (v) => setState(() => _targetType = v.first),
            ),
            const SizedBox(height: 32),
            const Text(
              'Arrows Per End',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 3, label: Text('3')),
                ButtonSegment(value: 6, label: Text('6')),
                ButtonSegment(
                  value: 0,
                  label: Text('Free'),
                  icon: Icon(Icons.all_inclusive),
                ),
              ],
              selected: {_arrowsPerEnd},
              onSelectionChanged: (v) =>
                  setState(() => _arrowsPerEnd = v.first),
            ),
            const SizedBox(height: 16),
            if (_arrowsPerEnd == 0)
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Free shooting: shoot as many arrows as you want per end.',
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            const Spacer(),
            FilledButton.icon(
              onPressed: _startSession,
              icon: const Icon(Icons.play_arrow),
              label: const Text('Start Session', style: TextStyle(fontSize: 18)),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _startSession() async {
    final sessionId = await widget.database.createSession(
      targetType: _targetType.index,
      arrowsPerEnd: _arrowsPerEnd,
    );

    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => ActiveSessionScreen(
          database: widget.database,
          sessionId: sessionId,
          targetType: _targetType,
          arrowsPerEnd: _arrowsPerEnd,
        ),
      ),
    );
  }
}
