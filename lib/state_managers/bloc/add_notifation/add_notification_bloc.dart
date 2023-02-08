import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_notification/data/repositories/notification_repository.dart';
import 'package:local_notification/state_managers/bloc/add_notifation/add_notification_event.dart';
import 'package:local_notification/state_managers/bloc/add_notifation/add_notification_state.dart';
import 'package:local_notification/utils/locator.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc()
      : super(const NotificationState(
    notification: [],
    statusText: "",
    status: NotificationStatus.pure,
  )) {
    on<AddNotification>(_addNotification);
  }

  _addNotification(
      AddNotification event, Emitter<NotificationState> emit) async {
    emit(state.copyWith(status: NotificationStatus.loading));
    var newNotification = await appLocator
        .get<NotificationRepository>()
        .addNotification(notificationModel: event.notificationModel);
    if (newNotification.id != null) {
      emit(state.copyWith(status: NotificationStatus.notificationAdded));
    }
  }
}