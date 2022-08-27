import 'package:flutter/material.dart';
import 'package:on_off/ui/off/list/off_list_screen.dart';
import 'package:on_off/ui/on/list/on_list_screen.dart';
import 'package:on_off/ui/splash/splash_screen.dart';

class Routes {
  Routes._();

  static final routes = <String, WidgetBuilder>{
    '/': (ctx) => const SplashScreen(),
    OnListScreen.routeName: (ctx) => OnListScreen(),
    OffListScreen.routeName: (ctx) => OffListScreen(),
    // '/on-list': (ctx) => ListScreen(),
  };
}
