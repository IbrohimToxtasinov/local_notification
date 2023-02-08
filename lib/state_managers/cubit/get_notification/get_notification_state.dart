import 'package:local_notification/data/models/notification_model/notifation_model.dart';

abstract class NotificationState {}

class InitialNotificationState extends NotificationState {}

class LoadNotificationProgress extends NotificationState {}

class LoadNotificationSuccess extends NotificationState {
  LoadNotificationSuccess({required this.notifications});

  final List<NotificationModel> notifications;
}

class LoadNotificationFailure extends NotificationState {}