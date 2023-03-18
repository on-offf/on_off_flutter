import 'package:flutter/material.dart';
import 'package:on_off/ui/on/monthly/components/on_monthly_item.dart';
import 'package:on_off/ui/provider/ui_provider.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class OnMonthlyItemScroller extends StatelessWidget {
  OnMonthlyItemScroller({super.key});

  @override
  Widget build(BuildContext context) {
    UiProvider uiProvider = context.watch<UiProvider>();

    return Container(
      decoration: uiProvider.state.calendarFormat == CalendarFormat.week
          ? const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(22),
                topRight: Radius.circular(22),
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(-3, -3),
                  blurRadius: 1,
                  spreadRadius: 1,
                  color: Color.fromRGBO(0, 0, 0, .1),
                ),
              ],
            )
          : const BoxDecoration(),
      child: Container(
        decoration: uiProvider.state.calendarFormat == CalendarFormat.week
            ? BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(22),
                  topRight: Radius.circular(22),
                ),
                color: uiProvider.state.colorConst.canvas,
              )
            : const BoxDecoration(),
        padding: EdgeInsets.only(
          top: uiProvider.state.calendarFormat == CalendarFormat.month ? 0 : 25,
          left: 37,
          right: 37,
        ),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: OnMonthlyItem(),
        ),
      ),
    );
  }

}
