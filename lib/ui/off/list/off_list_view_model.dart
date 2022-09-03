import 'package:flutter/material.dart';
import 'package:on_off/ui/off/list/off_list_event.dart';
import 'package:on_off/ui/off/list/off_list_state.dart';

class OffListViewModel with ChangeNotifier {
  OffListState _state = OffListState(
      contents: [],
  );

  OffListState get state => _state;

  void onEvent(OffListEvent event) {
    event.when(
        changeContents: _changeContents,
    );
  }

  void _changeContents(DateTime startDateTime, DateTime endDateTime) {
    notifyListeners();
  }

}