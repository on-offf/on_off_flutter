import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:on_off/constants/color_constants.dart';

part 'setting_event.freezed.dart';

@freezed
abstract class SettingEvent with _$SettingEvent {
  const factory SettingEvent.changeMainColor(ColorConst colorConst) = ChangeMainColor;
}