import 'package:sqflite/sqflite.dart';

class OnImageDAO {
  static const table = "on_image";
  static const ddl = 'CREATE TABLE ${OnImageDAO.table} (id INTEGER PRIMARY KEY AUTOINCREMENT, onTodoId Integer, imageFile BLOB)';

  final Database database;

  OnImageDAO(this.database);


  

}