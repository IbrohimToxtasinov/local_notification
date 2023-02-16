import 'package:flutter/material.dart';
import 'package:local_notification/data/services/local_notification/local_notification_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentId = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Local Notification"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                currentId++;
                LocalNotificationService.localNotificationService
                    .showNotification(id: currentId, title: "Salom Sizga Nnotification keldi");
              },
              child: Text("SIMPLE Notifiction 1"),
            ),
            TextButton(
              onPressed: () {
                currentId++;
                LocalNotificationService.localNotificationService
                    .showNotification(id: currentId, title: "Salom Sizga Nnotification keldi");
              },
              child: Text("SIMPLE Notifiction 2"),
            ),
            TextButton(
              onPressed: () {
                currentId++;
                LocalNotificationService.localNotificationService
                    .scheduleNotification(
                  id: currentId,
                  delayedTime: 3,
                );
              },
              child: Text("SCHUADULED NOTIFICATION "),
            ),
            TextButton(
              onPressed: () {
                currentId++;
                LocalNotificationService.localNotificationService
                    .showPeriodically(id: currentId);
              },
              child: Text("PERIODIC NOTIFICATION EVERY MINUT"),
            ),
            const Expanded(child: SizedBox()),
            TextButton(
                onPressed: () {
                  LocalNotificationService.localNotificationService
                      .cancelAllNotifications();
                },
                child: const Text("Cancel All Notifications")),
            TextButton(
                onPressed: () {
                  LocalNotificationService.localNotificationService
                      .cancelNotificationById(currentId);
                },
                child: const Text("Cancel Notification By id")),
          ],
        ),
      ),
    );
  }
}