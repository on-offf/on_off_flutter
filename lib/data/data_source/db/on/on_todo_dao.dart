import 'package:on_off/domain/entity/on/on_todo.dart';
import 'package:sqflite/sqflite.dart';

class OnTodoDAO {
  static const table = "on_todo";
  static const ddl =
      '''CREATE TABLE IF NOT EXISTS ${OnTodoDAO.table} (
          id INTEGER PRIMARY KEY AUTOINCREMENT
          , title TEXT
          , content TEXT
          , status INTEGER
          , todoOrder INTEGER
          , completeDateTime INTEGER
          , dateTime INTEGER
        )''';

  final Database database;

  OnTodoDAO(this.database);

  Future<OnTodo> insertOnTodo(OnTodo onTodo) async {
    int id = await database.insert(table, onTodo.toJson());
    return onTodo.copyWith(id: id);
  }

  Future<void> deleteOnTodo(int id) async {
    await database.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> updateOnTodo(OnTodo onTodo) async {
    await database.update(
        table,
        onTodo.toJson(),
        where: 'id = ?',
        whereArgs: [onTodo.id]
    );
  }

  /// order: dateTime, todoOrder
  Future<List<OnTodo>> selectOnTodoList(int startUnixTime, int endUnixTime, String order) async {
    String orderDesc = order == 'id' ? 'DESC' : 'ASC';
    final List<Map<String, dynamic>> maps = await database.query(
      table,
      where: 'dateTime >= ? and dateTime < ?',
      orderBy: '$order $orderDesc',
      whereArgs: [startUnixTime, endUnixTime],
    );

    return maps.map((e) => OnTodo.fromJson(e)).toList();
  }
}
