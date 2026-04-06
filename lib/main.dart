import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app/theme.dart';
import 'app/router.dart';
import 'core/database/app_database.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: SystemUiOverlay.values,
  );
  final database = AppDatabase();
  database.deleteEmptySessions(); // clean up any leftover empty sessions
  runApp(ArcheryTrackerApp(database: database));
}

class ArcheryTrackerApp extends StatelessWidget {
  final AppDatabase database;

  const ArcheryTrackerApp({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Archery Tracker',
      theme: AppTheme.darkTheme,
      builder: (context, child) => SafeArea(child: child!),
      home: AppShell(database: database),
      debugShowCheckedModeBanner: false,
    );
  }
}
