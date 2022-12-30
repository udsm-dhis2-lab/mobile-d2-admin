import '../../models/models.dart';
import 'drift_instances_database.dart';
import '../repository.dart';

class DriftRepository implements Repository {
  late DriftInstancesDatabase driftInstancesDatabase;
  late InstancesDao _instancesDao;
  late InstancesPingStatusDao _instancesPingStatusDao;
  Stream<List<Instance>>? instancesStream;
  Stream<List<InstancesPingStatus>>? instancesPingstatusStream;

  @override
  Future init() async {
    driftInstancesDatabase = DriftInstancesDatabase();
    _instancesDao = driftInstancesDatabase.instancesDao;
    _instancesPingStatusDao = driftInstancesDatabase.instancesPingStatusDao;
  }

  @override
  void close() {
    driftInstancesDatabase.close();
  }

  @override
  Stream<List<Instance>> watchAllInstances() {
    if (instancesStream == null) {
      final stream = _instancesDao.watchAllInstances();

      instancesStream = stream.map((driftInstances) {
        final instances = <Instance>[];

        driftInstances.forEach((driftInstance) {
          instances.add(driftInstanceToInstance(driftInstance));
        });
        return instances;
      });
    }
    return instancesStream!;
  }

  @override
  Future<List<Instance>> getAllInstances() async {
    final driftInstances = await _instancesDao.getAllInstances();

    final instances = <Instance>[];

    driftInstances.forEach((driftInstance) {
      instances.add(driftInstanceToInstance(driftInstance));
    });
    return instances;
  }

  @override
  Future<int> addInstance(Instance instance) {
    return Future(() async {
      final id =
          await _instancesDao.addInstance(instanceToDriftInstance(instance));
      return id;
    });
  }

  @override
  Future updateInstance(Instance instance) {
    return Future(() async {
      final driftInstance = DriftInstance(
          id: instance.id!,
          instanceName: instance.instanceName,
          instanceUrl: instance.instanceUrl);

      await _instancesDao.updateInstance(driftInstance);
    });
  }

  @override
  Future removeInstance(Instance instance) {
    return Future(() async {
      await _instancesDao.removeInstance(instance.id!);
    });
  }

  @override
  Stream<List<InstancesPingStatus>> searchInstancesPingStatusByInstanceId(
      Instance instance) {
    if (instancesPingstatusStream == null) {
      final stream = _instancesPingStatusDao
          .watchInstancesPingStatusByInstanceId(instance.id!);

      instancesPingstatusStream = stream.map((driftInstancesPingStatuses) {
        final pingStatuses = <InstancesPingStatus>[];

        driftInstancesPingStatuses.forEach((driftInstancesPingStatus) {
          pingStatuses.add(driftInstancesPingStatusToInstancesPingStatus(
              driftInstancesPingStatus));
        });
        return pingStatuses;
      });
    }
    return instancesPingstatusStream!;
  }

  @override
  Future removeInstancePingStatus(InstancesPingStatus status) {
    return Future(() async {
      await _instancesPingStatusDao.removeInstancePingStatus(status.id!);
    });
  }

  @override
  Future<int> addInstancePingStatus(InstancesPingStatus status) {
    return Future(() async {
      final pingStatuses = <InstancesPingStatus>[];
      await _instancesPingStatusDao
          .findInstacesPingStatusByInstaceId(status.instanceId)
          .then((driftInstancesPingStatues) {
        driftInstancesPingStatues.forEach((driftInstancePingStatus) {
          pingStatuses.add(driftInstancesPingStatusToInstancesPingStatus(
              driftInstancePingStatus));
        });
      });
      if (pingStatuses.length < 10) {
        final id = await _instancesPingStatusDao.addInstancePingStatus(
            instancesPingStatusToDriftInstancesPingStatus(status));
        return id;
      }
      pingStatuses.sort(((a, b) => a.id!.compareTo(b.id!)));
      final removedStatus = pingStatuses.first;
      await _instancesPingStatusDao.removeInstancePingStatus(removedStatus.id!);
      final id = await _instancesPingStatusDao.addInstancePingStatus(
          instancesPingStatusToDriftInstancesPingStatus(status));
      return id;
    });
  }
}
