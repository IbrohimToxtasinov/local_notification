import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_notification/data/models/notification_model/notifation_model.dart';
import 'package:local_notification/data/repositories/notification_repository.dart';
import 'package:local_notification/data/services/local_notification/local_notification_service.dart';
import 'package:local_notification/state_managers/cubit/connectivity/connectivity_cubit.dart';
import 'package:local_notification/state_managers/cubit/get_notification/get_notification_cubit.dart';
import 'package:local_notification/state_managers/cubit/tab_box/tab_box_cubit.dart';
import 'package:local_notification/ui/download_page/download_screen.dart';
import 'package:local_notification/ui/home_page/home_page.dart';
import 'package:local_notification/ui/notifications_page/notifications_page.dart';
import 'package:local_notification/ui/router.dart';
import 'package:local_notification/utils/locator.dart';

class TabBoxPage extends StatefulWidget {
  const TabBoxPage({super.key});

  @override
  State<TabBoxPage> createState() => _TabBoxPageState();
}

class _TabBoxPageState extends State<TabBoxPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  List<Widget> screens = [];

  @override
  void initState() {
    _init();
    screens.add(const DPage());
    screens.add(const HomePage());
    screens.add(const FileDownloadExample());
    super.initState();
  }

  _init() async {
    _notificationOnMessage();
    _setupInteractedMessage();
  }

  _notificationOnMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      //LocalNotification
      addToSQL(message);
    });
  }

  _setupInteractedMessage() async {
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();
    //Terminateddan kirganda bu ishlaydi
    if (initialMessage != null) {
      addToSQL(initialMessage);
    }

    //Backgounddan kirganda shu ishlaydi
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      addToSQL(message);
      String routeName = message.data["route"];
      var notification = NotificationModel(
        title: message.data['title'],
        date: DateTime.now().toString(),
        description: message.data['description'],
        image: message.data['image'],
      );
      Navigator.pushNamed(context, routeName, arguments: notification);
      debugPrint("ON MESSAGE OPPENED APPDA QOSHILDI");
    });
  }

  void addToSQL(RemoteMessage remoteMessage) async {
    LocalNotificationService.localNotificationService
        .showNotificationByPushNotification(id: 10);
    var notification = NotificationModel(
      title: remoteMessage.data['title'],
      date: DateTime.now().toString(),
      description: remoteMessage.data['description'],
      image: remoteMessage.data['image'],
    );
    await appLocator
        .get<NotificationRepository>()
        .addNotification(notificationModel: notification);
    if (!mounted) return;
    BlocProvider.of<NotificationCubit>(context).getAllNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavCubit(),
      child: BlocBuilder<BottomNavCubit, int>(
        builder: (context, state) {
          var index = context.watch<BottomNavCubit>().activePageIndex;
          return BlocListener<ConnectivityCubit, ConnectivityState>(
            listener: (context, state) {
              if (state.connectivityResult == ConnectivityResult.none) {
                Navigator.pushNamed(
                  context,
                  RoutName.noInternetRoute,
                  arguments: _init,
                );
              }
            },
            child: Scaffold(
              key: _key,
              body: screens[index],
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: index,
                unselectedItemColor: Colors.black,
                selectedItemColor: Colors.blue,
                onTap: (value) => BlocProvider.of<BottomNavCubit>(context)
                    .changePageIndex(value),
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.notification_add,
                      size: 30,
                    ),
                    label: "Notifications Database",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.notifications_active_rounded,
                      size: 30,
                    ),
                    label: "Local Notification",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.file_download,
                      size: 30,
                    ),
                    label: "File Download",
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}