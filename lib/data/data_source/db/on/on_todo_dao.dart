import 'package:sqflite/sqflite.dart';

class OnTodoDAO {
  static const table = "on_todo";
  static const ddl = 'CREATE TABLE ${OnTodoDAO.table} (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT, status INTEGER, completeDateTime INTEGER, dateTime INTEGER)';

  final Database database;

  OnTodoDAO(this.database);



}