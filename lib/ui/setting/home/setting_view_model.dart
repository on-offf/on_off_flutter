import 'package:on_off/domain/entity/setting/setting_entity.dart';
import 'package:on_off/domain/use_case/data_source/setting/setting_use_case.dart';
import 'package:on_off/ui/provider/ui_provider_observe.dart';
import 'package:on_off/ui/provider/ui_state.dart';
import 'package:on_off/ui/setting/home/setting_event.dart';
import 'package:on_off/ui/setting/home/setting_state.dart';

class SettingViewModel extends UiProviderObserve {
  final SettingUseCase settingUseCase;

  SettingViewModel({required this.settingUseCase});

  SettingState _state = SettingState(
      setting: SettingEntity(
    isAlert: 0,
    isScreenLock: 0,
  ));

  SettingState get state => _state;

  void onEvent(SettingEvent event) {
    event.when(
      changeIsScreenLock: _changeIsScreenLock,
      changeIsAlert: _changeIsAlert,
      changePassword: _changePassword,
    );
  }

  void _changePassword(String password) async {
    SettingEntity entity = _state.setting;
    entity = entity.copyWith(
      password: password
    );
    entity = await settingUseCase.updateSettingEntity(entity);

    _state = _state.copyWith(setting: entity);
    notifyListeners();
  }

  void _changeIsScreenLock(bool? isScreenLock) async {
    isScreenLock ??= _state.setting.isScreenLock != 1;
    SettingEntity entity = _state.setting;

    entity = entity.copyWith(
      isScreenLock: isScreenLock ? 1 : 0,
    );
    entity = await settingUseCase.updateSettingEntity(entity);

    _state = _state.copyWith(setting: entity);
    notifyListeners();
  }

  void _changeIsAlert(bool? isAlert) async {
    isAlert ??= _state.setting.isAlert != 1;
    SettingEntity entity = _state.setting;

    entity = entity.copyWith(
      isAlert: isAlert ? 1 : 0,
    );
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
  update(UiState uiState) {
    this.uiState = uiState.copyWith();
  }
}
