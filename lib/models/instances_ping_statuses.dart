class InstancesPingStatus {
  int? id;
  int instanceId;
  String statusCode;
  DateTime pingTime;

  InstancesPingStatus({
    this.id,
    required this.instanceId,
    required this.statusCode,
    required this.pingTime
  });
}
