import 'package:flutter/material.dart';
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

  // floating action button
  const factory UiEvent.changeFloatingActionButtonSwitch(bool? floatingActionButtonSwitch) = ChangeFloatingActionButtonSwitch;

  // off_focus_month
  const factory UiEvent.focusMonthSelected() = FocusMonthSelected;
  const factory UiEvent.showOverlay(BuildContext context, OverlayEntry overlayEntry) = ShowOverlay;
  const factory UiEvent.removeOverlay() = RemoveOverlay;

  // initScreen
  const factory UiEvent.initScreen(String route) = InitScreen;

  // notifyListeners
  const factory UiEvent.selfNotifyListeners() = SelfNotifyListeners;
}