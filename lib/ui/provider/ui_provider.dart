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

    // floating action button
    floatingActionButtonSwitch: true,

    // focus month overlay
    overlayEntry: null,
    focusMonthSelected: false,
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
      changeFloatingActionButtonSwitch: _changeFloatingActionButtonSwitch,

      // focus month overlay
      showOverlay: _showOverlay,
      removeOverlay: _removeOverlay,
      focusMonthSelected: _focusMonthSelected,

      // notifyListeners
      selfNotifyListeners: _selfNotifyListeners,
    );
  }

  void _focusMonthSelected() {
    _state = _state.copyWith(focusMonthSelected: !_state.focusMonthSelected);
    _notifyListeners();
  }

  void _showOverlay(BuildContext context, OverlayEntry changeOverlayEntry) {
    _state = state.copyWith(overlayEntry: changeOverlayEntry);
    _notifyListeners();
  }

  void _removeOverlay() {
    _state.overlayEntry?.remove();
    _state = state.copyWith(overlayEntry: null);
    _notifyListeners();
  }

  void _changeFloatingActionButtonSwitch(bool? floatingActionButtonSwitch) {
    floatingActionButtonSwitch =
        floatingActionButtonSwitch ?? !_state.floatingActionButtonSwitch;
    _state =
        _state.copyWith(floatingActionButtonSwitch: floatingActionButtonSwitch);
    _notifyListeners();
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
    changeCalendarPage = DateTime(changeCalendarPage.year,
        changeCalendarPage.month, changeCalendarPage.day);
    _state = _state.copyWith(changeCalendarPage: changeCalendarPage);
    _notifyListeners();
  }

  void _changeSelectedDay(DateTime selectedDay) {
    selectedDay =
        DateTime(selectedDay.year, selectedDay.month, selectedDay.day);
    _state = _state.copyWith(selectedDay: selectedDay);
    _notifyListeners();
  }

  void _changeFocusedDay(DateTime focusedDay) {
    focusedDay = DateTime(focusedDay.year, focusedDay.month, focusedDay.day);
    _state = _state.copyWith(
      focusedDay: focusedDay,
    );
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

  void _selfNotifyListeners() {
    notifyListeners();
  }
}
