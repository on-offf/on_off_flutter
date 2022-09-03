import 'package:on_off/data/data_source/db/off/off_diary_dao.dart';
import 'package:on_off/data/data_source/db/off/off_icon_dao.dart';
import 'package:on_off/data/data_source/db/off/off_image_dao.dart';
import 'package:on_off/domain/use_case/data_source/off_diary_use_case.dart';
import 'package:on_off/domain/use_case/data_source/off_icon_use_case.dart';
import 'package:on_off/domain/use_case/data_source/off_image_use_case.dart';
import 'package:on_off/ui/off/detail/off_detail_view_model.dart';
import 'package:on_off/ui/off/home/off_home_view_model.dart';
import 'package:on_off/ui/off/list/off_list_view_model.dart';
import 'package:on_off/ui/off/write/off_write_view_model.dart';
import 'package:on_off/ui/setting/setting_view_model.dart';
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

  OffDiaryUseCase offDiaryUseCase = OffDiaryUseCase(offDiaryDAO);
  OffImageUseCase offImageUseCase = OffImageUseCase(offImageDAO);
  OffIconUseCase offIconUseCase = OffIconUseCase(offIconDAO);

  OffHomeViewModel offHomeViewModel = OffHomeViewModel();
  OffWriteViewModel offWriteViewModel = OffWriteViewModel();
  OffListViewModel offListViewModel = OffListViewModel();
  OffDetailViewModel offDetailViewModel = OffDetailViewModel();

  return [
    ChangeNotifierProvider(create: (_) => SettingViewModel()),
    ChangeNotifierProvider(create: (_) => offWriteViewModel),
    ChangeNotifierProvider(create: (_) => offHomeViewModel),
    ChangeNotifierProvider(create: (_) => offListViewModel),
    ChangeNotifierProvider(create: (_) => offDetailViewModel),
  ];
}
