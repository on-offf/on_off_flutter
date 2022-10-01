import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:on_off/constants/color_constants.dart';
import 'package:table_calendar/table_calendar.dart';

part 'ui_state.freezed.dart';

@freezed
class UiState with _$UiState {
  factory UiState({
    required ColorConst colorConst,
    required DateTime selectedDay,
    required DateTime focusedDay,
    required DateTime changeCalendarPage,
    required CalendarFormat calendarFormat,
    required bool daysOfWeekVisible,
    required bool floatingActionButtonSwitch,

    // focus year & month
    required bool focusMonthSelected,
    required OverlayEntry? overlayEntry,
  }) = _UiState;
}