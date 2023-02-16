import 'package:flutter/material.dart';
import 'package:local_notification/ui/new_page/new_page.dart';
import 'package:local_notification/ui/no_internet/no_internet_screen.dart';
import 'package:local_notification/ui/notifications_page/notifications_page.dart';
import 'package:local_notification/ui/tab_box/tab_box.dart';

abstract class RoutName {
  static const tabBox = 'tabBox';
  static const notification = 'notification';
  static const noInternetRoute = 'noInternetRoute';
  static const newsDetailRoute = '/news_route';
}

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutName.noInternetRoute:
        return MaterialPageRoute(
          builder: (_) =>
              NoInternetScreen(voidCallback: settings.arguments as VoidCallback),
        );
      case RoutName.tabBox:
        return MaterialPageRoute(builder: (_) => const TabBoxPage());
      case RoutName.notification:
        return MaterialPageRoute(builder: (_) => const DPage());

      case RoutName.newsDetailRoute:
        return MaterialPageRoute(builder: (_) => const NewPage());
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold());
    }
  }
}