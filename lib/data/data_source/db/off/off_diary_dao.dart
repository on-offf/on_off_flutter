import 'package:on_off/domain/entity/off/off_diary.dart';
import 'package:sqflite/sqflite.dart';

class OffDiaryDAO {
  static const table = 'off_diary';

  final Database database;

  OffDiaryDAO(this.database);

  Future<void> insertOffDiary(OffDiary offDiary) async {
    await database.insert(table, offDiary.toJson());
  }

  Future<void> deleteOffDiary(OffDiary offDiary) async {
    await database.delete(table, where: 'id = ?', whereArgs: [offDiary.id]);
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
      where: 'dateTime > ? and dateTime < ?',
      whereArgs: [startUnixTime, endUnixTime],
    );

    return maps.map((e) => OffDiary.fromJson(e)).toList();
  }

}