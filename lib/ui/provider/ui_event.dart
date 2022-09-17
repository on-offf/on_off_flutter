import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:on_off/constants/color_constants.dart';
import 'package:table_calendar/table_calendar.dart';

part 'ui_event.freezed.dart';

@freezed
abstract class UiEvent with _$UiEvent {

  // setting
  const factory UiEvent.changeMainColor(ColorConst colorConst) = ChangeMainColor;

  // calendar
  const factory UiEvent.changeSelectedDay(DateTime selectedDay) = ChangeSelectedDay;
  const factory UiEvent.changeFocusedDay(DateTime focusedDay) = ChangeFocusedDay;
  const factory UiEvent.changeCalendarPage(DateTime changeCalendarPage) = ChangeCalendarPage;
  const factory UiEvent.changeCalendarFormat(CalendarFormat calendarFormat) = ChangeCalendarFormat;

}