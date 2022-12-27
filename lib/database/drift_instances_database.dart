import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'drift_instances_database_tables.dart';
import '../models/models.dart';
part 'drift_instances_database.g.dart';

@DriftDatabase(tables: [DriftInstances, DriftInstancesPingStatuses])
class DriftInstancesDatabase extends _$DriftInstancesDatabase {
  DriftInstancesDatabase() : super(_openDatabase());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openDatabase() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftAccessor(tables: [DriftInstances])
class InstancesDao extends DatabaseAccessor<DriftInstancesDatabase>
    with _$InstancesDaoMixin {
  final DriftInstancesDatabase db;
  InstancesDao(this.db) : super(db);

  Stream<List<DriftInstance>> watchAllInstances() {
    return select(driftInstances).watch();
  }

  Future<int> addInstance(DriftInstancesCompanion instance) {
    return into(driftInstances).insert(instance);
  }

  Future updateInstance(DriftInstance instance) {
    return (update(driftInstances)..where((tbl) => tbl.id.equals(instance.id)))
        .replace(instance);
  }

  Future removeInstance(DriftInstance instance) {
    return (delete(driftInstances)..where((tbl) => tbl.id.equals(instance.id)))
        .go();
  }
}

@DriftAccessor(tables: [DriftInstancesPingStatuses])
class InstancesPingStatusDao extends DatabaseAccessor<DriftInstancesDatabase>
    with _$InstancesPingStatusDaoMixin {
  final DriftInstancesDatabase db;
  InstancesPingStatusDao(this.db) : super(db);

  Stream<List<DriftInstancesPingStatus>> searchInstancesPingStatusByInstanceId(
      DriftInstance instance) {
    return (select(driftInstancesPingStatuses)
          ..where((tbl) => tbl.instanceId.equals(instance.id)))
        .watch();
  }

  Future removeInstancePingStatus(DriftInstancesPingStatus status) {
    return (delete(driftInstancesPingStatuses)
          ..where((tbl) => tbl.id.equals(status.id)))
        .go();
  }

  Future<int> addInstancePingStatus(
      DriftInstancesPingStatusesCompanion status) {
    return into(driftInstancesPingStatuses).insert(status);
  }
}

// Conversion methods

Instance driftInstanceToInstance(DriftInstance instance) {
  return Instance(
      id: instance.id,
      instanceName: instance.instanceName,
      instanceUrl: instance.instanceUrl);
}

Insertable<DriftInstance> instanceToDriftInstance(Instance instance) {
  return DriftInstancesCompanion.insert(
      instanceName: instance.instanceName, instanceUrl: instance.instanceUrl);
}

InstancesPingStatus driftInstancesPingStatusToInstancesPingStatus(
    DriftInstancesPingStatus pingStatus) {
  return InstancesPingStatus(
      id: pingStatus.id,
      instanceId: pingStatus.instanceId,
      statusCode: pingStatus.statusCode,
      pingTime: pingStatus.pingTime);
}

Insertable<DriftInstancesPingStatus>
    instancesPingStatusToDriftInstancesPingStatus(
        InstancesPingStatus pingStatus) {
  return DriftInstancesPingStatusesCompanion.insert(
      instanceId: pingStatus.instanceId,
      statusCode: pingStatus.statusCode,
      pingTime: pingStatus.pingTime);
}
