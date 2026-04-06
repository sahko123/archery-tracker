// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SessionsTable extends Sessions with TableInfo<$SessionsTable, Session> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _targetTypeMeta = const VerificationMeta(
    'targetType',
  );
  @override
  late final GeneratedColumn<int> targetType = GeneratedColumn<int>(
    'target_type',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _arrowsPerEndMeta = const VerificationMeta(
    'arrowsPerEnd',
  );
  @override
  late final GeneratedColumn<int> arrowsPerEnd = GeneratedColumn<int>(
    'arrows_per_end',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endedAtMeta = const VerificationMeta(
    'endedAt',
  );
  @override
  late final GeneratedColumn<DateTime> endedAt = GeneratedColumn<DateTime>(
    'ended_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalScoreMeta = const VerificationMeta(
    'totalScore',
  );
  @override
  late final GeneratedColumn<int> totalScore = GeneratedColumn<int>(
    'total_score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalArrowsMeta = const VerificationMeta(
    'totalArrows',
  );
  @override
  late final GeneratedColumn<int> totalArrows = GeneratedColumn<int>(
    'total_arrows',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    targetType,
    arrowsPerEnd,
    startedAt,
    endedAt,
    totalScore,
    totalArrows,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Session> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('target_type')) {
      context.handle(
        _targetTypeMeta,
        targetType.isAcceptableOrUnknown(data['target_type']!, _targetTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_targetTypeMeta);
    }
    if (data.containsKey('arrows_per_end')) {
      context.handle(
        _arrowsPerEndMeta,
        arrowsPerEnd.isAcceptableOrUnknown(
          data['arrows_per_end']!,
          _arrowsPerEndMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_arrowsPerEndMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('ended_at')) {
      context.handle(
        _endedAtMeta,
        endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta),
      );
    }
    if (data.containsKey('total_score')) {
      context.handle(
        _totalScoreMeta,
        totalScore.isAcceptableOrUnknown(data['total_score']!, _totalScoreMeta),
      );
    }
    if (data.containsKey('total_arrows')) {
      context.handle(
        _totalArrowsMeta,
        totalArrows.isAcceptableOrUnknown(
          data['total_arrows']!,
          _totalArrowsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Session map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Session(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      targetType: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_type'],
      )!,
      arrowsPerEnd: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}arrows_per_end'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ended_at'],
      ),
      totalScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_score'],
      )!,
      totalArrows: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_arrows'],
      )!,
    );
  }

  @override
  $SessionsTable createAlias(String alias) {
    return $SessionsTable(attachedDatabase, alias);
  }
}

class Session extends DataClass implements Insertable<Session> {
  final int id;
  final int targetType;
  final int arrowsPerEnd;
  final DateTime startedAt;
  final DateTime? endedAt;
  final int totalScore;
  final int totalArrows;
  const Session({
    required this.id,
    required this.targetType,
    required this.arrowsPerEnd,
    required this.startedAt,
    this.endedAt,
    required this.totalScore,
    required this.totalArrows,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['target_type'] = Variable<int>(targetType);
    map['arrows_per_end'] = Variable<int>(arrowsPerEnd);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || endedAt != null) {
      map['ended_at'] = Variable<DateTime>(endedAt);
    }
    map['total_score'] = Variable<int>(totalScore);
    map['total_arrows'] = Variable<int>(totalArrows);
    return map;
  }

  SessionsCompanion toCompanion(bool nullToAbsent) {
    return SessionsCompanion(
      id: Value(id),
      targetType: Value(targetType),
      arrowsPerEnd: Value(arrowsPerEnd),
      startedAt: Value(startedAt),
      endedAt: endedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endedAt),
      totalScore: Value(totalScore),
      totalArrows: Value(totalArrows),
    );
  }

  factory Session.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Session(
      id: serializer.fromJson<int>(json['id']),
      targetType: serializer.fromJson<int>(json['targetType']),
      arrowsPerEnd: serializer.fromJson<int>(json['arrowsPerEnd']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      endedAt: serializer.fromJson<DateTime?>(json['endedAt']),
      totalScore: serializer.fromJson<int>(json['totalScore']),
      totalArrows: serializer.fromJson<int>(json['totalArrows']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'targetType': serializer.toJson<int>(targetType),
      'arrowsPerEnd': serializer.toJson<int>(arrowsPerEnd),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'endedAt': serializer.toJson<DateTime?>(endedAt),
      'totalScore': serializer.toJson<int>(totalScore),
      'totalArrows': serializer.toJson<int>(totalArrows),
    };
  }

  Session copyWith({
    int? id,
    int? targetType,
    int? arrowsPerEnd,
    DateTime? startedAt,
    Value<DateTime?> endedAt = const Value.absent(),
    int? totalScore,
    int? totalArrows,
  }) => Session(
    id: id ?? this.id,
    targetType: targetType ?? this.targetType,
    arrowsPerEnd: arrowsPerEnd ?? this.arrowsPerEnd,
    startedAt: startedAt ?? this.startedAt,
    endedAt: endedAt.present ? endedAt.value : this.endedAt,
    totalScore: totalScore ?? this.totalScore,
    totalArrows: totalArrows ?? this.totalArrows,
  );
  Session copyWithCompanion(SessionsCompanion data) {
    return Session(
      id: data.id.present ? data.id.value : this.id,
      targetType: data.targetType.present
          ? data.targetType.value
          : this.targetType,
      arrowsPerEnd: data.arrowsPerEnd.present
          ? data.arrowsPerEnd.value
          : this.arrowsPerEnd,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
      totalScore: data.totalScore.present
          ? data.totalScore.value
          : this.totalScore,
      totalArrows: data.totalArrows.present
          ? data.totalArrows.value
          : this.totalArrows,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Session(')
          ..write('id: $id, ')
          ..write('targetType: $targetType, ')
          ..write('arrowsPerEnd: $arrowsPerEnd, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('totalScore: $totalScore, ')
          ..write('totalArrows: $totalArrows')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    targetType,
    arrowsPerEnd,
    startedAt,
    endedAt,
    totalScore,
    totalArrows,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Session &&
          other.id == this.id &&
          other.targetType == this.targetType &&
          other.arrowsPerEnd == this.arrowsPerEnd &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt &&
          other.totalScore == this.totalScore &&
          other.totalArrows == this.totalArrows);
}

class SessionsCompanion extends UpdateCompanion<Session> {
  final Value<int> id;
  final Value<int> targetType;
  final Value<int> arrowsPerEnd;
  final Value<DateTime> startedAt;
  final Value<DateTime?> endedAt;
  final Value<int> totalScore;
  final Value<int> totalArrows;
  const SessionsCompanion({
    this.id = const Value.absent(),
    this.targetType = const Value.absent(),
    this.arrowsPerEnd = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.totalScore = const Value.absent(),
    this.totalArrows = const Value.absent(),
  });
  SessionsCompanion.insert({
    this.id = const Value.absent(),
    required int targetType,
    required int arrowsPerEnd,
    required DateTime startedAt,
    this.endedAt = const Value.absent(),
    this.totalScore = const Value.absent(),
    this.totalArrows = const Value.absent(),
  }) : targetType = Value(targetType),
       arrowsPerEnd = Value(arrowsPerEnd),
       startedAt = Value(startedAt);
  static Insertable<Session> custom({
    Expression<int>? id,
    Expression<int>? targetType,
    Expression<int>? arrowsPerEnd,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? endedAt,
    Expression<int>? totalScore,
    Expression<int>? totalArrows,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (targetType != null) 'target_type': targetType,
      if (arrowsPerEnd != null) 'arrows_per_end': arrowsPerEnd,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
      if (totalScore != null) 'total_score': totalScore,
      if (totalArrows != null) 'total_arrows': totalArrows,
    });
  }

  SessionsCompanion copyWith({
    Value<int>? id,
    Value<int>? targetType,
    Value<int>? arrowsPerEnd,
    Value<DateTime>? startedAt,
    Value<DateTime?>? endedAt,
    Value<int>? totalScore,
    Value<int>? totalArrows,
  }) {
    return SessionsCompanion(
      id: id ?? this.id,
      targetType: targetType ?? this.targetType,
      arrowsPerEnd: arrowsPerEnd ?? this.arrowsPerEnd,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      totalScore: totalScore ?? this.totalScore,
      totalArrows: totalArrows ?? this.totalArrows,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (targetType.present) {
      map['target_type'] = Variable<int>(targetType.value);
    }
    if (arrowsPerEnd.present) {
      map['arrows_per_end'] = Variable<int>(arrowsPerEnd.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    if (totalScore.present) {
      map['total_score'] = Variable<int>(totalScore.value);
    }
    if (totalArrows.present) {
      map['total_arrows'] = Variable<int>(totalArrows.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionsCompanion(')
          ..write('id: $id, ')
          ..write('targetType: $targetType, ')
          ..write('arrowsPerEnd: $arrowsPerEnd, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('totalScore: $totalScore, ')
          ..write('totalArrows: $totalArrows')
          ..write(')'))
        .toString();
  }
}

class $EndsTable extends Ends with TableInfo<$EndsTable, End> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EndsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<int> sessionId = GeneratedColumn<int>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sessions (id)',
    ),
  );
  static const VerificationMeta _endNumberMeta = const VerificationMeta(
    'endNumber',
  );
  @override
  late final GeneratedColumn<int> endNumber = GeneratedColumn<int>(
    'end_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subtotalMeta = const VerificationMeta(
    'subtotal',
  );
  @override
  late final GeneratedColumn<int> subtotal = GeneratedColumn<int>(
    'subtotal',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endedAtMeta = const VerificationMeta(
    'endedAt',
  );
  @override
  late final GeneratedColumn<DateTime> endedAt = GeneratedColumn<DateTime>(
    'ended_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hrAvgMeta = const VerificationMeta('hrAvg');
  @override
  late final GeneratedColumn<double> hrAvg = GeneratedColumn<double>(
    'hr_avg',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hrMinMeta = const VerificationMeta('hrMin');
  @override
  late final GeneratedColumn<int> hrMin = GeneratedColumn<int>(
    'hr_min',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hrMaxMeta = const VerificationMeta('hrMax');
  @override
  late final GeneratedColumn<int> hrMax = GeneratedColumn<int>(
    'hr_max',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sessionId,
    endNumber,
    subtotal,
    timestamp,
    endedAt,
    hrAvg,
    hrMin,
    hrMax,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ends';
  @override
  VerificationContext validateIntegrity(
    Insertable<End> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('end_number')) {
      context.handle(
        _endNumberMeta,
        endNumber.isAcceptableOrUnknown(data['end_number']!, _endNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_endNumberMeta);
    }
    if (data.containsKey('subtotal')) {
      context.handle(
        _subtotalMeta,
        subtotal.isAcceptableOrUnknown(data['subtotal']!, _subtotalMeta),
      );
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('ended_at')) {
      context.handle(
        _endedAtMeta,
        endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta),
      );
    }
    if (data.containsKey('hr_avg')) {
      context.handle(
        _hrAvgMeta,
        hrAvg.isAcceptableOrUnknown(data['hr_avg']!, _hrAvgMeta),
      );
    }
    if (data.containsKey('hr_min')) {
      context.handle(
        _hrMinMeta,
        hrMin.isAcceptableOrUnknown(data['hr_min']!, _hrMinMeta),
      );
    }
    if (data.containsKey('hr_max')) {
      context.handle(
        _hrMaxMeta,
        hrMax.isAcceptableOrUnknown(data['hr_max']!, _hrMaxMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  End map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return End(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}session_id'],
      )!,
      endNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}end_number'],
      )!,
      subtotal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}subtotal'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ended_at'],
      ),
      hrAvg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}hr_avg'],
      ),
      hrMin: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}hr_min'],
      ),
      hrMax: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}hr_max'],
      ),
    );
  }

  @override
  $EndsTable createAlias(String alias) {
    return $EndsTable(attachedDatabase, alias);
  }
}

class End extends DataClass implements Insertable<End> {
  final int id;
  final int sessionId;
  final int endNumber;
  final int subtotal;
  final DateTime timestamp;
  final DateTime? endedAt;
  final double? hrAvg;
  final int? hrMin;
  final int? hrMax;
  const End({
    required this.id,
    required this.sessionId,
    required this.endNumber,
    required this.subtotal,
    required this.timestamp,
    this.endedAt,
    this.hrAvg,
    this.hrMin,
    this.hrMax,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['session_id'] = Variable<int>(sessionId);
    map['end_number'] = Variable<int>(endNumber);
    map['subtotal'] = Variable<int>(subtotal);
    map['timestamp'] = Variable<DateTime>(timestamp);
    if (!nullToAbsent || endedAt != null) {
      map['ended_at'] = Variable<DateTime>(endedAt);
    }
    if (!nullToAbsent || hrAvg != null) {
      map['hr_avg'] = Variable<double>(hrAvg);
    }
    if (!nullToAbsent || hrMin != null) {
      map['hr_min'] = Variable<int>(hrMin);
    }
    if (!nullToAbsent || hrMax != null) {
      map['hr_max'] = Variable<int>(hrMax);
    }
    return map;
  }

  EndsCompanion toCompanion(bool nullToAbsent) {
    return EndsCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      endNumber: Value(endNumber),
      subtotal: Value(subtotal),
      timestamp: Value(timestamp),
      endedAt: endedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endedAt),
      hrAvg: hrAvg == null && nullToAbsent
          ? const Value.absent()
          : Value(hrAvg),
      hrMin: hrMin == null && nullToAbsent
          ? const Value.absent()
          : Value(hrMin),
      hrMax: hrMax == null && nullToAbsent
          ? const Value.absent()
          : Value(hrMax),
    );
  }

  factory End.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return End(
      id: serializer.fromJson<int>(json['id']),
      sessionId: serializer.fromJson<int>(json['sessionId']),
      endNumber: serializer.fromJson<int>(json['endNumber']),
      subtotal: serializer.fromJson<int>(json['subtotal']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      endedAt: serializer.fromJson<DateTime?>(json['endedAt']),
      hrAvg: serializer.fromJson<double?>(json['hrAvg']),
      hrMin: serializer.fromJson<int?>(json['hrMin']),
      hrMax: serializer.fromJson<int?>(json['hrMax']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sessionId': serializer.toJson<int>(sessionId),
      'endNumber': serializer.toJson<int>(endNumber),
      'subtotal': serializer.toJson<int>(subtotal),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'endedAt': serializer.toJson<DateTime?>(endedAt),
      'hrAvg': serializer.toJson<double?>(hrAvg),
      'hrMin': serializer.toJson<int?>(hrMin),
      'hrMax': serializer.toJson<int?>(hrMax),
    };
  }

  End copyWith({
    int? id,
    int? sessionId,
    int? endNumber,
    int? subtotal,
    DateTime? timestamp,
    Value<DateTime?> endedAt = const Value.absent(),
    Value<double?> hrAvg = const Value.absent(),
    Value<int?> hrMin = const Value.absent(),
    Value<int?> hrMax = const Value.absent(),
  }) => End(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    endNumber: endNumber ?? this.endNumber,
    subtotal: subtotal ?? this.subtotal,
    timestamp: timestamp ?? this.timestamp,
    endedAt: endedAt.present ? endedAt.value : this.endedAt,
    hrAvg: hrAvg.present ? hrAvg.value : this.hrAvg,
    hrMin: hrMin.present ? hrMin.value : this.hrMin,
    hrMax: hrMax.present ? hrMax.value : this.hrMax,
  );
  End copyWithCompanion(EndsCompanion data) {
    return End(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      endNumber: data.endNumber.present ? data.endNumber.value : this.endNumber,
      subtotal: data.subtotal.present ? data.subtotal.value : this.subtotal,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
      hrAvg: data.hrAvg.present ? data.hrAvg.value : this.hrAvg,
      hrMin: data.hrMin.present ? data.hrMin.value : this.hrMin,
      hrMax: data.hrMax.present ? data.hrMax.value : this.hrMax,
    );
  }

  @override
  String toString() {
    return (StringBuffer('End(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('endNumber: $endNumber, ')
          ..write('subtotal: $subtotal, ')
          ..write('timestamp: $timestamp, ')
          ..write('endedAt: $endedAt, ')
          ..write('hrAvg: $hrAvg, ')
          ..write('hrMin: $hrMin, ')
          ..write('hrMax: $hrMax')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sessionId,
    endNumber,
    subtotal,
    timestamp,
    endedAt,
    hrAvg,
    hrMin,
    hrMax,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is End &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.endNumber == this.endNumber &&
          other.subtotal == this.subtotal &&
          other.timestamp == this.timestamp &&
          other.endedAt == this.endedAt &&
          other.hrAvg == this.hrAvg &&
          other.hrMin == this.hrMin &&
          other.hrMax == this.hrMax);
}

class EndsCompanion extends UpdateCompanion<End> {
  final Value<int> id;
  final Value<int> sessionId;
  final Value<int> endNumber;
  final Value<int> subtotal;
  final Value<DateTime> timestamp;
  final Value<DateTime?> endedAt;
  final Value<double?> hrAvg;
  final Value<int?> hrMin;
  final Value<int?> hrMax;
  const EndsCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.endNumber = const Value.absent(),
    this.subtotal = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.hrAvg = const Value.absent(),
    this.hrMin = const Value.absent(),
    this.hrMax = const Value.absent(),
  });
  EndsCompanion.insert({
    this.id = const Value.absent(),
    required int sessionId,
    required int endNumber,
    this.subtotal = const Value.absent(),
    required DateTime timestamp,
    this.endedAt = const Value.absent(),
    this.hrAvg = const Value.absent(),
    this.hrMin = const Value.absent(),
    this.hrMax = const Value.absent(),
  }) : sessionId = Value(sessionId),
       endNumber = Value(endNumber),
       timestamp = Value(timestamp);
  static Insertable<End> custom({
    Expression<int>? id,
    Expression<int>? sessionId,
    Expression<int>? endNumber,
    Expression<int>? subtotal,
    Expression<DateTime>? timestamp,
    Expression<DateTime>? endedAt,
    Expression<double>? hrAvg,
    Expression<int>? hrMin,
    Expression<int>? hrMax,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (endNumber != null) 'end_number': endNumber,
      if (subtotal != null) 'subtotal': subtotal,
      if (timestamp != null) 'timestamp': timestamp,
      if (endedAt != null) 'ended_at': endedAt,
      if (hrAvg != null) 'hr_avg': hrAvg,
      if (hrMin != null) 'hr_min': hrMin,
      if (hrMax != null) 'hr_max': hrMax,
    });
  }

  EndsCompanion copyWith({
    Value<int>? id,
    Value<int>? sessionId,
    Value<int>? endNumber,
    Value<int>? subtotal,
    Value<DateTime>? timestamp,
    Value<DateTime?>? endedAt,
    Value<double?>? hrAvg,
    Value<int?>? hrMin,
    Value<int?>? hrMax,
  }) {
    return EndsCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      endNumber: endNumber ?? this.endNumber,
      subtotal: subtotal ?? this.subtotal,
      timestamp: timestamp ?? this.timestamp,
      endedAt: endedAt ?? this.endedAt,
      hrAvg: hrAvg ?? this.hrAvg,
      hrMin: hrMin ?? this.hrMin,
      hrMax: hrMax ?? this.hrMax,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<int>(sessionId.value);
    }
    if (endNumber.present) {
      map['end_number'] = Variable<int>(endNumber.value);
    }
    if (subtotal.present) {
      map['subtotal'] = Variable<int>(subtotal.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    if (hrAvg.present) {
      map['hr_avg'] = Variable<double>(hrAvg.value);
    }
    if (hrMin.present) {
      map['hr_min'] = Variable<int>(hrMin.value);
    }
    if (hrMax.present) {
      map['hr_max'] = Variable<int>(hrMax.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EndsCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('endNumber: $endNumber, ')
          ..write('subtotal: $subtotal, ')
          ..write('timestamp: $timestamp, ')
          ..write('endedAt: $endedAt, ')
          ..write('hrAvg: $hrAvg, ')
          ..write('hrMin: $hrMin, ')
          ..write('hrMax: $hrMax')
          ..write(')'))
        .toString();
  }
}

class $ArrowsTable extends Arrows with TableInfo<$ArrowsTable, Arrow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ArrowsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _endIdMeta = const VerificationMeta('endId');
  @override
  late final GeneratedColumn<int> endId = GeneratedColumn<int>(
    'end_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES ends (id)',
    ),
  );
  static const VerificationMeta _xMeta = const VerificationMeta('x');
  @override
  late final GeneratedColumn<double> x = GeneratedColumn<double>(
    'x',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _yMeta = const VerificationMeta('y');
  @override
  late final GeneratedColumn<double> y = GeneratedColumn<double>(
    'y',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<int> score = GeneratedColumn<int>(
    'score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _arrowNumberMeta = const VerificationMeta(
    'arrowNumber',
  );
  @override
  late final GeneratedColumn<int> arrowNumber = GeneratedColumn<int>(
    'arrow_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, endId, x, y, score, arrowNumber];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'arrows';
  @override
  VerificationContext validateIntegrity(
    Insertable<Arrow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('end_id')) {
      context.handle(
        _endIdMeta,
        endId.isAcceptableOrUnknown(data['end_id']!, _endIdMeta),
      );
    } else if (isInserting) {
      context.missing(_endIdMeta);
    }
    if (data.containsKey('x')) {
      context.handle(_xMeta, x.isAcceptableOrUnknown(data['x']!, _xMeta));
    } else if (isInserting) {
      context.missing(_xMeta);
    }
    if (data.containsKey('y')) {
      context.handle(_yMeta, y.isAcceptableOrUnknown(data['y']!, _yMeta));
    } else if (isInserting) {
      context.missing(_yMeta);
    }
    if (data.containsKey('score')) {
      context.handle(
        _scoreMeta,
        score.isAcceptableOrUnknown(data['score']!, _scoreMeta),
      );
    } else if (isInserting) {
      context.missing(_scoreMeta);
    }
    if (data.containsKey('arrow_number')) {
      context.handle(
        _arrowNumberMeta,
        arrowNumber.isAcceptableOrUnknown(
          data['arrow_number']!,
          _arrowNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_arrowNumberMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Arrow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Arrow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      endId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}end_id'],
      )!,
      x: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}x'],
      )!,
      y: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}y'],
      )!,
      score: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}score'],
      )!,
      arrowNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}arrow_number'],
      )!,
    );
  }

  @override
  $ArrowsTable createAlias(String alias) {
    return $ArrowsTable(attachedDatabase, alias);
  }
}

class Arrow extends DataClass implements Insertable<Arrow> {
  final int id;
  final int endId;
  final double x;
  final double y;
  final int score;
  final int arrowNumber;
  const Arrow({
    required this.id,
    required this.endId,
    required this.x,
    required this.y,
    required this.score,
    required this.arrowNumber,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['end_id'] = Variable<int>(endId);
    map['x'] = Variable<double>(x);
    map['y'] = Variable<double>(y);
    map['score'] = Variable<int>(score);
    map['arrow_number'] = Variable<int>(arrowNumber);
    return map;
  }

  ArrowsCompanion toCompanion(bool nullToAbsent) {
    return ArrowsCompanion(
      id: Value(id),
      endId: Value(endId),
      x: Value(x),
      y: Value(y),
      score: Value(score),
      arrowNumber: Value(arrowNumber),
    );
  }

  factory Arrow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Arrow(
      id: serializer.fromJson<int>(json['id']),
      endId: serializer.fromJson<int>(json['endId']),
      x: serializer.fromJson<double>(json['x']),
      y: serializer.fromJson<double>(json['y']),
      score: serializer.fromJson<int>(json['score']),
      arrowNumber: serializer.fromJson<int>(json['arrowNumber']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'endId': serializer.toJson<int>(endId),
      'x': serializer.toJson<double>(x),
      'y': serializer.toJson<double>(y),
      'score': serializer.toJson<int>(score),
      'arrowNumber': serializer.toJson<int>(arrowNumber),
    };
  }

  Arrow copyWith({
    int? id,
    int? endId,
    double? x,
    double? y,
    int? score,
    int? arrowNumber,
  }) => Arrow(
    id: id ?? this.id,
    endId: endId ?? this.endId,
    x: x ?? this.x,
    y: y ?? this.y,
    score: score ?? this.score,
    arrowNumber: arrowNumber ?? this.arrowNumber,
  );
  Arrow copyWithCompanion(ArrowsCompanion data) {
    return Arrow(
      id: data.id.present ? data.id.value : this.id,
      endId: data.endId.present ? data.endId.value : this.endId,
      x: data.x.present ? data.x.value : this.x,
      y: data.y.present ? data.y.value : this.y,
      score: data.score.present ? data.score.value : this.score,
      arrowNumber: data.arrowNumber.present
          ? data.arrowNumber.value
          : this.arrowNumber,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Arrow(')
          ..write('id: $id, ')
          ..write('endId: $endId, ')
          ..write('x: $x, ')
          ..write('y: $y, ')
          ..write('score: $score, ')
          ..write('arrowNumber: $arrowNumber')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, endId, x, y, score, arrowNumber);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Arrow &&
          other.id == this.id &&
          other.endId == this.endId &&
          other.x == this.x &&
          other.y == this.y &&
          other.score == this.score &&
          other.arrowNumber == this.arrowNumber);
}

class ArrowsCompanion extends UpdateCompanion<Arrow> {
  final Value<int> id;
  final Value<int> endId;
  final Value<double> x;
  final Value<double> y;
  final Value<int> score;
  final Value<int> arrowNumber;
  const ArrowsCompanion({
    this.id = const Value.absent(),
    this.endId = const Value.absent(),
    this.x = const Value.absent(),
    this.y = const Value.absent(),
    this.score = const Value.absent(),
    this.arrowNumber = const Value.absent(),
  });
  ArrowsCompanion.insert({
    this.id = const Value.absent(),
    required int endId,
    required double x,
    required double y,
    required int score,
    required int arrowNumber,
  }) : endId = Value(endId),
       x = Value(x),
       y = Value(y),
       score = Value(score),
       arrowNumber = Value(arrowNumber);
  static Insertable<Arrow> custom({
    Expression<int>? id,
    Expression<int>? endId,
    Expression<double>? x,
    Expression<double>? y,
    Expression<int>? score,
    Expression<int>? arrowNumber,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (endId != null) 'end_id': endId,
      if (x != null) 'x': x,
      if (y != null) 'y': y,
      if (score != null) 'score': score,
      if (arrowNumber != null) 'arrow_number': arrowNumber,
    });
  }

  ArrowsCompanion copyWith({
    Value<int>? id,
    Value<int>? endId,
    Value<double>? x,
    Value<double>? y,
    Value<int>? score,
    Value<int>? arrowNumber,
  }) {
    return ArrowsCompanion(
      id: id ?? this.id,
      endId: endId ?? this.endId,
      x: x ?? this.x,
      y: y ?? this.y,
      score: score ?? this.score,
      arrowNumber: arrowNumber ?? this.arrowNumber,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (endId.present) {
      map['end_id'] = Variable<int>(endId.value);
    }
    if (x.present) {
      map['x'] = Variable<double>(x.value);
    }
    if (y.present) {
      map['y'] = Variable<double>(y.value);
    }
    if (score.present) {
      map['score'] = Variable<int>(score.value);
    }
    if (arrowNumber.present) {
      map['arrow_number'] = Variable<int>(arrowNumber.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ArrowsCompanion(')
          ..write('id: $id, ')
          ..write('endId: $endId, ')
          ..write('x: $x, ')
          ..write('y: $y, ')
          ..write('score: $score, ')
          ..write('arrowNumber: $arrowNumber')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SessionsTable sessions = $SessionsTable(this);
  late final $EndsTable ends = $EndsTable(this);
  late final $ArrowsTable arrows = $ArrowsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [sessions, ends, arrows];
}

typedef $$SessionsTableCreateCompanionBuilder =
    SessionsCompanion Function({
      Value<int> id,
      required int targetType,
      required int arrowsPerEnd,
      required DateTime startedAt,
      Value<DateTime?> endedAt,
      Value<int> totalScore,
      Value<int> totalArrows,
    });
typedef $$SessionsTableUpdateCompanionBuilder =
    SessionsCompanion Function({
      Value<int> id,
      Value<int> targetType,
      Value<int> arrowsPerEnd,
      Value<DateTime> startedAt,
      Value<DateTime?> endedAt,
      Value<int> totalScore,
      Value<int> totalArrows,
    });

final class $$SessionsTableReferences
    extends BaseReferences<_$AppDatabase, $SessionsTable, Session> {
  $$SessionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$EndsTable, List<End>> _endsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.ends,
    aliasName: $_aliasNameGenerator(db.sessions.id, db.ends.sessionId),
  );

  $$EndsTableProcessedTableManager get endsRefs {
    final manager = $$EndsTableTableManager(
      $_db,
      $_db.ends,
    ).filter((f) => f.sessionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_endsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SessionsTableFilterComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetType => $composableBuilder(
    column: $table.targetType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get arrowsPerEnd => $composableBuilder(
    column: $table.arrowsPerEnd,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalScore => $composableBuilder(
    column: $table.totalScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalArrows => $composableBuilder(
    column: $table.totalArrows,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> endsRefs(
    Expression<bool> Function($$EndsTableFilterComposer f) f,
  ) {
    final $$EndsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ends,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EndsTableFilterComposer(
            $db: $db,
            $table: $db.ends,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetType => $composableBuilder(
    column: $table.targetType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get arrowsPerEnd => $composableBuilder(
    column: $table.arrowsPerEnd,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalScore => $composableBuilder(
    column: $table.totalScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalArrows => $composableBuilder(
    column: $table.totalArrows,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get targetType => $composableBuilder(
    column: $table.targetType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get arrowsPerEnd => $composableBuilder(
    column: $table.arrowsPerEnd,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  GeneratedColumn<int> get totalScore => $composableBuilder(
    column: $table.totalScore,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalArrows => $composableBuilder(
    column: $table.totalArrows,
    builder: (column) => column,
  );

  Expression<T> endsRefs<T extends Object>(
    Expression<T> Function($$EndsTableAnnotationComposer a) f,
  ) {
    final $$EndsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ends,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EndsTableAnnotationComposer(
            $db: $db,
            $table: $db.ends,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SessionsTable,
          Session,
          $$SessionsTableFilterComposer,
          $$SessionsTableOrderingComposer,
          $$SessionsTableAnnotationComposer,
          $$SessionsTableCreateCompanionBuilder,
          $$SessionsTableUpdateCompanionBuilder,
          (Session, $$SessionsTableReferences),
          Session,
          PrefetchHooks Function({bool endsRefs})
        > {
  $$SessionsTableTableManager(_$AppDatabase db, $SessionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> targetType = const Value.absent(),
                Value<int> arrowsPerEnd = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> endedAt = const Value.absent(),
                Value<int> totalScore = const Value.absent(),
                Value<int> totalArrows = const Value.absent(),
              }) => SessionsCompanion(
                id: id,
                targetType: targetType,
                arrowsPerEnd: arrowsPerEnd,
                startedAt: startedAt,
                endedAt: endedAt,
                totalScore: totalScore,
                totalArrows: totalArrows,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int targetType,
                required int arrowsPerEnd,
                required DateTime startedAt,
                Value<DateTime?> endedAt = const Value.absent(),
                Value<int> totalScore = const Value.absent(),
                Value<int> totalArrows = const Value.absent(),
              }) => SessionsCompanion.insert(
                id: id,
                targetType: targetType,
                arrowsPerEnd: arrowsPerEnd,
                startedAt: startedAt,
                endedAt: endedAt,
                totalScore: totalScore,
                totalArrows: totalArrows,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SessionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({endsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (endsRefs) db.ends],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (endsRefs)
                    await $_getPrefetchedData<Session, $SessionsTable, End>(
                      currentTable: table,
                      referencedTable: $$SessionsTableReferences._endsRefsTable(
                        db,
                      ),
                      managerFromTypedResult: (p0) =>
                          $$SessionsTableReferences(db, table, p0).endsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.sessionId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SessionsTable,
      Session,
      $$SessionsTableFilterComposer,
      $$SessionsTableOrderingComposer,
      $$SessionsTableAnnotationComposer,
      $$SessionsTableCreateCompanionBuilder,
      $$SessionsTableUpdateCompanionBuilder,
      (Session, $$SessionsTableReferences),
      Session,
      PrefetchHooks Function({bool endsRefs})
    >;
typedef $$EndsTableCreateCompanionBuilder =
    EndsCompanion Function({
      Value<int> id,
      required int sessionId,
      required int endNumber,
      Value<int> subtotal,
      required DateTime timestamp,
      Value<DateTime?> endedAt,
      Value<double?> hrAvg,
      Value<int?> hrMin,
      Value<int?> hrMax,
    });
typedef $$EndsTableUpdateCompanionBuilder =
    EndsCompanion Function({
      Value<int> id,
      Value<int> sessionId,
      Value<int> endNumber,
      Value<int> subtotal,
      Value<DateTime> timestamp,
      Value<DateTime?> endedAt,
      Value<double?> hrAvg,
      Value<int?> hrMin,
      Value<int?> hrMax,
    });

final class $$EndsTableReferences
    extends BaseReferences<_$AppDatabase, $EndsTable, End> {
  $$EndsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SessionsTable _sessionIdTable(_$AppDatabase db) => db.sessions
      .createAlias($_aliasNameGenerator(db.ends.sessionId, db.sessions.id));

  $$SessionsTableProcessedTableManager get sessionId {
    final $_column = $_itemColumn<int>('session_id')!;

    final manager = $$SessionsTableTableManager(
      $_db,
      $_db.sessions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ArrowsTable, List<Arrow>> _arrowsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.arrows,
    aliasName: $_aliasNameGenerator(db.ends.id, db.arrows.endId),
  );

  $$ArrowsTableProcessedTableManager get arrowsRefs {
    final manager = $$ArrowsTableTableManager(
      $_db,
      $_db.arrows,
    ).filter((f) => f.endId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_arrowsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$EndsTableFilterComposer extends Composer<_$AppDatabase, $EndsTable> {
  $$EndsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get endNumber => $composableBuilder(
    column: $table.endNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get hrAvg => $composableBuilder(
    column: $table.hrAvg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hrMin => $composableBuilder(
    column: $table.hrMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hrMax => $composableBuilder(
    column: $table.hrMax,
    builder: (column) => ColumnFilters(column),
  );

  $$SessionsTableFilterComposer get sessionId {
    final $$SessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableFilterComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> arrowsRefs(
    Expression<bool> Function($$ArrowsTableFilterComposer f) f,
  ) {
    final $$ArrowsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.arrows,
      getReferencedColumn: (t) => t.endId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ArrowsTableFilterComposer(
            $db: $db,
            $table: $db.arrows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EndsTableOrderingComposer extends Composer<_$AppDatabase, $EndsTable> {
  $$EndsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get endNumber => $composableBuilder(
    column: $table.endNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get hrAvg => $composableBuilder(
    column: $table.hrAvg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hrMin => $composableBuilder(
    column: $table.hrMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hrMax => $composableBuilder(
    column: $table.hrMax,
    builder: (column) => ColumnOrderings(column),
  );

  $$SessionsTableOrderingComposer get sessionId {
    final $$SessionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableOrderingComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EndsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EndsTable> {
  $$EndsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get endNumber =>
      $composableBuilder(column: $table.endNumber, builder: (column) => column);

  GeneratedColumn<int> get subtotal =>
      $composableBuilder(column: $table.subtotal, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<DateTime> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  GeneratedColumn<double> get hrAvg =>
      $composableBuilder(column: $table.hrAvg, builder: (column) => column);

  GeneratedColumn<int> get hrMin =>
      $composableBuilder(column: $table.hrMin, builder: (column) => column);

  GeneratedColumn<int> get hrMax =>
      $composableBuilder(column: $table.hrMax, builder: (column) => column);

  $$SessionsTableAnnotationComposer get sessionId {
    final $$SessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> arrowsRefs<T extends Object>(
    Expression<T> Function($$ArrowsTableAnnotationComposer a) f,
  ) {
    final $$ArrowsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.arrows,
      getReferencedColumn: (t) => t.endId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ArrowsTableAnnotationComposer(
            $db: $db,
            $table: $db.arrows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EndsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EndsTable,
          End,
          $$EndsTableFilterComposer,
          $$EndsTableOrderingComposer,
          $$EndsTableAnnotationComposer,
          $$EndsTableCreateCompanionBuilder,
          $$EndsTableUpdateCompanionBuilder,
          (End, $$EndsTableReferences),
          End,
          PrefetchHooks Function({bool sessionId, bool arrowsRefs})
        > {
  $$EndsTableTableManager(_$AppDatabase db, $EndsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EndsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EndsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EndsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> sessionId = const Value.absent(),
                Value<int> endNumber = const Value.absent(),
                Value<int> subtotal = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<DateTime?> endedAt = const Value.absent(),
                Value<double?> hrAvg = const Value.absent(),
                Value<int?> hrMin = const Value.absent(),
                Value<int?> hrMax = const Value.absent(),
              }) => EndsCompanion(
                id: id,
                sessionId: sessionId,
                endNumber: endNumber,
                subtotal: subtotal,
                timestamp: timestamp,
                endedAt: endedAt,
                hrAvg: hrAvg,
                hrMin: hrMin,
                hrMax: hrMax,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int sessionId,
                required int endNumber,
                Value<int> subtotal = const Value.absent(),
                required DateTime timestamp,
                Value<DateTime?> endedAt = const Value.absent(),
                Value<double?> hrAvg = const Value.absent(),
                Value<int?> hrMin = const Value.absent(),
                Value<int?> hrMax = const Value.absent(),
              }) => EndsCompanion.insert(
                id: id,
                sessionId: sessionId,
                endNumber: endNumber,
                subtotal: subtotal,
                timestamp: timestamp,
                endedAt: endedAt,
                hrAvg: hrAvg,
                hrMin: hrMin,
                hrMax: hrMax,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$EndsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({sessionId = false, arrowsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (arrowsRefs) db.arrows],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (sessionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.sessionId,
                                referencedTable: $$EndsTableReferences
                                    ._sessionIdTable(db),
                                referencedColumn: $$EndsTableReferences
                                    ._sessionIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (arrowsRefs)
                    await $_getPrefetchedData<End, $EndsTable, Arrow>(
                      currentTable: table,
                      referencedTable: $$EndsTableReferences._arrowsRefsTable(
                        db,
                      ),
                      managerFromTypedResult: (p0) =>
                          $$EndsTableReferences(db, table, p0).arrowsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.endId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$EndsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EndsTable,
      End,
      $$EndsTableFilterComposer,
      $$EndsTableOrderingComposer,
      $$EndsTableAnnotationComposer,
      $$EndsTableCreateCompanionBuilder,
      $$EndsTableUpdateCompanionBuilder,
      (End, $$EndsTableReferences),
      End,
      PrefetchHooks Function({bool sessionId, bool arrowsRefs})
    >;
typedef $$ArrowsTableCreateCompanionBuilder =
    ArrowsCompanion Function({
      Value<int> id,
      required int endId,
      required double x,
      required double y,
      required int score,
      required int arrowNumber,
    });
typedef $$ArrowsTableUpdateCompanionBuilder =
    ArrowsCompanion Function({
      Value<int> id,
      Value<int> endId,
      Value<double> x,
      Value<double> y,
      Value<int> score,
      Value<int> arrowNumber,
    });

final class $$ArrowsTableReferences
    extends BaseReferences<_$AppDatabase, $ArrowsTable, Arrow> {
  $$ArrowsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $EndsTable _endIdTable(_$AppDatabase db) =>
      db.ends.createAlias($_aliasNameGenerator(db.arrows.endId, db.ends.id));

  $$EndsTableProcessedTableManager get endId {
    final $_column = $_itemColumn<int>('end_id')!;

    final manager = $$EndsTableTableManager(
      $_db,
      $_db.ends,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_endIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ArrowsTableFilterComposer
    extends Composer<_$AppDatabase, $ArrowsTable> {
  $$ArrowsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get x => $composableBuilder(
    column: $table.x,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get y => $composableBuilder(
    column: $table.y,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get arrowNumber => $composableBuilder(
    column: $table.arrowNumber,
    builder: (column) => ColumnFilters(column),
  );

  $$EndsTableFilterComposer get endId {
    final $$EndsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.endId,
      referencedTable: $db.ends,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EndsTableFilterComposer(
            $db: $db,
            $table: $db.ends,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ArrowsTableOrderingComposer
    extends Composer<_$AppDatabase, $ArrowsTable> {
  $$ArrowsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get x => $composableBuilder(
    column: $table.x,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get y => $composableBuilder(
    column: $table.y,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get arrowNumber => $composableBuilder(
    column: $table.arrowNumber,
    builder: (column) => ColumnOrderings(column),
  );

  $$EndsTableOrderingComposer get endId {
    final $$EndsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.endId,
      referencedTable: $db.ends,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EndsTableOrderingComposer(
            $db: $db,
            $table: $db.ends,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ArrowsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ArrowsTable> {
  $$ArrowsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get x =>
      $composableBuilder(column: $table.x, builder: (column) => column);

  GeneratedColumn<double> get y =>
      $composableBuilder(column: $table.y, builder: (column) => column);

  GeneratedColumn<int> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  GeneratedColumn<int> get arrowNumber => $composableBuilder(
    column: $table.arrowNumber,
    builder: (column) => column,
  );

  $$EndsTableAnnotationComposer get endId {
    final $$EndsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.endId,
      referencedTable: $db.ends,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EndsTableAnnotationComposer(
            $db: $db,
            $table: $db.ends,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ArrowsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ArrowsTable,
          Arrow,
          $$ArrowsTableFilterComposer,
          $$ArrowsTableOrderingComposer,
          $$ArrowsTableAnnotationComposer,
          $$ArrowsTableCreateCompanionBuilder,
          $$ArrowsTableUpdateCompanionBuilder,
          (Arrow, $$ArrowsTableReferences),
          Arrow,
          PrefetchHooks Function({bool endId})
        > {
  $$ArrowsTableTableManager(_$AppDatabase db, $ArrowsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ArrowsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ArrowsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ArrowsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> endId = const Value.absent(),
                Value<double> x = const Value.absent(),
                Value<double> y = const Value.absent(),
                Value<int> score = const Value.absent(),
                Value<int> arrowNumber = const Value.absent(),
              }) => ArrowsCompanion(
                id: id,
                endId: endId,
                x: x,
                y: y,
                score: score,
                arrowNumber: arrowNumber,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int endId,
                required double x,
                required double y,
                required int score,
                required int arrowNumber,
              }) => ArrowsCompanion.insert(
                id: id,
                endId: endId,
                x: x,
                y: y,
                score: score,
                arrowNumber: arrowNumber,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$ArrowsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({endId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (endId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.endId,
                                referencedTable: $$ArrowsTableReferences
                                    ._endIdTable(db),
                                referencedColumn: $$ArrowsTableReferences
                                    ._endIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ArrowsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ArrowsTable,
      Arrow,
      $$ArrowsTableFilterComposer,
      $$ArrowsTableOrderingComposer,
      $$ArrowsTableAnnotationComposer,
      $$ArrowsTableCreateCompanionBuilder,
      $$ArrowsTableUpdateCompanionBuilder,
      (Arrow, $$ArrowsTableReferences),
      Arrow,
      PrefetchHooks Function({bool endId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SessionsTableTableManager get sessions =>
      $$SessionsTableTableManager(_db, _db.sessions);
  $$EndsTableTableManager get ends => $$EndsTableTableManager(_db, _db.ends);
  $$ArrowsTableTableManager get arrows =>
      $$ArrowsTableTableManager(_db, _db.arrows);
}
