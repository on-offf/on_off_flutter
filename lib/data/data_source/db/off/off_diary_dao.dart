import 'package:on_off/domain/entity/off/off_diary.dart';
import 'package:sqflite/sqflite.dart';

class OffDiaryDAO {
  static const table = 'off_diary';
  static const ddl = 'CREATE TABLE ${OffDiaryDAO.table} (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT, dateTime INTEGER)';

  final Database database;

  OffDiaryDAO(this.database);

  Future<OffDiary> insertOffDiary(OffDiary offDiary) async {
    int id = await database.insert(table, offDiary.toJson());
    return offDiary.copyWith(id: id);
  }

  Future<void> deleteOffDiary(int id) async {
    await database.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> updateOffDiary(OffDiary offDiary) async {
    await database.update(
      table,
      offDiary.toJson(),
      where: 'id = ?',
      whereArgs: [offDiary.id],
    );
  }

  Future<List<OffDiary>> selectOffDiaryList(int startUnixTime, int endUnixTime) async {

    final List<Map<String, dynamic>> maps = await database.query(
      table,
      where: 'dateTime >= ? and dateTime < ?',
      orderBy: 'dateTime ASC',
      whereArgs: [startUnixTime, endUnixTime],
    );

    return maps.map((e) => OffDiary.fromJson(e)).toList();
  }

  Future<OffDiary?> selectOffDiaryByUnixTimeLimit(int unixTime, bool isBefore) async {
    final List<Map<String, dynamic>> maps = await database.query(
      table,
      where: isBefore ? 'dateTime < ?' : 'dateTime > ?',
      orderBy: isBefore ? 'dateTime DESC' : 'dateTime ASC',
      whereArgs: [unixTime],
      limit: 1,
    );
    if (maps.isNotEmpty) return OffDiary.fromJson(maps.first);
    return null;
  }

}