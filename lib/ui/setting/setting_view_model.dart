import 'package:flutter/material.dart';
import 'package:on_off/constants/color_constants.dart';
import 'package:on_off/ui/setting/setting_event.dart';
import 'package:on_off/ui/setting/setting_state.dart';

class SettingViewModel with ChangeNotifier {
  SettingState _state = SettingState(
      colorConst: OceanMainColor(),
  );

  SettingState get state => _state;

  void onEvent(SettingEvent event) {
    event.when(
      changeMainColor: _changeMainColor,
    );
  }

  void _changeMainColor(ColorConst colorConst) {
    _state = _state.copyWith(colorConst: colorConst);
    notifyListeners();
  }

}