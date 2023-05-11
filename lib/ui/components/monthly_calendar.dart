import 'package:flutter/material.dart';
import 'package:on_off/ui/provider/ui_provider.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class MonthlyCalendar extends StatelessWidget {
  const MonthlyCalendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = context.watch<UiProvider>();

    return TableCalendar(
      locale: 'ko-KR',
      headerVisible: false,
      focusedDay: uiProvider.state.focusedDay,
      firstDay: DateTime.utc(1900, 1, 1),
      lastDay: DateTime.utc(2099, 12, 31),
      onDaySelected: _onDaySelected(uiProvider),
      daysOfWeekVisible: uiProvider.state.daysOfWeekVisible,
      selectedDayPredicate: (day) {
        return isSameDay(uiProvider.state.selectedDay, day);
      },
      calendarFormat: uiProvider.state.calendarFormat,
      onPageChanged: (dateTime) {
        uiProvider.changeFocusedDay(dateTime);
        uiProvider.changeCalendarPage(dateTime);
      },
      daysOfWeekStyle: _daysOfWeekStyle(uiProvider),
      calendarStyle: _calendarStyle(uiProvider),
    );
  }

  OnDaySelected _onDaySelected(UiProvider uiProvider) {
    return (selectedDay, focusedDay) async {
      uiProvider.changeSelectedDay(selectedDay);
      uiProvider.changeFocusedDay(focusedDay);
    };
  }

  DaysOfWeekStyle _daysOfWeekStyle(UiProvider uiProvider) {
    return DaysOfWeekStyle(
      weekdayStyle: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 11,
        height: 1.21,
        color: Color(0xffB3B3B3),
      ),
      weekendStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 11,
        height: 1.21,
        color: uiProvider.state.colorConst.getPrimary(),
      ),
    );
  }

  CalendarStyle _calendarStyle(UiProvider uiProvider) {
    double fontSize = 14;
    return CalendarStyle(
      outsideDaysVisible: false,
      todayTextStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: fontSize,
        height: 1.21,
        color: const Color(0xffB3B3B3),
      ),
      selectedTextStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: fontSize,
        height: 1.21,
      ),
      defaultTextStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: fontSize,
        height: 1.21,
        color: const Color(0xffB3B3B3),
      ),
      weekendTextStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: fontSize,
        height: 1.21,
        color: uiProvider.state.colorConst.getPrimary(),
      ),
      todayDecoration: const BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
      ),
      selectedDecoration: BoxDecoration(
        color: uiProvider.state.colorConst.getPrimary(),
        shape: BoxShape.circle,
      ),
      outsideTextStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: fontSize,
        height: 1.21,
        color: Color(0xffB3B3B3),
      ),
    );
  }
}
