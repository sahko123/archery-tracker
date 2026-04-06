import 'package:flutter/material.dart';
import '../core/database/app_database.dart';
import '../features/session/screens/new_session_screen.dart';
import '../features/history/screens/history_screen.dart';
import '../features/history/screens/calendar_screen.dart';

class AppShell extends StatefulWidget {
  final AppDatabase database;

  const AppShell({super.key, required this.database});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          NewSessionScreen(database: widget.database),
          CalendarScreen(database: widget.database),
          HistoryScreen(database: widget.database),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (i) => setState(() => _currentIndex = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.gps_fixed),
            selectedIcon: Icon(Icons.gps_fixed),
            label: 'Shoot',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month),
            selectedIcon: Icon(Icons.calendar_month),
            label: 'Calendar',
          ),
          NavigationDestination(
            icon: Icon(Icons.history),
            selectedIcon: Icon(Icons.history),
            label: 'History',
          ),
        ],
      ),
    );
  }
}
