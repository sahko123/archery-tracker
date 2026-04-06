import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'tables/sessions_table.dart';
import 'tables/ends_table.dart';
import 'tables/arrows_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Sessions, Ends, Arrows])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        await migrator.addColumn(ends, ends.hrAvg);
        await migrator.addColumn(ends, ends.hrMin);
        await migrator.addColumn(ends, ends.hrMax);
      }
      if (from < 3) {
        await migrator.addColumn(ends, ends.endedAt);
      }
    },
  );

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'archery_tracker');
  }

  // === Sessions ===

  Future<int> createSession({
    required int targetType,
    required int arrowsPerEnd,
  }) {
    return into(sessions).insert(SessionsCompanion.insert(
      targetType: targetType,
      arrowsPerEnd: arrowsPerEnd,
      startedAt: DateTime.now(),
    ));
  }

  Future<void> finishSession(int sessionId) async {
    // Calculate totals from ends and arrows
    final sessionEnds = await (select(ends)..where((e) => e.sessionId.equals(sessionId))).get();
    int totalScore = 0;
    int totalArrows = 0;

    for (final end in sessionEnds) {
      final endArrows = await (select(arrows)..where((a) => a.endId.equals(end.id))).get();
      for (final arrow in endArrows) {
        totalScore += arrow.score == 11 ? 10 : arrow.score; // X counts as 10
        totalArrows++;
      }
    }

    await (update(sessions)..where((s) => s.id.equals(sessionId))).write(
      SessionsCompanion(
        endedAt: Value(DateTime.now()),
        totalScore: Value(totalScore),
        totalArrows: Value(totalArrows),
      ),
    );
  }

  Future<List<Session>> getAllSessions() {
    return (select(sessions)..orderBy([(s) => OrderingTerm.desc(s.startedAt)])).get();
  }

  Future<Session> getSession(int id) {
    return (select(sessions)..where((s) => s.id.equals(id))).getSingle();
  }

  Future<void> deleteSession(int sessionId) async {
    // Delete arrows first, then ends, then session
    final sessionEnds = await (select(ends)..where((e) => e.sessionId.equals(sessionId))).get();
    for (final end in sessionEnds) {
      await (delete(arrows)..where((a) => a.endId.equals(end.id))).go();
    }
    await (delete(ends)..where((e) => e.sessionId.equals(sessionId))).go();
    await (delete(sessions)..where((s) => s.id.equals(sessionId))).go();
  }

  // === Ends ===

  Future<int> createEnd({
    required int sessionId,
    required int endNumber,
  }) {
    return into(ends).insert(EndsCompanion.insert(
      sessionId: sessionId,
      endNumber: endNumber,
      timestamp: DateTime.now(),
    ));
  }

  Future<void> updateEndSubtotal(int endId, int subtotal) {
    return (update(ends)..where((e) => e.id.equals(endId))).write(
      EndsCompanion(subtotal: Value(subtotal)),
    );
  }

  Future<void> deleteEmptyEnd(int endId) {
    return (delete(ends)..where((e) => e.id.equals(endId))).go();
  }

  Future<void> finishEnd(int endId) {
    return (update(ends)..where((e) => e.id.equals(endId))).write(
      EndsCompanion(endedAt: Value(DateTime.now())),
    );
  }

  Future<void> updateEndHeartRate(int endId, {
    required double avg,
    required int min,
    required int max,
  }) {
    return (update(ends)..where((e) => e.id.equals(endId))).write(
      EndsCompanion(
        hrAvg: Value(avg),
        hrMin: Value(min),
        hrMax: Value(max),
      ),
    );
  }

  Future<List<End>> getEndsForSession(int sessionId) {
    return (select(ends)
          ..where((e) => e.sessionId.equals(sessionId))
          ..orderBy([(e) => OrderingTerm.asc(e.endNumber)]))
        .get();
  }

  // === Arrows ===

  Future<int> insertArrow({
    required int endId,
    required double x,
    required double y,
    required int score,
    required int arrowNumber,
  }) {
    return into(arrows).insert(ArrowsCompanion.insert(
      endId: endId,
      x: x,
      y: y,
      score: score,
      arrowNumber: arrowNumber,
    ));
  }

  Future<void> deleteArrow(int arrowId) {
    return (delete(arrows)..where((a) => a.id.equals(arrowId))).go();
  }

  Future<List<Arrow>> getArrowsForEnd(int endId) {
    return (select(arrows)
          ..where((a) => a.endId.equals(endId))
          ..orderBy([(a) => OrderingTerm.asc(a.arrowNumber)]))
        .get();
  }

  Future<List<Arrow>> getAllArrowsForSession(int sessionId) async {
    final sessionEnds = await getEndsForSession(sessionId);
    final allArrows = <Arrow>[];
    for (final end in sessionEnds) {
      allArrows.addAll(await getArrowsForEnd(end.id));
    }
    return allArrows;
  }

  Future<void> deleteEmptySessions() async {
    final allSessions = await getAllSessions();
    for (final session in allSessions) {
      if (session.totalArrows == 0) {
        await deleteSession(session.id);
      }
    }
  }

  // === Stats ===

  Future<int> getTotalArrowsShot() async {
    final result = await customSelect('SELECT COUNT(*) AS count FROM arrows').getSingle();
    return result.read<int>('count');
  }

  Future<Map<String, int>> getArrowsPerDay() async {
    final allSessions = await getAllSessions();
    final Map<String, int> arrowsByDay = {};

    for (final session in allSessions) {
      final dateKey = '${session.startedAt.year}-${session.startedAt.month.toString().padLeft(2, '0')}-${session.startedAt.day.toString().padLeft(2, '0')}';
      arrowsByDay[dateKey] = (arrowsByDay[dateKey] ?? 0) + session.totalArrows;
    }

    return arrowsByDay;
  }
}
