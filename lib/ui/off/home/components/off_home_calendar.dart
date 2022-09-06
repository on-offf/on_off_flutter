import 'package:flutter/material.dart';
import 'package:on_off/ui/off/home/off_home_event.dart';
import 'package:on_off/ui/off/home/off_home_view_model.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class OffHomeCalendar extends StatelessWidget {
  const OffHomeCalendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<OffHomeViewModel>();
    final state = viewModel.state;

    return TableCalendar(
      locale: 'ko-KR',
      headerVisible: false,
      focusedDay: state.focusedDay,
      firstDay: DateTime.utc(1900, 1, 1),
      lastDay: DateTime.utc(2099, 12, 31),
      onDaySelected: _onDaySelected(viewModel),
      selectedDayPredicate: (day) {
        return isSameDay(state.selectedDay, day);
      },
      onPageChanged: (dateTime) {
        print(dateTime);
        viewModel.onEvent(OffHomeEvent.changeCalendarPage(dateTime));
      },
      eventLoader: (day) {
        print(day);

        return [];
      },
      daysOfWeekStyle: _daysOfWeekStyle(),
      calendarStyle: _calendarStyle(),
    );
  }

  OnDaySelected _onDaySelected(viewModel) {
    return (selectedDay, focusedDay) {
      print('selectedDay: $selectedDay');
      print('focusedDay: $focusedDay');
      viewModel.onEvent(OffHomeEvent.changeSelectedDay(selectedDay));
      viewModel.onEvent(OffHomeEvent.changeFocusedDay(focusedDay));
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
