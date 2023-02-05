import 'package:on_off/domain/entity/setting/setting_entity.dart';
import 'package:sqflite/sqflite.dart';

class SettingDAO {
  static const table = 'setting';
  static const ddl =
      'CREATE TABLE ${SettingDAO.table} (isScreenLock Integer, isAlert Integer, isOnOffSwitch Integer, password TEXT, alertMessage TEXT, alertMeridiem TEXT, alertHour Integer, alertMinutes Integer, switchStartHour Integer, switchStartMinutes Integer, switchEndHour Integer, switchEndMinutes Integer)';

  final Database database;

  SettingDAO(this.database);

  Future<SettingEntity> _createSettingEntity() async {
    var entity = SettingEntity(
      isScreenLock: 0,
      isAlert: 0,
      isOnOffSwitch: 0,
      switchStartHour: 10,
      switchStartMinutes: 0,
      switchEndHour: 18,
      switchEndMinutes: 0,
    );
    await database.insert(table, entity.toJson());
    return entity;
  }

  Future<SettingEntity> updateSettingEntity(SettingEntity entity) async {
    await database.update(table, entity.toJson());
    return entity;
  }

  Future<SettingEntity> selectSettingEntity() async {
    final List<Map<String, dynamic>> maps = await database.query(table);

    if (maps.isNotEmpty) {
      return SettingEntity.fromJson(maps.first);
    } else {
      return await _createSettingEntity();
    }
  }
}
