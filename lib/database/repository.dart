import 'package:flutter/material.dart';

import '../models/index.dart';

abstract class Repository extends ChangeNotifier{
  Future init();

  void close();

  Stream<List<Instance>> watchAllInstances();

  Future<List<Instance>> getAllInstances();

  Future<int> addInstance(Instance instance);

  Future updateInstance(Instance instance);

  Future removeInstance(Instance instance);

  Stream<List<InstancesPingStatus>> watchAllInstancePingStatuses();

  Stream<List<InstancesPingStatus>> searchInstancesPingStatusByInstanceId(
      int id);

  Future<List<InstancesPingStatus>> getInstancesPingStatusByInstanceId(int id);

  Future removeInstancePingStatus(InstancesPingStatus status);

  Future<int> addInstancePingStatus(InstancesPingStatus status);
}
