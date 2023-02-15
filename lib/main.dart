import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_notification/data/local_db/local_database.dart';
import 'package:local_notification/data/models/notification_model/notifation_model.dart';
import 'package:local_notification/data/services/local_notification/local_notification_service.dart';
import 'package:local_notification/state_managers/cubit/connectivity/connectivity_cubit.dart';
import 'package:local_notification/state_managers/cubit/get_notification/get_notification_cubit.dart';
import 'package:local_notification/ui/home_page/home_page.dart';
import 'package:local_notification/ui/router.dart';
import 'package:local_notification/utils/locator.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  var notification = NotificationModel(
    title: message.data['title'],
    date: DateTime.now().toString(),
    description: message.data['description'],
    image: message.data['image'],
    //status: false
  );
  LocalDatabase.addNotification(notification);
  print("ON BACKGROUNDDA QO'SHILDI");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.subscribeToTopic("news");

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  locatorSetUp();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => ConnectivityCubit()),
      BlocProvider(
        create: (BuildContext context) => NotificationCubit(),
      )
    ],
    child: MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    LocalNotificationService.localNotificationService.init(navigatorKey);
    return MaterialApp(
      initialRoute: RoutName.tabBox,
      onGenerateRoute: AppRoutes.generateRoute,
      debugShowCheckedModeBanner: false,
      title: 'Local Notification',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorKey: navigatorKey,
    );
  }
}