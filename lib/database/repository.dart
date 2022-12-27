import '../models/models.dart';

abstract class Repository {
  Future init();

  void close();
  
  Stream<List<Instance>> watchAllInstances();

  Future<int> addInstance(Instance instance);

  Future updateInstance(Instance instance);

  Future removeInstance(Instance instance);

  Stream<List<InstancesPingStatus>> searchInstancesPingStatusByInstanceId(
      Instance instance);

  Future removeInstancePingStatus(InstancesPingStatus status);

  Future<int> addInstancePingStatus(InstancesPingStatus status);
}
