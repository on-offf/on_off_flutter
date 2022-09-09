import 'package:flutter/material.dart';
import 'package:on_off/ui/off/write/off_write_event.dart';
import 'package:on_off/ui/off/write/off_write_state.dart';

class OffWriteViewModel with ChangeNotifier {
  OffWriteState _state = OffWriteState();

  OffWriteState get state => _state;

  void onEvent(OffWriteEvent event) {
    event.when(
      addSelectedIconPaths: _addSelectedIconPaths,
      saveTextContent: _saveTextContent,
    );
  }

  void _addSelectedIconPaths(String path) {
    List<String> temp = [];
    temp.addAll(_state.iconPaths);
    temp.add(path);
    _state = _state.copyWith(iconPaths: temp);
    notifyListeners();
  }

  void _saveTextContent(String text) {
    notifyListeners();
  }
}
