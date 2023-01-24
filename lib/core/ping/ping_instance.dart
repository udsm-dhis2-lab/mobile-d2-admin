 import 'package:http/http.dart' as http;

import '../../models/index.dart';
import '../../database/repository.dart';

class PingInstance {
  final Repository repository;

  PingInstance({required this.repository});

  void pingAllInstances() async {
    // get all instances
    List<Instance> instances = await repository.getAllInstances();

    if (instances.isNotEmpty) {
      for (var instance in instances) {
        // ping an instance
        var url = Uri.parse(instance.instanceUrl);
        var request = http.Request('GET', url);

        try {
          var response = await request.send();
          // create a new InstancePingStatus
          final status = InstancesPingStatus(
              instanceId: instance.id!,
              statusCode: response.statusCode.toString(),
              pingTime: DateTime.now());
          // add it to the database
          repository.addInstancePingStatus(status);
        } catch (error) {
          final status = InstancesPingStatus(
              instanceId: instance.id!,
              statusCode: error.toString(),
              pingTime: DateTime.now());
              repository.addInstancePingStatus(status);
        }
      }
    }
  }
}
