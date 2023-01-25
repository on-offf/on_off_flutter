import 'package:on_off/domain/entity/on/on_image.dart';
import 'package:sqflite/sqflite.dart';

class OnImageDAO {
  static const table = "on_image";
  static const ddl = 'CREATE TABLE ${OnImageDAO.table} (id INTEGER PRIMARY KEY AUTOINCREMENT, onTodoId Integer, imageFile BLOB)';

  final Database database;

  OnImageDAO(this.database);

  Future<void> insertOnImageList(List<OnImage> list) async {
    for (var element in list) { insertOnImage(element); }
  }

  Future<OnImage> insertOnImage(OnImage onImage) async {
    int id = await database.insert(table, onImage.toJson());
    return onImage.copyWith(id: id);
  }

  Future<void> deleteOnImage(int id) async {
    await database.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteByTodoId(int todoId) async {
    await database.delete(table, where: 'onTodoId = ?', whereArgs: [todoId]);
  }

  // TODO todo 하나당 이미지를 여러개 올릴 수 있는지 확인 -> 한개만 올릴 수 있다면, 아래 쿼리 수정
  Future<List<OnImage>> selectOnImageListByOnTodoId(int todoId) async {
    final List<Map<String, dynamic>> maps = await database.query(
      table,
      where: 'onTodoId = ?',
      whereArgs: [todoId],
    );

    return maps.map((e) => OnImage.fromJson(e)).toList();
  }


  

}