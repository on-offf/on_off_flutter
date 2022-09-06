import 'package:flutter/material.dart';
import 'package:on_off/ui/off/write/off_write_event.dart';
import 'package:on_off/ui/off/write/off_write_state.dart';

class OffWriteViewModel with ChangeNotifier {
  OffWriteState _state = OffWriteState(
    seletcedIconPaths: [],
    textContent: "",
  );

  OffWriteState get state => _state;

  void onEvent(OffWriteEvent event) {
    event.when(
      addSelectedIconPaths: _addSelectedIconPaths,
      saveTextContent: _saveTextContent,
    );
  }

  void _addSelectedIconPaths(String path) {
    List<String> seletcedIconPaths = _state.seletcedIconPaths;
    seletcedIconPaths.add(path);
    _state = _state.copyWith(seletcedIconPaths: seletcedIconPaths);
  }

  void _saveTextContent(String text) {
    String textContent = _state.textContent;
    textContent = text;
    _state = _state.copyWith(textContent: textContent);
    notifyListeners();
  }
}
