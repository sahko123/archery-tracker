import 'package:flutter/material.dart';
import '../../../core/database/app_database.dart';
import '../../summary/screens/session_summary_screen.dart';

class HistoryScreen extends StatefulWidget {
  final AppDatabase database;

  const HistoryScreen({super.key, required this.database});

  @override
  State<HistoryScreen> createState() => HistoryScreenState();
}

class HistoryScreenState extends State<HistoryScreen> {
  List<Session> _sessions = [];
  Map<String, int> _arrowsByDay = {};
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final sessions = await widget.database.getAllSessions();
    final arrowsByDay = await widget.database.getArrowsPerDay();
    if (mounted) {
      setState(() {
        _sessions = sessions;
        _arrowsByDay = arrowsByDay;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_sessions.isEmpty) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.history, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('No sessions yet', style: TextStyle(fontSize: 18)),
            Text('Start shooting to see your history!',
                style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }

    // Group sessions by day
    final Map<String, List<Session>> sessionsByDay = {};
    for (final session in _sessions) {
      final dateKey =
          '${session.startedAt.year}-${session.startedAt.month.toString().padLeft(2, '0')}-${session.startedAt.day.toString().padLeft(2, '0')}';
      sessionsByDay.putIfAbsent(dateKey, () => []).add(session);
    }

    final days = sessionsByDay.keys.toList()..sort((a, b) => b.compareTo(a));

    // Build flat list of items: date headers + session cards
    final items = <_ListItem>[];
    for (final day in days) {
      final daySessions = sessionsByDay[day]!;
      final dayArrows = _arrowsByDay[day] ?? 0;
      items.add(_ListItem(
        type: _ItemType.header,
        dateKey: day,
        dayArrows: dayArrows,
      ));
      for (final session in daySessions) {
        items.add(_ListItem(
          type: _ItemType.session,
          session: session,
        ));
      }
    }

    return RefreshIndicator(
      onRefresh: loadData,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          if (item.type == _ItemType.header) {
            return Padding(
              padding: EdgeInsets.only(
                top: index == 0 ? 0 : 16,
                bottom: 8,
              ),
              child: Row(
                children: [
                  Text(
                    _formatDate(item.dateKey!),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Text(
                    '${item.dayArrows} arrows',
                    style: TextStyle(
                        color: Colors.grey.shade400, fontSize: 13),
                  ),
                ],
              ),
            );
          }

          return _buildSessionCard(item.session!);
        },
      ),
    );
  }

  Widget _buildSessionCard(Session session) {
    final targetName = session.targetType == 0 ? '10-Ring' : '5-Ring';
    final timeStr =
        '${session.startedAt.hour.toString().padLeft(2, '0')}:${session.startedAt.minute.toString().padLeft(2, '0')}';
    final isFinished = session.endedAt != null;

    return Dismissible(
      key: ValueKey(session.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (_) => _confirmDelete(session),
      onDismissed: (_) async {
        await widget.database.deleteSession(session.id);
        loadData();
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 8),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: isFinished
                ? const Color(0xFFFFD700).withAlpha(50)
                : Colors.grey.withAlpha(50),
            child: Icon(
              isFinished ? Icons.check : Icons.pending,
              color: isFinished ? const Color(0xFFFFD700) : Colors.grey,
            ),
          ),
          title: Text('$targetName  -  $timeStr'),
          subtitle: Text(
            'Score: ${session.totalScore}  |  Arrows: ${session.totalArrows}',
          ),
          trailing: const Icon(Icons.chevron_right),
          onTap: isFinished
              ? () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => SessionSummaryScreen(
                        database: widget.database,
                        sessionId: session.id,
                      ),
                    ),
                  );
                  loadData();
                }
              : null,
        ),
      ),
    );
  }

  Future<bool> _confirmDelete(Session session) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Session?'),
        content: const Text('This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    return confirmed == true;
  }

  String _formatDate(String dateKey) {
    final parts = dateKey.split('-');
    final date = DateTime(
        int.parse(parts[0]), int.parse(parts[1]), int.parse(parts[2]));
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final sessionDate = DateTime(date.year, date.month, date.day);

    if (sessionDate == today) return 'Today';
    if (sessionDate == yesterday) return 'Yesterday';

    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}

enum _ItemType { header, session }

class _ListItem {
  final _ItemType type;
  final String? dateKey;
  final int dayArrows;
  final Session? session;

  _ListItem({
    required this.type,
    this.dateKey,
    this.dayArrows = 0,
    this.session,
  });
}
