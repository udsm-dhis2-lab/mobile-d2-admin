import 'dart:async';


import 'ping_instance.dart';
import 'check_connectivity.dart';
import '/database/repository.dart';

class ForegroundPinging {
  final Repository repository;

  ForegroundPinging({required this.repository});


// This function will perfom pinging in foreground
  void perfomForegroundPinging() {
    Timer.periodic(const Duration(minutes: 5), (timer) async {
      // check if we are connected to the internet
      if (await CheckConnectivity.checkIfConnected()) {
        final pingInstance = PingInstance(repository: repository);
        pingInstance.pingInstances();
      }
      return;
    });
  }
}
