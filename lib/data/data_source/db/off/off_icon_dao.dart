import 'package:on_off/domain/entity/off/off_icon_entity.dart';
import 'package:sqflite/sqflite.dart';

class OffIconDAO {
  static const table = 'off_icon';
  static const ddl = 'CREATE TABLE ${OffIconDAO.table} (dateTime Integer, name TEXT)';

  final Database database;

  OffIconDAO(this.database);

  Future<OffIconEntity> insertOffIcon(OffIconEntity offIcon) async {
    await database.insert(table, offIcon.toJson());
    return offIcon;
  }

  Future<void> deleteOffIcon(int unixTime) async {
    await database.delete(table, where: 'dateTime = ?', whereArgs: [unixTime]);
  }

  Future<OffIconEntity> updateOffIcon(OffIconEntity offIcon) async {
    await database.update(
      table,
      offIcon.toJson(),
      where: 'dateTime = ?',
      whereArgs: [offIcon.dateTime],
    );
    return offIcon;
  }

  Future<OffIconEntity?> selectOffIcon(int unixTime) async {
    final List<Map<String, dynamic>> maps = await database.query(
      table,
      where: 'dateTime = ?',
      whereArgs: [unixTime],
    );

    if (maps.isNotEmpty) return OffIconEntity.fromJson(maps.first);
    return null;
  }

  Future<List<OffIconEntity>> selectOffIconList(int unixStartDate, int unixEndDate) async {
    final List<Map<String, dynamic>> maps = await database.query(
      table,
      where: 'dateTime >= ? and dateTime < ?',
      whereArgs: [unixStartDate, unixEndDate],
    );

    return maps.map((e) => OffIconEntity.fromJson(e)).toList();
  }
}