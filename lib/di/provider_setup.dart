import 'package:flutter/cupertino.dart';
import 'package:on_off/data/data_source/db/icon_dao.dart';
import 'package:on_off/data/data_source/db/off/off_diary_dao.dart';
import 'package:on_off/data/data_source/db/off/off_image_dao.dart';
import 'package:on_off/domain/use_case/data_source/icon_use_case.dart';
import 'package:on_off/domain/use_case/data_source/off/off_diary_use_case.dart';
import 'package:on_off/domain/use_case/data_source/off/off_image_use_case.dart';
import 'package:on_off/ui/off/detail/off_detail_view_model.dart';
import 'package:on_off/ui/off/home/off_home_view_model.dart';
import 'package:on_off/ui/off/list/off_list_view_model.dart';
import 'package:on_off/ui/off/write/off_write_view_model.dart';
import 'package:on_off/ui/on/home/on_home_view_model.dart';
import 'package:on_off/ui/provider/ui_provider.dart';
import 'package:on_off/ui/provider/ui_provider_observe.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sqflite/sqflite.dart';

Future<List<SingleChildWidget>> getProviders() async {
  var databaseName = 'on_off.db';
  var databaseVersion = 1;

  Database database = await openDatabase(
    databaseName,
    version: databaseVersion,
    onCreate: (db, version) async {
      // Common
      await db.execute(
          'CREATE TABLE ${IconDAO.table} (id INTEGER PRIMARY KEY AUTOINCREMENT, dateTime Integer, name TEXT)');

      // OFF
      await db.execute(
          'CREATE TABLE ${OffDiaryDAO.table} (id INTEGER PRIMARY KEY AUTOINCREMENT, content TEXT, dateTime INTEGER)');
      await db.execute(
          'CREATE TABLE ${OffImageDAO.table} (id INTEGER PRIMARY KEY AUTOINCREMENT, dateTime Integer, offDiaryId Integer, path TEXT)');
    },
  );

  OffDiaryDAO offDiaryDAO = OffDiaryDAO(database);
  OffImageDAO offImageDAO = OffImageDAO(database);
  IconDAO iconDAO = IconDAO(database);

  OffDiaryUseCase offDiaryUseCase = OffDiaryUseCase(offDiaryDAO);
  OffImageUseCase offImageUseCase = OffImageUseCase(offImageDAO);
  IconUseCase iconUseCase = IconUseCase(iconDAO);

  // Off View Model
  OffHomeViewModel offHomeViewModel = OffHomeViewModel(
    offDiaryUseCase: offDiaryUseCase,
    offImageUseCase: offImageUseCase,
    iconUseCase: iconUseCase,
  );

  OffWriteViewModel offWriteViewModel = OffWriteViewModel(
    offDiaryUseCase: offDiaryUseCase,
    offImageUseCase: offImageUseCase,
    iconUseCase: iconUseCase,
  );

  OffListViewModel offListViewModel = OffListViewModel(
    offDiaryUseCase: offDiaryUseCase,
    offImageUseCase: offImageUseCase,
    iconUseCase: iconUseCase,
  );

  OffDetailViewModel offDetailViewModel = OffDetailViewModel(
    iconUseCase: iconUseCase,
  );

  // On View Model
  OnHomeViewModel onHomeViewModel = OnHomeViewModel();

  // Ui Provider ( common provider )
  List<UiProviderObserve> viewModelList = [];

  viewModelList.add(offHomeViewModel);
  viewModelList.add(offListViewModel);
  viewModelList.add(offDetailViewModel);
  viewModelList.add(offWriteViewModel);

  viewModelList.add(onHomeViewModel);

  UiProvider uiProvider = UiProvider(viewModelList: viewModelList);

  return [
    ChangeNotifierProvider(create: (_) => uiProvider),

    // off
    ChangeNotifierProvider(create: (_) => offWriteViewModel),
    ChangeNotifierProvider(create: (_) => offHomeViewModel),
    ChangeNotifierProvider(create: (_) => offListViewModel),
    ChangeNotifierProvider(create: (_) => offDetailViewModel),

    // on
    ChangeNotifierProvider(create: (_) => onHomeViewModel),


  ];
}
