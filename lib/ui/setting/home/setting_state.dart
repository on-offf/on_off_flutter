import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:on_off/domain/entity/setting/setting_entity.dart';

part 'setting_state.freezed.dart';

@freezed
class SettingState with _$SettingState {
  factory SettingState({
    required SettingEntity setting,
  }) = _SettingState;
}
