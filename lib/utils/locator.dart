import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:local_notification/data/repositories/notification_repository.dart';
import 'package:local_notification/state_managers/cubit/get_notification/get_notification_cubit.dart';

final appLocator = GetIt.instance;

Future<void> locatorSetUp() async {
  appLocator.registerLazySingleton(() => NotificationRepository());
  appLocator.registerLazySingleton(() => Dio());
  appLocator.registerLazySingleton(() => NotificationCubit());
}