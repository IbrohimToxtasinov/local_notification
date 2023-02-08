import 'package:get_it/get_it.dart';
import 'package:local_notification/data/repositories/notification_repository.dart';

final appLocator = GetIt.instance;

Future<void> locatorSetUp() async {
  appLocator.registerLazySingleton(() => NotificationRepository());
}