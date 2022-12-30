import 'dart:async';

import 'package:workmanager/workmanager.dart';

import 'ping_instance.dart';
import 'check_connectivity.dart';
import '/database/repository.dart';

class PerformingPinging {
  final Repository repository;

  PerformingPinging({required this.repository});

// This function will perfom pinging in the background
  void performBackgroundPinging() {
    @pragma('vm:entry-point')
    void callbackDispatcher() {
      Workmanager().executeTask((task, inputData) {
        // perfom pinging
        final pingInstance = PingInstance(repository: repository);
        pingInstance.pingInstances();
        return Future.value(true);
      });
    }
  }

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
