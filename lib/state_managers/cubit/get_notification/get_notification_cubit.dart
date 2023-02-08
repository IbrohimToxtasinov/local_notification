import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_notification/data/local_db/local_database.dart';
import 'package:local_notification/state_managers/cubit/get_notification/get_notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(InitialNotificationState()) {
    getAllNotifications();
  }

  getAllNotifications() async {
    emit(LoadNotificationProgress());
    var notifications = await LocalDatabase.getAllNotifications();
    emit(LoadNotificationSuccess(notifications: notifications));
  }
}