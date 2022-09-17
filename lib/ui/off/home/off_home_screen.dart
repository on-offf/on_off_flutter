import 'package:flutter/material.dart';
import 'package:on_off/ui/components/off_appbar.dart';
import 'package:on_off/ui/components/off_focus_month.dart';
import 'package:on_off/ui/off/home/components/off_home_calendar.dart';

import 'package:on_off/ui/off/home/components/off_home_item.dart';
import 'package:on_off/ui/provider/ui_event.dart';
import 'package:on_off/ui/provider/ui_provider.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';


class OffHomeScreen extends StatelessWidget {
  static const routeName = '/off/home';
  final ScrollController _scrollController = ScrollController();
  String _prevScrollDirectionName = 'idel';

  OffHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = context.watch<UiProvider>();

    return Scaffold(
      appBar: offAppBar(context),
      body: Padding(
        padding: const EdgeInsets.only(left: 37, right: 37, bottom: 41),
        child: NotificationListener(
          onNotification: (ScrollNotification scrollNotification) {
            var position = _scrollController.position;

            if (position.pixels <= 0) {
              uiProvider.onEvent(const UiEvent.changeCalendarFormat(CalendarFormat.month));
            } else if (position.pixels > 0) {
              uiProvider.onEvent(const UiEvent.changeCalendarFormat(CalendarFormat.week));
            }

            return false;
          },
          child: ListView(
            controller: _scrollController,
            children: [
              const OffFocusMonth(),
              const OffHomeCalendar(),
              const SizedBox(
                height: 47.5,
              ),
              OffHomeItem(),
              const SizedBox(height: 41),
            ],
          ),
        ),
      ),
    );
  }
}
