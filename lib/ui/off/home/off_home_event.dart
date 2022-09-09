import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'off_home_event.freezed.dart';

@freezed
abstract class OffHomeEvent with _$OffHomeEvent {
  const factory OffHomeEvent.changeSelectedDay(DateTime selectedDay) = ChangeSelectedDay;
  const factory OffHomeEvent.changeFocusedDay(DateTime focusedDay) = ChangeFocusedDay;
  const factory OffHomeEvent.changeCalendarPage(DateTime changeCalendarPage) = ChangeCalendarPage;
  const factory OffHomeEvent.offFocusMonthSelected() = OffFocusMonthSelected;
  const factory OffHomeEvent.showOverlay(BuildContext context, OverlayEntry overlayEntry) = ShowOverlay;
  const factory OffHomeEvent.removeOverlay() = RemoveOverlay;
}