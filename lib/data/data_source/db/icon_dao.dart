import 'package:on_off/domain/entity/icon_entity.dart';
import 'package:sqflite/sqflite.dart';

class IconDAO {
  static const table = 'icon';
  static const ddl = 'CREATE TABLE ${IconDAO.table} (id INTEGER PRIMARY KEY AUTOINCREMENT, dateTime Integer, name TEXT)';

  final Database database;

  IconDAO(this.database);

  Future<void> insertOffIcon(IconEntity offIcon) async {
    await database.insert(table, offIcon.toJson());
  }

  Future<void> deleteOffIcon(IconEntity offIcon) async {
    await database.delete(table, where: 'id = ?', whereArgs: [offIcon.id]);
  }

  Future<void> updateOffIcon(IconEntity offIcon) async {
    await database.update(
      table,
      offIcon.toJson(),
      where: 'id = ?',
      whereArgs: [offIcon.id],
    );
  }

  Future<IconEntity?> selectOffIcon(int id) async {
    final List<Map<String, dynamic>> maps = await database.query(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) return IconEntity.fromJson(maps.first);
    return null;
  }

  Future<List<IconEntity>> selectOffIconList(int unixStartDate, int unixEndDate) async {
    final List<Map<String, dynamic>> maps = await database.query(
      table,
      where: 'dateTime >= ? and dateTime < ?',
      whereArgs: [unixStartDate, unixEndDate],
    );

    return maps.map((e) => IconEntity.fromJson(e)).toList();
  }
}