import 'package:flutter/material.dart';
import 'package:on_off/ui/off/detail/off_detail_event.dart';
import 'package:on_off/ui/off/detail/off_detail_state.dart';

class OffDetailViewModel with ChangeNotifier {
  OffDetailState _state = OffDetailState(
    currentIndex: 0,
  );

  OffDetailState get state => _state;

  void onEvent(OffDetailEvent event) {
    event.when(
        changeCurrentIndex: _changeCurrentIndex,
    );
  }

  void _changeCurrentIndex(int currentIndex) {
    _state = _state.copyWith(currentIndex: currentIndex);
    notifyListeners();
  }


}