import 'package:on_off/domain/entity/off/off_image.dart';
import 'package:sqflite/sqflite.dart';

class OffImageDAO {
  static const table = 'off_image';
  static const ddl = 'CREATE TABLE IF NOT EXISTS ${OffImageDAO.table} (id INTEGER PRIMARY KEY AUTOINCREMENT, offDiaryId Integer, imageFile BLOB)';

  final Database database;

  OffImageDAO(this.database);

  Future<void> insertOffImageList(List<OffImage> list) async {
    for (var element in list) { insertOffImage(element); }
  }

  Future<OffImage> insertOffImage(OffImage offImage) async {
    int id = await database.insert(table, offImage.toJson());
    return offImage.copyWith(id: id);
  }

  Future<void> deleteOffImage(int id) async {
    await database.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteByDiaryId(int diaryId) async {
    await database.delete(table, where: 'offDiaryId = ?', whereArgs: [diaryId]);
  }

  Future<List<OffImage>> selectOffImageListByOffDiaryId(int diaryId) async {
    final List<Map<String, dynamic>> maps = await database.query(
      table,
      where: 'offDiaryId = ?',
      whereArgs: [diaryId],
    );

    return maps.map((e) => OffImage.fromJson(e)).toList();
  }

}