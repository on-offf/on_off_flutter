import 'package:flutter/material.dart';
import 'package:on_off/ui/off/detail/off_detail_screen.dart';
import 'package:on_off/ui/off/home/off_home_screen.dart';
import 'package:on_off/ui/off/list/off_list_screen.dart';
import 'package:on_off/ui/off/write/off_write_screen.dart';
import 'package:on_off/ui/on/home/on_home_screen.dart';
import 'package:on_off/ui/splash/splash_screen.dart';

class Routes {
  Routes._();

  static final routes = <String, WidgetBuilder>{
    '/': (ctx) => const SplashScreen(),

    OnHomeScreen.routeName: (ctx) => OnHomeScreen(),

    OffHomeScreen.routeName: (ctx) => OffHomeScreen(),
    OffWriteScreen.routeName: (ctx) => OffWriteScreen(),
    OffListScreen.routeName: (ctx) => OffListScreen(),
    OffDetailScreen.routeName: (ctx) => OffDetailScreen(),
    // '/on-list': (ctx) => ListScreen(),
  };
}
