import 'package:drift/drift.dart';

class Instances extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get instanceName => text()();
  TextColumn get instanceUrl => text()();
}

@DataClassName('InstancesPingStatus')
class InstancesPingStatuses extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get instanceId => integer()();
  TextColumn get statusCode => text()();
  DateTimeColumn get pingTime => dateTime()();
}
