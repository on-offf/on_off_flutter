import 'package:flutter/material.dart';
import 'package:on_off/ui/off/daily/off_daily_screen.dart';
import 'package:on_off/ui/off/monthly/off_monthly_screen.dart';
import 'package:on_off/ui/off/weekly/off_weekly_screen.dart';
import 'package:on_off/ui/off/write/off_write_screen.dart';
import 'package:on_off/ui/on/home/on_monthly_screen.dart';

class Routes {
  Routes._();

  static final routes = <String, WidgetBuilder>{
    OnMonthlyScreen.routeName: (ctx) => OnMonthlyScreen(),

    OffMonthlyScreen.routeName: (ctx) => OffMonthlyScreen(),
    OffWriteScreen.routeName: (ctx) => OffWriteScreen(),
    OffWeeklyScreen.routeName: (ctx) => OffWeeklyScreen(),
    OffDailyScreen.routeName: (ctx) => OffDailyScreen(),
  };
}
