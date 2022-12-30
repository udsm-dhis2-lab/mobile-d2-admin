import 'package:connectivity_plus/connectivity_plus.dart';

class CheckConnectivity {
  static final Connectivity _connectivity = Connectivity();

  static Future<bool> checkIfConnected() async {
    final ConnectivityResult connectivityResult =
        await _connectivity.checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    }

    return false;
  }
}
