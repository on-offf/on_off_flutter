import 'package:on_off/domain/entity/setting/setting_entity.dart';
import 'package:on_off/domain/model/alert_time.dart';
import 'package:on_off/domain/use_case/data_source/setting/setting_use_case.dart';
import 'package:on_off/ui/provider/ui_provider_observe.dart';
import 'package:on_off/ui/provider/ui_state.dart';
import 'package:on_off/ui/setting/home/components/notification.dart';
import 'package:on_off/ui/setting/home/setting_state.dart';

class SettingViewModel extends UiProviderObserve {
  final SettingUseCase settingUseCase;

  SettingViewModel({required this.settingUseCase});

  SettingState _state = SettingState(
    setting: SettingEntity(
      isAlert: 0,
      isScreenLock: 0,
    ),
  );

  SettingState get state => _state;

  changeAlertTime(AlertTime time) async {
    SettingEntity entity = _state.setting;
    entity = entity.copyWith(
      alertHour: time.hour,
      alertMinutes: time.minutes,
    );

    dailyWriteNotification(
      entity.alertMessage == null ? "일과 일상을 분리해보세요." : entity.alertMessage!,
      time.hour,
      time.minutes,
    );

    await _updateSettingEntityAndNotifyListeners(entity);
  }

  changeAlertMessage(String message) async {
    SettingEntity entity = _state.setting;
    entity = entity.copyWith(
      alertMessage: message,
    );

    dailyWriteNotification(
      entity.alertMessage == null ? "일과 일상을 분리해보세요." : entity.alertMessage!,
      entity.alertHour!,
      entity.alertMinutes!,
    );

    await _updateSettingEntityAndNotifyListeners(entity);
  }

  changePassword(String password) async {
    SettingEntity entity = _state.setting;
    entity = entity.copyWith(password: password);
    await _updateSettingEntityAndNotifyListeners(entity);
  }

  changeIsScreenLock({bool? isScreenLock}) async {
    isScreenLock ??= _state.setting.isScreenLock != 1;
    SettingEntity entity = _state.setting;

    entity = entity.copyWith(
      isScreenLock: isScreenLock ? 1 : 0,
    );
    await _updateSettingEntityAndNotifyListeners(entity);
  }

  changeIsAlert({bool? isAlert}) async {
    isAlert ??= _state.setting.isAlert != 1;
    SettingEntity entity = _state.setting;

    if (!isAlert) removeWriteNotification();

    entity = entity.copyWith(
      isAlert: isAlert ? 1 : 0,
    );
    await _updateSettingEntityAndNotifyListeners(entity);
  }

  _updateSettingEntityAndNotifyListeners(SettingEntity entity) async {
    entity = await settingUseCase.updateSettingEntity(entity);
    _state = _state.copyWith(setting: entity);
    notifyListeners();
  }

  @override
  init(UiState uiState) async {
    this.uiState = uiState.copyWith();
    var entity = await settingUseCase.selectSettingEntity();
    _state = _state.copyWith(setting: entity);
  }

  @override
  update(UiState uiState) async {
    this.uiState = uiState.copyWith();
  }
}
