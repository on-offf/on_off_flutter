import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sqflite/sqflite.dart';

Future<List<SingleChildWidget>> getProviders() async {
  Database database = await openDatabase(
    'on_off',
    version: 1,
    onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE on (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, color INTEGER)');
      await db.execute(
          'CREATE TABLE off (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, color INTEGER)');
    },
  );


  return [
    ChangeNotifierProvider(create: (_) => null),
  ];
}
