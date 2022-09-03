import 'package:flutter/material.dart';
import 'package:on_off/ui/off/home/off_home_event.dart';
import 'package:on_off/ui/off/home/off_home_state.dart';

class OffHomeViewModel with ChangeNotifier {
  OffHomeState _state = OffHomeState(
    selectedDay: DateTime.now(),
    focusedDay: DateTime.now(),
  );

  OffHomeState get state => _state;

  void onEvent(OffHomeEvent event) {
    event.when(
      changeSelectedDay: _changeSelectedDay,
      changeFocusedDay: _changeFocusedDay
    );
  }

  void _changeSelectedDay(DateTime selectedDay) {
    _state = _state.copyWith(selectedDay: selectedDay);
    notifyListeners();
  }

  void _changeFocusedDay(DateTime focusedDay) {
    _state = _state.copyWith(focusedDay: focusedDay);
    notifyListeners();
  }


}