import 'package:flutter/material.dart';
import 'package:on_off/ui/provider/ui_event.dart';
import 'package:on_off/ui/provider/ui_provider.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class OffHomeCalendar extends StatelessWidget {
  const OffHomeCalendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = context.watch<UiProvider>();
    final uiState = uiProvider.state;

    return TableCalendar(
      locale: 'ko-KR',
      headerVisible: false,
      focusedDay: uiState.focusedDay,
      firstDay: DateTime.utc(1900, 1, 1),
      lastDay: DateTime.utc(2099, 12, 31),
      onDaySelected: _onDaySelected(uiProvider),
      daysOfWeekVisible: uiState.daysOfWeekVisible,
      selectedDayPredicate: (day) {
        return isSameDay(uiState.selectedDay, day);
      },
      calendarFormat: uiState.calendarFormat,
      onPageChanged: (dateTime) {
        uiProvider.onEvent(UiEvent.changeFocusedDay(dateTime));
        uiProvider.onEvent(UiEvent.changeCalendarPage(dateTime));
      },
      daysOfWeekStyle: _daysOfWeekStyle(),
      calendarStyle: _calendarStyle(),
    );
  }

  OnDaySelected _onDaySelected(uiProvider) {
    return (selectedDay, focusedDay) {
      uiProvider.onEvent(UiEvent.changeSelectedDay(selectedDay));
      uiProvider.onEvent(UiEvent.changeFocusedDay(focusedDay));
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
    return const CalendarStyle(
      outsideDaysVisible: false,
      todayTextStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 11,
        height: 1.21,
      ),
      selectedTextStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 11,
        height: 1.21,
      ),
      defaultTextStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 11,
        height: 1.21,
        color: Color(0xffB3B3B3),
      ),
      weekendTextStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 11,
        height: 1.21,
        color: Color(0xff219EBC),
      ),
      todayDecoration: BoxDecoration(
        color: Color(0xFF219EBC),
        shape: BoxShape.circle,
      ),
      selectedDecoration: BoxDecoration(
        color: Color(0xFF219EBC),
        shape: BoxShape.circle,
      ),
    );
  }
}
