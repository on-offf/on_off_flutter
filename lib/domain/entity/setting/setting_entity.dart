import 'package:freezed_annotation/freezed_annotation.dart';

part 'setting_entity.freezed.dart';
part 'setting_entity.g.dart';

@freezed
class SettingEntity with _$SettingEntity {
  factory SettingEntity({
    required int isScreenLock,
    required int isAlert,
    String? password,
    String? alertTime,
    String? alertMessage,
  }) = _SettingEntity;

  factory SettingEntity.fromJson(Map<String, dynamic> json) => _$SettingEntityFromJson(json);
}
