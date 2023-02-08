import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_notification/data/local_db/local_database.dart';
import 'package:local_notification/data/services/notification_send/notification_send_service.dart';
import 'package:local_notification/state_managers/cubit/get_notification/get_notification_cubit.dart';
import 'package:local_notification/state_managers/cubit/get_notification/get_notification_state.dart';
import 'package:local_notification/ui/notifications_page/widgets/notification_item.dart';

class DPage extends StatelessWidget {
  const DPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [

          IconButton(
            onPressed: () async {
              String messageId =
              await NotificationApiService.sendNotificationToAll();
            },
            icon: const Icon(Icons.send_and_archive),
          ),
          IconButton(
            onPressed: () async {
              LocalDatabase.deleteAllNotification();
              BlocProvider.of<NotificationCubit>(context).getAllNotifications();
            },
            icon: const Icon(Icons.delete),
          ),

          IconButton(
            onPressed: () async {
              BlocProvider.of<NotificationCubit>(context).getAllNotifications();
            },
            icon: const Icon(Icons.refresh),
          )
        ],
        title: const Text(
          "Notifications Page",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: BlocBuilder<NotificationCubit, NotificationState>(
          builder: (context, state) {
            if (state is LoadNotificationProgress) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is LoadNotificationSuccess) {
              return Column(
                children: [
                  ...List.generate(
                    state.notifications.length,
                        (index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: NotificationItem(
                          notificationModel: state.notifications[index],
                        ),
                      );
                    },
                  ),
                ],
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                const SizedBox(height: 10),
                const Text(
                  'You don`t have an notification',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}