import 'package:flutter/material.dart';
import 'package:on_off/constants/color_constants.dart';
import 'package:on_off/ui/off/daily/off_daily_screen.dart';
import 'package:on_off/ui/off/daily/off_daily_view_model.dart';
import 'package:on_off/ui/off/list/off_list_screen.dart';
import 'package:on_off/ui/off/list/off_list_view_model.dart';
import 'package:on_off/ui/off/monthly/off_monthly_screen.dart';
import 'package:on_off/ui/off/monthly/off_monthly_view_model.dart';
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

  // setting
  void changeMainColor(ColorConst colorConst) {
    _state = _state.copyWith(colorConst: colorConst);
    _notifyListeners();
  }

  // calendar
  void changeSelectedDay(DateTime selectedDay) {
    selectedDay =
        DateTime(selectedDay.year, selectedDay.month, selectedDay.day);
    _state = _state.copyWith(selectedDay: selectedDay);
    _notifyListeners();
  }

  void changeFocusedDay(DateTime focusedDay) {
    focusedDay = DateTime(focusedDay.year, focusedDay.month, focusedDay.day);
    _state = _state.copyWith(
      focusedDay: focusedDay,
    );
    _notifyListeners();
  }

  void changeCalendarPage(DateTime changeCalendarPage) {
    changeCalendarPage = DateTime(changeCalendarPage.year,
        changeCalendarPage.month, changeCalendarPage.day);
    _state = _state.copyWith(changeCalendarPage: changeCalendarPage);
    _notifyListeners();
  }

  void changeCalendarFormat(CalendarFormat calendarFormat) {
    if (_state.calendarFormat == calendarFormat) return;

    _state = _state.copyWith(
      calendarFormat: calendarFormat,
    );
    _notifyListeners();
  }

  void changeFloatingActionButtonSwitch(bool? floatingActionButtonSwitch) {
    floatingActionButtonSwitch =
        floatingActionButtonSwitch ?? !_state.floatingActionButtonSwitch;
    _state =
        _state.copyWith(floatingActionButtonSwitch: floatingActionButtonSwitch);
    _notifyListeners();
  }

  // focus month overlay
  void showOverlay(BuildContext context, OverlayEntry changeOverlayEntry) {
    _state = state.copyWith(overlayEntry: changeOverlayEntry);
    _notifyListeners();
  }

  void removeOverlay() {
    _state.overlayEntry?.remove();
    _state = state.copyWith(overlayEntry: null);
    _notifyListeners();
  }

  void focusMonthSelected() {
    _state = _state.copyWith(focusMonthSelected: !_state.focusMonthSelected);
    _notifyListeners();
  }

  // initScreen
  initScreen(String route) async {
    for (var viewModel in viewModelList) {
      if (viewModel is OffMonthlyViewModel &&
          route == OffMonthlyScreen.routeName) {
        await viewModel.initScreen();
      } else if (viewModel is OffDailyViewModel && route == OffDailyScreen.routeName) {
        await viewModel.initScreen();
      } else if (viewModel is OffListViewModel && route == OffListScreen.routeName) {
        await viewModel.initScreen();
      }
    }
  }

  void selfNotifyListeners() {
    notifyListeners();
  }

  // with Observe
  Future<void> _init() async {
    for (var viewModel in viewModelList) {
      viewModel.init(_state);
    }
    notifyListeners();
  }

  Future<void> _notifyListeners() async {
    for (var viewModel in viewModelList) {
      await viewModel.update(_state);
    }
    notifyListeners();
  }
}
