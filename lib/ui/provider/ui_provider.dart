import 'package:flutter/material.dart';
import 'package:on_off/constants/color_constants.dart';
import 'package:on_off/ui/provider/ui_event.dart';
import 'package:on_off/ui/provider/ui_provider_observe.dart';
import 'package:on_off/ui/provider/ui_state.dart';
import 'package:table_calendar/table_calendar.dart';

class UiProvider with ChangeNotifier {
  final List<UiProviderObserve> viewModelList;

  UiProvider({
    required this.viewModelList,
  }) {
    _init();
  }

  UiState _state = UiState(
    // setting
    colorConst: OceanMainColor(),

    // calendar
    selectedDay: DateTime.now(),
    focusedDay: DateTime.now(),
    changeCalendarPage: DateTime.now(),
    calendarFormat: CalendarFormat.month,
    daysOfWeekVisible: true,
  );

  UiState get state => _state;

  void onEvent(UiEvent event) {
    event.when(
      // setting
      changeMainColor: _changeMainColor,

      // calendar
      changeSelectedDay: _changeSelectedDay,
      changeFocusedDay: _changeFocusedDay,
      changeCalendarPage: _changeCalendarPage,
      changeCalendarFormat: _changeCalendarFormat,
    );
  }

  void _changeCalendarFormat(CalendarFormat calendarFormat) {
    if (_state.calendarFormat == calendarFormat) return;

    _state = _state.copyWith(
      calendarFormat: calendarFormat,
      daysOfWeekVisible: !_state.daysOfWeekVisible,
    );
    _notifyListeners();
  }

  void _changeCalendarPage(DateTime changeCalendarPage) {
    _state = _state.copyWith(changeCalendarPage: changeCalendarPage);
    _notifyListeners();
  }

  void _changeSelectedDay(DateTime selectedDay) {
    _state = _state.copyWith(selectedDay: selectedDay);
    _notifyListeners();
  }

  void _changeFocusedDay(DateTime focusedDay) {
    _state = _state.copyWith(focusedDay: focusedDay);
    _notifyListeners();
  }

  void _changeMainColor(ColorConst colorConst) {
    _state = _state.copyWith(colorConst: colorConst);
    _notifyListeners();
  }

  void _init() {
    for (var viewModel in viewModelList) {
      viewModel.init(_state);
    }
    notifyListeners();
  }

  void _notifyListeners() {
    for (var viewModel in viewModelList) {
      viewModel.update(_state);
    }
    notifyListeners();
  }
}
