import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_notification/data/local_db/local_database.dart';
import 'package:local_notification/data/services/local_notification/local_notification_service.dart';
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

  sendNotification({required id, required isFinished}) {
    LocalNotificationService.localNotificationService.showNotification(
      id: id,
      title: isFinished ? "File yuklab bo'lindi " : "File yuklanyapdi",
    );
  }
}
