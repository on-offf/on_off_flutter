import 'package:flutter/material.dart';
import 'package:on_off/ui/off/write/off_write_event.dart';
import 'package:on_off/ui/off/write/off_write_state.dart';

class OffWriteViewModel with ChangeNotifier {
  OffWriteState _state = OffWriteState(
      seletcedIconPaths: [],
  );

  OffWriteState get state => _state;

  void onEvent(OffWriteEvent event) {
    event.when(
        addSelectedIconPaths: _addSelectedIconPaths,
    );
  }

  void _addSelectedIconPaths(String path) {
    List<String> seletcedIconPaths = _state.seletcedIconPaths;
    seletcedIconPaths.add(path);
    _state = _state.copyWith(seletcedIconPaths: seletcedIconPaths);
  }

}