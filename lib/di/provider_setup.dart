import 'package:on_off/data/data_source/db/off/off_diary_dao.dart';
import 'package:on_off/data/data_source/db/off/off_icon_dao.dart';
import 'package:on_off/data/data_source/db/off/off_image_dao.dart';
import 'package:on_off/main_view_model/main_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sqflite/sqflite.dart';

Future<List<SingleChildWidget>> getProviders() async {
  Database database = await openDatabase(
    'on_off',
    version: 1,
    onCreate: (db, version) async {
      // OFF
      await db.execute(
          'CREATE TABLE off_diary (id INTEGER PRIMARY KEY AUTOINCREMENT, content TEXT, dateTime INTEGER)');
      await db.execute(
          'CREATE TABLE off_image (id INTEGER PRIMARY KEY AUTOINCREMENT, dateTime Integer, offDiaryId Integer, path TEXT)');
      await db.execute(
          'CREATE TABLE off_icon (id INTEGER PRIMARY KEY AUTOINCREMENT, dateTime Integer, name TEXT)');
    },
  );

  OffDiaryDAO offDiaryDAO = OffDiaryDAO(database);
  OffImageDAO offImageDAO = OffImageDAO(database);
  OffIconDAO offIconDAO = OffIconDAO(database);



  return [
    ChangeNotifierProvider(create: (_) => MainViewModel()),
  ];
}
