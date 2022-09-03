import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:on_off/constants/color_constants.dart';

part 'setting_state.freezed.dart';

@freezed
class SettingState with _$SettingState {
  factory SettingState({
    required ColorConst colorConst,
  }) = _SettingState;

}