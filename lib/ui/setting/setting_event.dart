import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:on_off/constants/color_constants.dart';

part 'setting_event.freezed.dart';

@freezed
class SettingEvent with _$SettingEvent {
  const factory SettingEvent._changeMainColor(ColorConst colorConst) = ChangeMainColor;
}