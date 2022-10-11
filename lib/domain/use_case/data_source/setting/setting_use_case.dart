import 'package:on_off/data/data_source/db/setting/setting_dao.dart';
import 'package:on_off/domain/entity/setting/setting_entity.dart';

class SettingUseCase {
  final SettingDAO settingDAO;

  SettingUseCase(this.settingDAO);

  Future<SettingEntity> updateSettingEntity(SettingEntity entity) async {
    return settingDAO.updateSettingEntity(entity);
  }

  Future<SettingEntity> selectSettingEntity() async {
    return settingDAO.selectSettingEntity();
  }
}