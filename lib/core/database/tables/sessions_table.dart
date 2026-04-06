import 'package:drift/drift.dart';

class Sessions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get targetType => integer()(); // 0 = fullFace, 1 = fiveRing
  IntColumn get arrowsPerEnd => integer()(); // 3, 6, or 0 for free shooting
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get endedAt => dateTime().nullable()();
  IntColumn get totalScore => integer().withDefault(const Constant(0))();
  IntColumn get totalArrows => integer().withDefault(const Constant(0))();
}
