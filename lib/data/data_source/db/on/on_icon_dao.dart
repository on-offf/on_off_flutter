import 'package:on_off/domain/entity/on/on_icon_entity.dart';
import 'package:sqflite/sqflite.dart';

class OnIconDAO {
  static const table = "on_icon";
  static const ddl =
      'CREATE TABLE ${OnIconDAO.table} (dateTime Integer, name TEXT)';

  final Database database;

  OnIconDAO(this.database);

  Future<OnIconEntity> insertOnIcon(OnIconEntity onIcon) async {
    await database.insert(table, onIcon.toJson());
    return onIcon;
  }

  Future<void> deleteOnIcon(int unixTime) async {
    await database.delete(table, where: 'dateTime = ?', whereArgs: [unixTime]);
  }

  Future<OnIconEntity> updateOnIcon(OnIconEntity onIcon) async {
    await database.update(
        table,
        onIcon.toJson(),
        where: 'dateTime = ?',
        whereArgs: [onIcon.dateTime]
    );
    return onIcon;
  }

  Future<OnIconEntity?> selectOnIcon(int unixTime) async {
    final List<Map<String, dynamic>> maps = await database.query(
      table,
      where: 'dateTime = ?',
      whereArgs: [unixTime],
    );

    if (maps.isNotEmpty) return OnIconEntity.fromJson(maps.first);
    return null;
  }

  Future<List<OnIconEntity>> selectOnIconList(int unixStartDate, int unixEndDate) async {
    final List<Map<String, dynamic>> maps = await database.query(
      table,
      where: 'dateTime >= ? and dateTime < ?',
      whereArgs: [unixStartDate, unixEndDate],
    );

    return maps.map((e) => OnIconEntity.fromJson(e)).toList();
  }

}
