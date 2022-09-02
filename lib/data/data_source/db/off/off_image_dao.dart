import 'package:on_off/domain/entity/off/off_image.dart';
import 'package:sqflite/sqflite.dart';

class OffImageDAO {
  static const table = 'off_image';

  final Database database;

  OffImageDAO(this.database);

  Future<void> insertOffImageList(List<OffImage> list) async {
    for (var element in list) { insertOffImage(element); }
  }

  Future<void> insertOffImage(OffImage offImage) async {
    await database.insert(table, offImage.toJson());
  }

  Future<void> deleteOffImage(OffImage offImage) async {
    await database.delete(table, where: 'id = ?', whereArgs: [offImage.id]);
  }

  Future<void> updateOffImage(OffImage offImage) async {
    await database.update(
      table,
      offImage.toJson(),
      where: 'id = ?',
      whereArgs: [offImage.id],
    );
  }

  Future<OffImage?> selectOffImage(int id) async {
    final List<Map<String, dynamic>> maps = await database.query(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) return OffImage.fromJson(maps.first);
    return null;
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