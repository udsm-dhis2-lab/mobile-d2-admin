import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';

import '/core/ping/foreground_pinging.dart';
import '/core/ping/ping_instance.dart';
import '/database/drift/drift_repository.dart';
import '/database/repository.dart';
import 'package:mobile_d2_admin/config/light_theme.dart';
import 'package:mobile_d2_admin/modules/home/home_screen.dart';

final repository = DriftRepository();

const backgroundTask = 'background-task';

// call the top level works manager function
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    // perfom pinging
    switch (task) {
      case backgroundTask:
        await repository.init();
        final pingInstance = PingInstance(repository: repository);
        pingInstance.pingAllInstances();
    }
    return Future.value(true);
  });
}

void main() async {
  await repository.init();
  runApp(D2Admin(
    repository: repository,
  ));
}

class D2Admin extends StatefulWidget {
  final Repository repository;
  const D2Admin({
    Key? key,
    required this.repository,
  }) : super(key: key);

  @override
  State<D2Admin> createState() => _D2AdminState();
}

class _D2AdminState extends State<D2Admin> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    final foregroundPinging = ForegroundPinging(repository: repository);
    foregroundPinging.perfomForegroundPinging();
    Workmanager().cancelAll();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // check if we are in background and initialize background task
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      // check if we are running on Android, iOS does not support background periodic tasks
      if (defaultTargetPlatform == TargetPlatform.android) {
        Workmanager().initialize(
          callbackDispatcher,
          isInDebugMode: false,
        );
        Workmanager().registerPeriodicTask(backgroundTask, backgroundTask,
            initialDelay: const Duration(seconds: 10),
            constraints: Constraints(
              networkType: NetworkType.connected,
              requiresBatteryNotLow: false,
              requiresCharging: false,
            ),
            frequency: const Duration(minutes: 15));
      }
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Repository>(
          lazy: false,
          create: (_) => repository,
          // dispose: (_, Repository repository) => dispose(),
        )
      ],
      child: MaterialApp(
        theme: D2AdminLightTheme.buildTheme(),
        debugShowCheckedModeBanner: false,
        home: const SafeArea(
          child: HomeScreen(),
        ),
      ),
    );
  }
}
