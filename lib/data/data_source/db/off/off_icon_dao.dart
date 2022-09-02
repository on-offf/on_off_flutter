import 'package:on_off/domain/entity/off/off_icon.dart';
import 'package:sqflite/sqflite.dart';

class OffIconDAO {
  static const table = 'off_icon';

  final Database database;

  OffIconDAO(this.database);

  Future<void> insertOffIcon(OffIcon offIcon) async {
    await database.insert(table, offIcon.toJson());
  }

  Future<void> deleteOffIcon(OffIcon offIcon) async {
    await database.delete(table, where: 'id = ?', whereArgs: [offIcon.id]);
  }

  Future<void> updateOffIcon(OffIcon offIcon) async {
    await database.update(
      table,
      offIcon.toJson(),
      where: 'id = ?',
      whereArgs: [offIcon.id],
    );
  }

  Future<OffIcon?> selectOffIcon(int id) async {
    final List<Map<String, dynamic>> maps = await database.query(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) return OffIcon.fromJson(maps.first);
    return null;
  }

  Future<List<OffIcon>> selectOffIconList(int unixStartDate, int unixEndDate) async {
    final List<Map<String, dynamic>> maps = await database.query(
      table,
      where: 'dateTime > ? and dateTime < ?',
      whereArgs: [unixStartDate, unixEndDate],
    );

    return maps.map((e) => OffIcon.fromJson(e)).toList();
  }
}