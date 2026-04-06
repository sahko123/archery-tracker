import 'package:flutter/material.dart';
import '../../../core/database/app_database.dart';
import '../../summary/screens/session_summary_screen.dart';

class CalendarScreen extends StatefulWidget {
  final AppDatabase database;

  const CalendarScreen({super.key, required this.database});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late DateTime _currentMonth;
  Map<String, int> _arrowsByDay = {};
  Map<String, int> _scoreByDay = {};
  Map<String, List<Session>> _sessionsByDay = {};
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _currentMonth = DateTime(now.year, now.month);
    _loadData();
  }

  Future<void> _loadData() async {
    final sessions = await widget.database.getAllSessions();
    final arrowsByDay = <String, int>{};
    final scoreByDay = <String, int>{};
    final sessionsByDay = <String, List<Session>>{};

    for (final session in sessions) {
      final key = _dateKey(session.startedAt);
      arrowsByDay[key] = (arrowsByDay[key] ?? 0) + session.totalArrows;
      scoreByDay[key] = (scoreByDay[key] ?? 0) + session.totalScore;
      sessionsByDay.putIfAbsent(key, () => []).add(session);
    }

    setState(() {
      _arrowsByDay = arrowsByDay;
      _scoreByDay = scoreByDay;
      _sessionsByDay = sessionsByDay;
      _loading = false;
    });
  }

  String _dateKey(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
    });
  }

  // Get the Monday of the week containing [date]
  DateTime _weekStart(DateTime date) {
    final diff = (date.weekday - 1) % 7;
    return DateTime(date.year, date.month, date.day - diff);
  }

  // Get weekly stats for this month's weeks
  List<_WeekStats> _getWeekStats() {
    final firstDay = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final daysInMonth =
        DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;
    final lastDay =
        DateTime(_currentMonth.year, _currentMonth.month, daysInMonth);

    final weeks = <DateTime>{};
    for (var d = firstDay;
        !d.isAfter(lastDay);
        d = d.add(const Duration(days: 1))) {
      weeks.add(_weekStart(d));
    }

    final sorted = weeks.toList()..sort();
    return sorted.map((weekStart) {
      int arrows = 0;
      int score = 0;
      for (int i = 0; i < 7; i++) {
        final day = weekStart.add(Duration(days: i));
        final key = _dateKey(day);
        arrows += _arrowsByDay[key] ?? 0;
        score += _scoreByDay[key] ?? 0;
      }
      final weekEnd = weekStart.add(const Duration(days: 6));
      return _WeekStats(
        start: weekStart,
        end: weekEnd,
        arrows: arrows,
        score: score,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    // Month stats
    int monthArrows = 0;
    int monthScore = 0;
    final daysInMonth =
        DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;
    for (int d = 1; d <= daysInMonth; d++) {
      final key =
          _dateKey(DateTime(_currentMonth.year, _currentMonth.month, d));
      monthArrows += _arrowsByDay[key] ?? 0;
      monthScore += _scoreByDay[key] ?? 0;
    }

    final weekStats = _getWeekStats();

    return Column(
      children: [
        // Month header
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: _previousMonth,
                icon: const Icon(Icons.chevron_left),
              ),
              Text(
                '${_monthName(_currentMonth.month)} ${_currentMonth.year}',
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: _nextMonth,
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),
        ),

        // Month summary
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              _MiniStat(label: 'Arrows', value: monthArrows.toString()),
              _MiniStat(label: 'Total Score', value: monthScore.toString()),
            ],
          ),
        ),

        // Week summary cards
        if (weekStats.any((w) => w.arrows > 0))
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: weekStats
                  .where((w) => w.arrows > 0)
                  .map((w) => _buildWeekCard(w))
                  .toList(),
            ),
          ),

        const SizedBox(height: 8),

        // Day-of-week headers
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                .map((d) => Expanded(
                      child: Center(
                        child: Text(d,
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.w500)),
                      ),
                    ))
                .toList(),
          ),
        ),
        const SizedBox(height: 4),

        // Calendar grid
        Expanded(
          child: _buildCalendarGrid(),
        ),
      ],
    );
  }

  Widget _buildWeekCard(_WeekStats week) {
    final startStr = '${week.start.day} ${_monthNameShort(week.start.month)}';
    final endStr = '${week.end.day} ${_monthNameShort(week.end.month)}';

    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFFD700).withAlpha(15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFFFD700).withAlpha(40)),
      ),
      child: Row(
        children: [
          Text(
            '$startStr - $endStr',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
          ),
          const Spacer(),
          Text(
            '${week.arrows}',
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 14),
          ),
          Text(
            ' arrows',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
          ),
          const SizedBox(width: 12),
          Text(
            '${week.score}',
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Color(0xFFFFD700)),
          ),
          Text(
            ' pts',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarGrid() {
    final firstDay = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final daysInMonth =
        DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;
    final startWeekday = firstDay.weekday;
    final today = DateTime.now();

    int maxArrows = 0;
    for (int d = 1; d <= daysInMonth; d++) {
      final key =
          _dateKey(DateTime(_currentMonth.year, _currentMonth.month, d));
      final arrows = _arrowsByDay[key] ?? 0;
      if (arrows > maxArrows) maxArrows = arrows;
    }

    final cells = <Widget>[];

    for (int i = 1; i < startWeekday; i++) {
      cells.add(const SizedBox());
    }

    for (int d = 1; d <= daysInMonth; d++) {
      final date = DateTime(_currentMonth.year, _currentMonth.month, d);
      final key = _dateKey(date);
      final arrows = _arrowsByDay[key] ?? 0;
      final score = _scoreByDay[key] ?? 0;
      final isToday = date.year == today.year &&
          date.month == today.month &&
          date.day == today.day;

      cells.add(_DayCell(
        day: d,
        arrows: arrows,
        score: score,
        maxArrows: maxArrows,
        isToday: isToday,
        onTap: arrows > 0 ? () => _showDayDetail(key) : null,
      ));
    }

    return GridView.count(
      crossAxisCount: 7,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      childAspectRatio: 1,
      children: cells,
    );
  }

  void _showDayDetail(String dateKey) {
    final sessions = _sessionsByDay[dateKey] ?? [];
    final arrows = _arrowsByDay[dateKey] ?? 0;
    final score = _scoreByDay[dateKey] ?? 0;

    showModalBottomSheet(
      context: context,
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _formatDateKey(dateKey),
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _MiniStat(label: 'Arrows', value: arrows.toString()),
                _MiniStat(label: 'Total Score', value: score.toString()),
                _MiniStat(
                  label: 'Sessions',
                  value: sessions.length.toString(),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text('Sessions',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            ...sessions.map((s) {
              final targetName = s.targetType == 0 ? '10-Ring' : '5-Ring';
              final time =
                  '${s.startedAt.hour.toString().padLeft(2, '0')}:${s.startedAt.minute.toString().padLeft(2, '0')}';
              return ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: Text('$targetName - $time'),
                subtitle: Text(
                    'Score: ${s.totalScore}  |  Arrows: ${s.totalArrows}'),
                trailing: const Icon(Icons.chevron_right, size: 20),
                onTap: s.endedAt != null
                    ? () {
                        Navigator.pop(ctx);
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => SessionSummaryScreen(
                            database: widget.database,
                            sessionId: s.id,
                          ),
                        ));
                      }
                    : null,
              );
            }),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  String _monthName(int month) {
    const names = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return names[month - 1];
  }

  String _monthNameShort(int month) {
    const names = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return names[month - 1];
  }

  String _formatDateKey(String key) {
    final parts = key.split('-');
    final date = DateTime(
        int.parse(parts[0]), int.parse(parts[1]), int.parse(parts[2]));
    return '${date.day} ${_monthName(date.month)} ${date.year}';
  }
}

class _DayCell extends StatelessWidget {
  final int day;
  final int arrows;
  final int score;
  final int maxArrows;
  final bool isToday;
  final VoidCallback? onTap;

  const _DayCell({
    required this.day,
    required this.arrows,
    required this.score,
    required this.maxArrows,
    required this.isToday,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    if (arrows == 0) {
      bgColor = Colors.transparent;
    } else if (maxArrows > 0) {
      final intensity = (arrows / maxArrows).clamp(0.2, 1.0);
      bgColor = const Color(0xFFFFD700).withAlpha((intensity * 150).toInt());
    } else {
      bgColor = Colors.transparent;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
          border: isToday
              ? Border.all(color: const Color(0xFFFFD700), width: 2)
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$day',
              style: TextStyle(
                fontSize: 14,
                fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                color: isToday ? const Color(0xFFFFD700) : null,
              ),
            ),
            if (arrows > 0)
              Text(
                '$arrows',
                style: const TextStyle(
                  fontSize: 10,
                  color: Color(0xFFFFD700),
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _WeekStats {
  final DateTime start;
  final DateTime end;
  final int arrows;
  final int score;

  _WeekStats({
    required this.start,
    required this.end,
    required this.arrows,
    required this.score,
  });
}

class _MiniStat extends StatelessWidget {
  final String label;
  final String value;

  const _MiniStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(value,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text(label,
              style: TextStyle(fontSize: 11, color: Colors.grey.shade400)),
        ],
      ),
    );
  }
}
