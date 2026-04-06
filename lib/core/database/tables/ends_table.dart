import 'package:drift/drift.dart';
import 'sessions_table.dart';

class Ends extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get sessionId => integer().references(Sessions, #id)();
  IntColumn get endNumber => integer()();
  IntColumn get subtotal => integer().withDefault(const Constant(0))();
  DateTimeColumn get timestamp => dateTime()(); // when end started
  DateTimeColumn get endedAt => dateTime().nullable()(); // when end finished
  // Heart rate stats for this end
  RealColumn get hrAvg => real().nullable()();
  IntColumn get hrMin => integer().nullable()();
  IntColumn get hrMax => integer().nullable()();
}
