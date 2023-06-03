import 'dart:async';

import 'package:on_off/data/data_source/db/off/off_icon_dao.dart';
import 'package:on_off/data/data_source/db/off/off_diary_dao.dart';
import 'package:on_off/data/data_source/db/off/off_image_dao.dart';
import 'package:on_off/data/data_source/db/on/on_todo_dao.dart';
import 'package:on_off/data/data_source/db/setting/setting_dao.dart';
import 'package:on_off/domain/use_case/data_source/off/off_icon_use_case.dart';
import 'package:on_off/domain/use_case/data_source/off/off_diary_use_case.dart';
import 'package:on_off/domain/use_case/data_source/off/off_image_use_case.dart';
import 'package:on_off/domain/use_case/data_source/on/on_todo_use_case.dart';
import 'package:on_off/domain/use_case/data_source/setting/setting_use_case.dart';
import 'package:on_off/ui/off/daily/off_daily_view_model.dart';
import 'package:on_off/ui/off/gallery/off_gallery_view_model.dart';
import 'package:on_off/ui/off/monthly/off_monthly_view_model.dart';
import 'package:on_off/ui/off/list/off_list_view_model.dart';
import 'package:on_off/ui/off/write/off_write_view_model.dart';
import 'package:on_off/ui/on/monthly/on_monthly_view_model.dart';
import 'package:on_off/ui/provider/ui_provider.dart';
import 'package:on_off/ui/provider/ui_provider_observe.dart';
import 'package:on_off/ui/setting/home/setting_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sqflite/sqflite.dart';

Future<List<SingleChildWidget>> getProviders() async {
  var databaseName = 'on_off.db';
  var databaseVersion = 2;

  Database database = await openDatabase(
    databaseName,
    version: databaseVersion,
    onCreate: (db, version) async {
      // OFF
      await db.execute(OffDiaryDAO.ddl);
      await db.execute(OffImageDAO.ddl);
      await db.execute(OffIconDAO.ddl);

      // ON
      await db.execute(OnTodoDAO.ddl);

      // SETTING
      await db.execute(SettingDAO.ddl);
    },
    onUpgrade: _upgrade,
  );

  OffDiaryDAO offDiaryDAO = OffDiaryDAO(database);
  OffImageDAO offImageDAO = OffImageDAO(database);
  OffIconDAO iconDAO = OffIconDAO(database);

  OnTodoDAO onTodoDAO = OnTodoDAO(database);

  SettingDAO settingDAO = SettingDAO(database);

  OffDiaryUseCase offDiaryUseCase = OffDiaryUseCase(offDiaryDAO);
  OffImageUseCase offImageUseCase = OffImageUseCase(offImageDAO);
  OffIconUseCase offIconUseCase = OffIconUseCase(iconDAO);

  OnTodoUseCase onTodoUseCase = OnTodoUseCase(onTodoDAO);

  SettingUseCase settingUseCase = SettingUseCase(settingDAO);

  // Off View Model
  OffMonthlyViewModel offHomeViewModel = OffMonthlyViewModel(
    offDiaryUseCase: offDiaryUseCase,
    offImageUseCase: offImageUseCase,
    offIconUseCase: offIconUseCase,
  );

  OffWriteViewModel offWriteViewModel = OffWriteViewModel(
    offDiaryUseCase: offDiaryUseCase,
    offImageUseCase: offImageUseCase,
    offIconUseCase: offIconUseCase,
  );

  OffListViewModel offListViewModel = OffListViewModel(
    offDiaryUseCase: offDiaryUseCase,
    offImageUseCase: offImageUseCase,
    iconUseCase: offIconUseCase,
  );
  OffDailyViewModel offDailyViewModel = OffDailyViewModel(
    offDiaryUseCase: offDiaryUseCase,
    offImageUseCase: offImageUseCase,
    offIconUseCase: offIconUseCase,
  );

  OffDailyViewModel offDetailViewModel = OffDailyViewModel(
    offIconUseCase: offIconUseCase,
    offDiaryUseCase: offDiaryUseCase,
    offImageUseCase: offImageUseCase,
  );

  OffGalleryViewModel offGalleryViewModel = OffGalleryViewModel(
    offDiaryUseCase: offDiaryUseCase,
    offImageUseCase: offImageUseCase,
  );

  // On View Model
  OnMonthlyViewModel onHomeViewModel = OnMonthlyViewModel(
    onTodoUseCase: onTodoUseCase,
  );

  // Setting View Model
  SettingViewModel settingViewModel = SettingViewModel(
    settingUseCase: settingUseCase,
  );

  // Ui Provider ( common provider )
  List<UiProviderObserve> viewModelList = [];

  viewModelList.add(offHomeViewModel);
  viewModelList.add(offListViewModel);
  viewModelList.add(offDailyViewModel);
  viewModelList.add(offDetailViewModel);
  viewModelList.add(offWriteViewModel);
  viewModelList.add(offGalleryViewModel);

  viewModelList.add(onHomeViewModel);
  viewModelList.add(settingViewModel);

  UiProvider uiProvider = UiProvider(viewModelList: viewModelList);
  await uiProvider.init();

  return [
    ChangeNotifierProvider(create: (_) => uiProvider),

    // off
    ChangeNotifierProvider(create: (_) => offWriteViewModel),
    ChangeNotifierProvider(create: (_) => offHomeViewModel),
    ChangeNotifierProvider(create: (_) => offListViewModel),
    ChangeNotifierProvider(create: (_) => offDailyViewModel),
    ChangeNotifierProvider(create: (_) => offDetailViewModel),
    ChangeNotifierProvider(create: (_) => offGalleryViewModel),

    // on
    ChangeNotifierProvider(create: (_) => onHomeViewModel),

    // setting
    ChangeNotifierProvider(create: (_) => settingViewModel),
  ];
}

_upgrade(Database db, int oldVersion, int newVersion) async {
  if (oldVersion == newVersion) return;

  switch(oldVersion) {
    case 1: await _dbVersion1(db);
  }
}

_dbVersion1(Database db) async {
  Batch batch = db.batch();
  List<Map> settingTableInfo = await db.rawQuery('PRAGMA table_info(${SettingDAO.table});');
  String isOnOffSwitch = 'isOnOffSwitch';
  String switchStartHour = 'switchStartHour';
  String switchStartMinutes = 'switchStartMinutes';
  String switchEndHour = 'switchEndHour';
  String switchEndMinutes = 'switchEndMinutes';

  if (!settingTableInfo.any((element) => element[isOnOffSwitch] == isOnOffSwitch)) {
    batch.execute('ALTER TABLE ${SettingDAO.table} ADD $isOnOffSwitch Integer DEFAULT 0');
  }

  if (!settingTableInfo.any((element) => element[switchStartHour] == switchStartHour)) {
    batch.execute('ALTER TABLE ${SettingDAO.table} ADD $switchStartHour Integer DEFAULT 10');
  }

  if (!settingTableInfo.any((element) => element[switchStartMinutes] == switchStartMinutes)) {
    batch.execute('ALTER TABLE ${SettingDAO.table} ADD $switchStartMinutes Integer DEFAULT 0');
  }

  if (!settingTableInfo.any((element) => element[switchEndHour] == switchEndHour)) {
    batch.execute('ALTER TABLE ${SettingDAO.table} ADD $switchEndHour Integer DEFAULT 18');
  }

  if (!settingTableInfo.any((element) => element[switchEndMinutes] == switchEndMinutes)) {
    batch.execute('ALTER TABLE ${SettingDAO.table} ADD $switchEndMinutes Integer DEFAULT 0');
  }

  // ON
  await db.execute(OnTodoDAO.ddl);
  batch.commit();
}
