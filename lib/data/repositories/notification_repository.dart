import 'package:local_notification/data/local_db/local_database.dart';
import 'package:local_notification/data/models/notification_model/notifation_model.dart';

class NotificationRepository {
  Future<NotificationModel> addNotification(
      {required NotificationModel notificationModel}) =>
      LocalDatabase.addNotification(notificationModel);

  Future<List<NotificationModel>> getAllNotification() =>
      LocalDatabase.getAllNotifications();
}