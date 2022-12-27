class InstancesPingStatuses {
  int id;
  int instanceId;
  String statusCode;
  DateTime pingTime;

  InstancesPingStatuses({
    required this.id,
    required this.instanceId,
    required this.statusCode,
    required this.pingTime
  });
}
