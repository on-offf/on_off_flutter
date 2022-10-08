import 'package:flutter/material.dart';
import 'package:on_off/ui/off/daily/off_daily_screen.dart';
import 'package:on_off/ui/off/gallery/off_gallery_screen.dart';
import 'package:on_off/ui/off/monthly/off_monthly_screen.dart';
import 'package:on_off/ui/off/list/off_weekly_screen.dart';
import 'package:on_off/ui/off/write/off_write_screen.dart';
import 'package:on_off/ui/on/monthly/on_monthly_screen.dart';
import 'package:on_off/ui/setting/setting_screen.dart';

class Routes {
  Routes._();

  static final routes = <String, WidgetBuilder>{
    OnMonthlyScreen.routeName: (ctx) => OnMonthlyScreen(),

    // off
    OffMonthlyScreen.routeName: (ctx) => OffMonthlyScreen(),
    OffWriteScreen.routeName: (ctx) => OffWriteScreen(),
    OffListScreen.routeName: (ctx) => OffListScreen(),
    OffDailyScreen.routeName: (ctx) => OffDailyScreen(),
    OffGalleryScreen.routeName: (ctx) => OffGalleryScreen(),

    // setting
    SettingScreen.routeName: (ctx) => SettingScreen(),
  };
}
