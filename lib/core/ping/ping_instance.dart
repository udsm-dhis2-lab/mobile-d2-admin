import 'package:http/http.dart' as http;

import '/models/models.dart';
import '../../database/repository.dart';

class PingInstance {
  final Repository repository;

  PingInstance({required this.repository});

  void pingInstances() async {
    // get all instances
    List<Instance> instances = await repository.getAllInstances();

    if (instances.isNotEmpty){
      for (var instance in instances) {
      // ping an instance
      var url = Uri.parse(instance.instanceUrl);
      var req = http.Request('GET', url);

      var res = await req.send();

      // create a new InstancePingStatus
      final status = InstancesPingStatus(
          instanceId: instance.id!,
          statusCode: res.statusCode.toString(),
          pingTime: DateTime.now());
      // add it to the database
    repository.addInstancePingStatus(status);
    }
    }
  }
}
