import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class OffHomeCalendar extends StatefulWidget {
  const OffHomeCalendar({Key? key}) : super(key: key);

  @override
  State<OffHomeCalendar> createState() => _OffHomeCalendarState();
}

class _OffHomeCalendarState extends State<OffHomeCalendar> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'ko-KR',
      headerVisible: false,
      focusedDay: DateTime.now(),
      firstDay: DateTime.utc(1900, 1, 1),
      lastDay: DateTime.utc(2099, 12, 31),
      onDaySelected: _onDaySelected(),
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      daysOfWeekStyle: _daysOfWeekStyle(),
      calendarStyle: _calendarStyle(),
    );
  }

  OnDaySelected _onDaySelected() {
    return (selectedDay, focusedDay) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
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
        color: Color(0xffFF0000),
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
        color: Color(0xffFF0000),
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
