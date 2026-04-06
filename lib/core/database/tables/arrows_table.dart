import 'package:drift/drift.dart';
import 'ends_table.dart';

class Arrows extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get endId => integer().references(Ends, #id)();
  RealColumn get x => real()(); // normalized -1.0 to 1.0
  RealColumn get y => real()(); // normalized -1.0 to 1.0
  IntColumn get score => integer()(); // 0-10, 11 = X
  IntColumn get arrowNumber => integer()();
}
