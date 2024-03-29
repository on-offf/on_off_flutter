import 'package:flutter/material.dart';
import 'package:on_off/constants/color_constants.dart';
import 'package:on_off/ui/off/daily/off_daily_screen.dart';
import 'package:on_off/ui/off/daily/off_daily_view_model.dart';
import 'package:on_off/ui/off/list/off_list_screen.dart';
import 'package:on_off/ui/off/list/off_list_view_model.dart';
import 'package:on_off/ui/off/monthly/off_monthly_screen.dart';
import 'package:on_off/ui/off/monthly/off_monthly_view_model.dart';
import 'package:on_off/ui/on/monthly/on_monthly_screen.dart';
import 'package:on_off/ui/provider/ui_provider_observe.dart';
import 'package:on_off/ui/provider/ui_state.dart';
import 'package:on_off/ui/setting/home/setting_view_model.dart';
import 'package:table_calendar/table_calendar.dart';

class UiProvider with ChangeNotifier {
  final List<UiProviderObserve> viewModelList;

  UiProvider({
    required this.viewModelList,
  });

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

    //start screen
    startRoute: OffMonthlyScreen.routeName,

    oceanMainColor: OceanMainColor(),
    yellowMainColor: YellowMainColor(),
    purpleMainColor: PurpleMainColor(),
    greenMainColor: GreenMainColor(),
  );

  UiState get state => _state;

  // setting
  void changeMainColor(ColorConst colorConst) {
    _state = _state.copyWith(colorConst: colorConst);
    _notifyListeners();
  }

  void _selectStartScreen() {
    for (var viewModel in viewModelList) {
      if (viewModel is SettingViewModel) {
        var settingState = viewModel.state.setting;
        DateTime now = DateTime.now();
        //TODO : on 종료시간이 자정을 넘기지 않는다고 가정. 만약 넘어가도 되면 고쳐야함.
        DateTime settingStartTime = DateTime(now.year, now.month, now.day,
            settingState.switchStartHour, settingState.switchStartMinutes);
        DateTime settingEndTime = DateTime(now.year, now.month, now.day,
            settingState.switchEndHour, settingState.switchEndMinutes);
        if (settingState.isOnOffSwitch == 1 &&
            now.compareTo(settingStartTime) == 1 &&
            now.compareTo(settingEndTime) == -1) {
          _state = _state.copyWith(startRoute: OnMonthlyScreen.routeName);
          _notifyListeners();
        }
      }
    }
    // _state = _state.copyWith(startRoute: );
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
      } else if (viewModel is OffDailyViewModel &&
          route == OffDailyScreen.routeName) {
        await viewModel.initScreen();
      } else if (viewModel is OffListViewModel &&
          route == OffListScreen.routeName) {
        await viewModel.initScreen();
      }
    }
  }

  void selfNotifyListeners() {
    notifyListeners();
  }

  // with Observe
  init() async {
    for (var viewModel in viewModelList) {
      if (viewModel is SettingViewModel) {
        await viewModel.init(_state);
        changeMainColor(_stringToColor(viewModel.state.setting.themeColor));
      } else {
        viewModel.init(_state);
      }
    }
  }

  ColorConst _stringToColor(String color) {
    ColorConst colorConst;
    if (color == 'PURPLE') {
      colorConst = _state.purpleMainColor;
    } else if (color == 'YELLOW') {
      colorConst = _state.yellowMainColor;
    } else if (color == 'GREEN') {
      colorConst = _state.greenMainColor;
    } else {
      colorConst = _state.oceanMainColor;
    }
    return colorConst;
  }

  Future<void> _notifyListeners() async {
    for (var viewModel in viewModelList) {
      await viewModel.update(_state);
    }
    notifyListeners();
  }
}
