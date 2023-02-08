import 'package:equatable/equatable.dart';
import 'package:local_notification/data/models/notification_model/notifation_model.dart';

class NotificationState extends Equatable {
  final NotificationStatus status;
  final String statusText;
  final List<NotificationModel> notification;

  const NotificationState({
    required this.status,
    required this.statusText,
    required this.notification,
  });

  NotificationState copyWith({
    NotificationStatus? status,
    List<NotificationModel>? notification,
    String? statusText,
  }) =>
      NotificationState(
        status: status ?? this.status,
        statusText: statusText ?? this.statusText,
        notification: notification ?? this.notification,
      );

  @override
  List<Object?> get props => [
    status,
    statusText,
    notification,
  ];
}

enum NotificationStatus {
  loading,
  pure,
  notificationAdded,
  notificationUpdated,
  notificationDeleted,
}