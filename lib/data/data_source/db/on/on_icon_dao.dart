import 'package:sqflite/sqflite.dart';

class OnIconDAO {
  static const table = "on_icon";
  static const ddl = 'CREATE TABLE ${OnIconDAO.table} (dateTime Integer, name TEXT)';

  final Database database;

  OnIconDAO(this.database);


  

}