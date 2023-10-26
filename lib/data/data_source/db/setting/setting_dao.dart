import 'package:on_off/domain/entity/setting/setting_entity.dart';
import 'package:sqflite/sqflite.dart';

class SettingDAO {
  static const table = 'setting';
  static const ddl =
  '''
      CREATE TABLE IF NOT EXISTS ${SettingDAO.table} (
        isScreenLock Integer, 
        isAlert Integer, 
        password TEXT, 
        alertMessage TEXT, 
        alertMeridiem TEXT, 
        alertHour Integer, 
        alertMinutes Integer,
        isOnOffSwitch Integer DEFAULT 0,
        switchStartHour Integer DEFAULT 10,
        switchStartMinutes Integer DEFAULT 0,
        switchEndHour Integer DEFAULT 18,
        switchEndMinutes Integer DEFAULT 0,
        themeColor TEXT DEFAULT OCEAN
        )
  ''';

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
      themeColor: 'OCEAN',
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
