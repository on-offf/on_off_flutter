import 'package:flutter/material.dart';
import 'package:on_off/constants/color_constants.dart';
import 'package:on_off/main_view_model/main_state.dart';

class MainViewModel with ChangeNotifier {
  MainState _state = MainState(
      colorConst: OceanMainColor(),
  );

  MainState get state => _state;

  void _changeMainColor(ColorConst colorConst) {
    _state = _state.copyWith(colorConst: colorConst);
    notifyListeners();
  }

}