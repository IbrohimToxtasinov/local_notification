import 'package:local_notification/data/models/notification_model/notifation_model.dart';

abstract class NotificationEvent{}


class AddNotification extends NotificationEvent{
  AddNotification({required this.notificationModel});
  final NotificationModel notificationModel;
}
