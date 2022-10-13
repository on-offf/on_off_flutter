import 'package:freezed_annotation/freezed_annotation.dart';

part 'setting_event.freezed.dart';

@freezed
class SettingEvent with _$SettingEvent {
  const factory SettingEvent.changeIsScreenLock({bool? isScreenLock}) = ChangeIsScreenLock;
  const factory SettingEvent.changeIsAlert({bool? isAlert}) = ChangeIsAlert;
  const factory SettingEvent.changePassword(String password) = ChangePassword;
  const factory SettingEvent.changeAlertTime(int hour, int minutes) = ChangeAlertTime;
  const factory SettingEvent.changeAlertMessage(String message) = ChangeAlertMessage;
}
