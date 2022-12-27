import 'package:drift/drift.dart';

class DriftInstances extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get instanceName => text()();
  TextColumn get instanceUrl => text()();
}

@DataClassName('DriftInstancesPingStatus')
class DriftInstancesPingStatuses extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get instanceId => integer()();
  TextColumn get statusCode => text()();
  DateTimeColumn get pingTime => dateTime()();
}
