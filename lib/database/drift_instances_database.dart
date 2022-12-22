import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'package:mobile_d2_admin/database/drift_instances_database_tables.dart';
part 'drift_instances_database.g.dart';

@DriftDatabase(tables: [Instances, InstancesPingStatuses])
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

@DriftAccessor(tables: [Instances])
class InstancesDao extends DatabaseAccessor<DriftInstancesDatabase>
    with _$InstancesDaoMixin {
  final DriftInstancesDatabase db;
  InstancesDao(this.db) : super(db);

  Stream<List<Instance>> watchAllInstances() {
    return select(instances).watch();
  }

  Future<int> addInstance(InstancesCompanion instance) {
    return into(instances).insert(instance);
  }

  Future updateInstance(Instance instance) {
    return (update(instances)..where((tbl) => tbl.id.equals(instance.id)))
        .replace(instance);
  }

  Future removeInstance(Instance instance) {
    return (delete(instances)..where((tbl) => tbl.id.equals(instance.id)))
        .go();
  }
}

@DriftAccessor(tables: [InstancesPingStatuses])
class InstancesPingStatusDao extends DatabaseAccessor<DriftInstancesDatabase>
    with _$InstancesPingStatusDaoMixin {
  final DriftInstancesDatabase db;
  InstancesPingStatusDao(this.db) : super(db);

  Stream<List<InstancesPingStatus>> searchInstancesPingStatusByInstanceId(
      Instance instance) {
    return (select(instancesPingStatuses)
          ..where((tbl) => tbl.instanceId.equals(instance.id)))
        .watch();
  }

  Future removeInstancePingStatus(InstancesPingStatus status) {
    return (delete(instancesPingStatuses)
          ..where((tbl) => tbl.id.equals(status.id)))
        .go();
  }

  Future<int> addInstancePingStatus(InstancesPingStatusesCompanion status) {
    return into(instancesPingStatuses).insert(status);
  }
}
