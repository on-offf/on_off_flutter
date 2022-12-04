import 'package:flutter/material.dart';
import 'package:on_off/ui/provider/ui_provider.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class OffMonthlyCalendar extends StatelessWidget {
  const OffMonthlyCalendar({Key? key}) : super(key: key);

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
      daysOfWeekStyle: _daysOfWeekStyle(),
      calendarStyle: _calendarStyle(),
    );
  }

  OnDaySelected _onDaySelected(UiProvider uiProvider) {
    return (selectedDay, focusedDay) {
      uiProvider.changeSelectedDay(selectedDay);
      uiProvider.changeFocusedDay(focusedDay);
    };
  }

  DaysOfWeekStyle _daysOfWeekStyle() {
    return const DaysOfWeekStyle(
      weekdayStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 11,
        height: 1.21,
        color: Color(0xffB3B3B3),
      ),
      weekendStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 11,
        height: 1.21,
        color: Color(0xff219EBC),
      ),
    );
  }

  CalendarStyle _calendarStyle() {
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
        color: const Color(0xff219EBC),
      ),
      todayDecoration: const BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
      ),
      selectedDecoration: const BoxDecoration(
        color: Color(0xFF219EBC),
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
