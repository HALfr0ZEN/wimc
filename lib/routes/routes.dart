import 'package:flutter/material.dart';
import 'package:wimc/pages/home.dart';
import 'package:wimc/pages/settings.dart';

class Routes {
  static const home = "/";
  static const settings = "/settings";
}

class RouterGenerator {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(
          builder: ((context) => const Home()),
        );
      case Routes.settings:
        return MaterialPageRoute(
          builder: ((context) => const Settings()),
        );
      default:
        return MaterialPageRoute(
          builder: ((context) => const Home()),
        );
    }
  }
}
