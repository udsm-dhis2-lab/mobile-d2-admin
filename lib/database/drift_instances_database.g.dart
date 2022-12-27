// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_instances_database.dart';

// ignore_for_file: type=lint
class DriftInstance extends DataClass implements Insertable<DriftInstance> {
  final int id;
  final String instanceName;
  final String instanceUrl;
  const DriftInstance(
      {required this.id,
      required this.instanceName,
      required this.instanceUrl});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['instance_name'] = Variable<String>(instanceName);
    map['instance_url'] = Variable<String>(instanceUrl);
    return map;
  }

  DriftInstancesCompanion toCompanion(bool nullToAbsent) {
    return DriftInstancesCompanion(
      id: Value(id),
      instanceName: Value(instanceName),
      instanceUrl: Value(instanceUrl),
    );
  }

  factory DriftInstance.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DriftInstance(
      id: serializer.fromJson<int>(json['id']),
      instanceName: serializer.fromJson<String>(json['instanceName']),
      instanceUrl: serializer.fromJson<String>(json['instanceUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'instanceName': serializer.toJson<String>(instanceName),
      'instanceUrl': serializer.toJson<String>(instanceUrl),
    };
  }

  DriftInstance copyWith(
          {int? id, String? instanceName, String? instanceUrl}) =>
      DriftInstance(
        id: id ?? this.id,
        instanceName: instanceName ?? this.instanceName,
        instanceUrl: instanceUrl ?? this.instanceUrl,
      );
  @override
  String toString() {
    return (StringBuffer('DriftInstance(')
          ..write('id: $id, ')
          ..write('instanceName: $instanceName, ')
          ..write('instanceUrl: $instanceUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, instanceName, instanceUrl);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DriftInstance &&
          other.id == this.id &&
          other.instanceName == this.instanceName &&
          other.instanceUrl == this.instanceUrl);
}

class DriftInstancesCompanion extends UpdateCompanion<DriftInstance> {
  final Value<int> id;
  final Value<String> instanceName;
  final Value<String> instanceUrl;
  const DriftInstancesCompanion({
    this.id = const Value.absent(),
    this.instanceName = const Value.absent(),
    this.instanceUrl = const Value.absent(),
  });
  DriftInstancesCompanion.insert({
    this.id = const Value.absent(),
    required String instanceName,
    required String instanceUrl,
  })  : instanceName = Value(instanceName),
        instanceUrl = Value(instanceUrl);
  static Insertable<DriftInstance> custom({
    Expression<int>? id,
    Expression<String>? instanceName,
    Expression<String>? instanceUrl,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (instanceName != null) 'instance_name': instanceName,
      if (instanceUrl != null) 'instance_url': instanceUrl,
    });
  }

  DriftInstancesCompanion copyWith(
      {Value<int>? id,
      Value<String>? instanceName,
      Value<String>? instanceUrl}) {
    return DriftInstancesCompanion(
      id: id ?? this.id,
      instanceName: instanceName ?? this.instanceName,
      instanceUrl: instanceUrl ?? this.instanceUrl,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (instanceName.present) {
      map['instance_name'] = Variable<String>(instanceName.value);
    }
    if (instanceUrl.present) {
      map['instance_url'] = Variable<String>(instanceUrl.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DriftInstancesCompanion(')
          ..write('id: $id, ')
          ..write('instanceName: $instanceName, ')
          ..write('instanceUrl: $instanceUrl')
          ..write(')'))
        .toString();
  }
}

class $DriftInstancesTable extends DriftInstances
    with TableInfo<$DriftInstancesTable, DriftInstance> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DriftInstancesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _instanceNameMeta =
      const VerificationMeta('instanceName');
  @override
  late final GeneratedColumn<String> instanceName = GeneratedColumn<String>(
      'instance_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _instanceUrlMeta =
      const VerificationMeta('instanceUrl');
  @override
  late final GeneratedColumn<String> instanceUrl = GeneratedColumn<String>(
      'instance_url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, instanceName, instanceUrl];
  @override
  String get aliasedName => _alias ?? 'drift_instances';
  @override
  String get actualTableName => 'drift_instances';
  @override
  VerificationContext validateIntegrity(Insertable<DriftInstance> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('instance_name')) {
      context.handle(
          _instanceNameMeta,
          instanceName.isAcceptableOrUnknown(
              data['instance_name']!, _instanceNameMeta));
    } else if (isInserting) {
      context.missing(_instanceNameMeta);
    }
    if (data.containsKey('instance_url')) {
      context.handle(
          _instanceUrlMeta,
          instanceUrl.isAcceptableOrUnknown(
              data['instance_url']!, _instanceUrlMeta));
    } else if (isInserting) {
      context.missing(_instanceUrlMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DriftInstance map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DriftInstance(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      instanceName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}instance_name'])!,
      instanceUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}instance_url'])!,
    );
  }

  @override
  $DriftInstancesTable createAlias(String alias) {
    return $DriftInstancesTable(attachedDatabase, alias);
  }
}

class DriftInstancesPingStatus extends DataClass
    implements Insertable<DriftInstancesPingStatus> {
  final int id;
  final int instanceId;
  final String statusCode;
  final DateTime pingTime;
  const DriftInstancesPingStatus(
      {required this.id,
      required this.instanceId,
      required this.statusCode,
      required this.pingTime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['instance_id'] = Variable<int>(instanceId);
    map['status_code'] = Variable<String>(statusCode);
    map['ping_time'] = Variable<DateTime>(pingTime);
    return map;
  }

  DriftInstancesPingStatusesCompanion toCompanion(bool nullToAbsent) {
    return DriftInstancesPingStatusesCompanion(
      id: Value(id),
      instanceId: Value(instanceId),
      statusCode: Value(statusCode),
      pingTime: Value(pingTime),
    );
  }

  factory DriftInstancesPingStatus.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DriftInstancesPingStatus(
      id: serializer.fromJson<int>(json['id']),
      instanceId: serializer.fromJson<int>(json['instanceId']),
      statusCode: serializer.fromJson<String>(json['statusCode']),
      pingTime: serializer.fromJson<DateTime>(json['pingTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'instanceId': serializer.toJson<int>(instanceId),
      'statusCode': serializer.toJson<String>(statusCode),
      'pingTime': serializer.toJson<DateTime>(pingTime),
    };
  }

  DriftInstancesPingStatus copyWith(
          {int? id, int? instanceId, String? statusCode, DateTime? pingTime}) =>
      DriftInstancesPingStatus(
        id: id ?? this.id,
        instanceId: instanceId ?? this.instanceId,
        statusCode: statusCode ?? this.statusCode,
        pingTime: pingTime ?? this.pingTime,
      );
  @override
  String toString() {
    return (StringBuffer('DriftInstancesPingStatus(')
          ..write('id: $id, ')
          ..write('instanceId: $instanceId, ')
          ..write('statusCode: $statusCode, ')
          ..write('pingTime: $pingTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, instanceId, statusCode, pingTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DriftInstancesPingStatus &&
          other.id == this.id &&
          other.instanceId == this.instanceId &&
          other.statusCode == this.statusCode &&
          other.pingTime == this.pingTime);
}

class DriftInstancesPingStatusesCompanion
    extends UpdateCompanion<DriftInstancesPingStatus> {
  final Value<int> id;
  final Value<int> instanceId;
  final Value<String> statusCode;
  final Value<DateTime> pingTime;
  const DriftInstancesPingStatusesCompanion({
    this.id = const Value.absent(),
    this.instanceId = const Value.absent(),
    this.statusCode = const Value.absent(),
    this.pingTime = const Value.absent(),
  });
  DriftInstancesPingStatusesCompanion.insert({
    this.id = const Value.absent(),
    required int instanceId,
    required String statusCode,
    required DateTime pingTime,
  })  : instanceId = Value(instanceId),
        statusCode = Value(statusCode),
        pingTime = Value(pingTime);
  static Insertable<DriftInstancesPingStatus> custom({
    Expression<int>? id,
    Expression<int>? instanceId,
    Expression<String>? statusCode,
    Expression<DateTime>? pingTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (instanceId != null) 'instance_id': instanceId,
      if (statusCode != null) 'status_code': statusCode,
      if (pingTime != null) 'ping_time': pingTime,
    });
  }

  DriftInstancesPingStatusesCompanion copyWith(
      {Value<int>? id,
      Value<int>? instanceId,
      Value<String>? statusCode,
      Value<DateTime>? pingTime}) {
    return DriftInstancesPingStatusesCompanion(
      id: id ?? this.id,
      instanceId: instanceId ?? this.instanceId,
      statusCode: statusCode ?? this.statusCode,
      pingTime: pingTime ?? this.pingTime,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (instanceId.present) {
      map['instance_id'] = Variable<int>(instanceId.value);
    }
    if (statusCode.present) {
      map['status_code'] = Variable<String>(statusCode.value);
    }
    if (pingTime.present) {
      map['ping_time'] = Variable<DateTime>(pingTime.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DriftInstancesPingStatusesCompanion(')
          ..write('id: $id, ')
          ..write('instanceId: $instanceId, ')
          ..write('statusCode: $statusCode, ')
          ..write('pingTime: $pingTime')
          ..write(')'))
        .toString();
  }
}

class $DriftInstancesPingStatusesTable extends DriftInstancesPingStatuses
    with TableInfo<$DriftInstancesPingStatusesTable, DriftInstancesPingStatus> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DriftInstancesPingStatusesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _instanceIdMeta =
      const VerificationMeta('instanceId');
  @override
  late final GeneratedColumn<int> instanceId = GeneratedColumn<int>(
      'instance_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _statusCodeMeta =
      const VerificationMeta('statusCode');
  @override
  late final GeneratedColumn<String> statusCode = GeneratedColumn<String>(
      'status_code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pingTimeMeta =
      const VerificationMeta('pingTime');
  @override
  late final GeneratedColumn<DateTime> pingTime = GeneratedColumn<DateTime>(
      'ping_time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, instanceId, statusCode, pingTime];
  @override
  String get aliasedName => _alias ?? 'drift_instances_ping_statuses';
  @override
  String get actualTableName => 'drift_instances_ping_statuses';
  @override
  VerificationContext validateIntegrity(
      Insertable<DriftInstancesPingStatus> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('instance_id')) {
      context.handle(
          _instanceIdMeta,
          instanceId.isAcceptableOrUnknown(
              data['instance_id']!, _instanceIdMeta));
    } else if (isInserting) {
      context.missing(_instanceIdMeta);
    }
    if (data.containsKey('status_code')) {
      context.handle(
          _statusCodeMeta,
          statusCode.isAcceptableOrUnknown(
              data['status_code']!, _statusCodeMeta));
    } else if (isInserting) {
      context.missing(_statusCodeMeta);
    }
    if (data.containsKey('ping_time')) {
      context.handle(_pingTimeMeta,
          pingTime.isAcceptableOrUnknown(data['ping_time']!, _pingTimeMeta));
    } else if (isInserting) {
      context.missing(_pingTimeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DriftInstancesPingStatus map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DriftInstancesPingStatus(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      instanceId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}instance_id'])!,
      statusCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status_code'])!,
      pingTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}ping_time'])!,
    );
  }

  @override
  $DriftInstancesPingStatusesTable createAlias(String alias) {
    return $DriftInstancesPingStatusesTable(attachedDatabase, alias);
  }
}

abstract class _$DriftInstancesDatabase extends GeneratedDatabase {
  _$DriftInstancesDatabase(QueryExecutor e) : super(e);
  late final $DriftInstancesTable driftInstances = $DriftInstancesTable(this);
  late final $DriftInstancesPingStatusesTable driftInstancesPingStatuses =
      $DriftInstancesPingStatusesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [driftInstances, driftInstancesPingStatuses];
}

mixin _$InstancesDaoMixin on DatabaseAccessor<DriftInstancesDatabase> {
  $DriftInstancesTable get driftInstances => attachedDatabase.driftInstances;
}
mixin _$InstancesPingStatusDaoMixin
    on DatabaseAccessor<DriftInstancesDatabase> {
  $DriftInstancesPingStatusesTable get driftInstancesPingStatuses =>
      attachedDatabase.driftInstancesPingStatuses;
}
