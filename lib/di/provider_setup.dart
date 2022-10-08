import 'package:on_off/data/data_source/db/off/off_icon_dao.dart';
import 'package:on_off/data/data_source/db/off/off_diary_dao.dart';
import 'package:on_off/data/data_source/db/off/off_image_dao.dart';
import 'package:on_off/domain/use_case/data_source/icon_use_case.dart';
import 'package:on_off/domain/use_case/data_source/off/off_diary_use_case.dart';
import 'package:on_off/domain/use_case/data_source/off/off_image_use_case.dart';
import 'package:on_off/ui/off/daily/off_daily_view_model.dart';
import 'package:on_off/ui/off/gallery/off_gallery_view_model.dart';
import 'package:on_off/ui/off/monthly/off_monthly_view_model.dart';
import 'package:on_off/ui/off/list/off_list_view_model.dart';
import 'package:on_off/ui/off/write/off_write_view_model.dart';
import 'package:on_off/ui/on/monthly/on_monthly_view_model.dart';
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
      // OFF
      await db.execute(OffDiaryDAO.ddl);
      await db.execute(OffImageDAO.ddl);
      await db.execute(OffIconDAO.ddl);
    },
  );
  database.delete(OffIconDAO.table);

  OffDiaryDAO offDiaryDAO = OffDiaryDAO(database);
  OffImageDAO offImageDAO = OffImageDAO(database);
  OffIconDAO iconDAO = OffIconDAO(database);

  OffDiaryUseCase offDiaryUseCase = OffDiaryUseCase(offDiaryDAO);
  OffImageUseCase offImageUseCase = OffImageUseCase(offImageDAO);
  OffIconUseCase offIconUseCase = OffIconUseCase(iconDAO);

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

  OffDailyViewModel offDetailViewModel = OffDailyViewModel(
    offIconUseCase: offIconUseCase,
  );

  OffGalleryViewModel offGalleryViewModel = OffGalleryViewModel(
    offDiaryUseCase: offDiaryUseCase,
    offImageUseCase: offImageUseCase,
  );

  // On View Model
  OnMonthlyViewModel onHomeViewModel = OnMonthlyViewModel();

  // Ui Provider ( common provider )
  List<UiProviderObserve> viewModelList = [];

  viewModelList.add(offHomeViewModel);
  viewModelList.add(offListViewModel);
  viewModelList.add(offDetailViewModel);
  viewModelList.add(offWriteViewModel);
  viewModelList.add(offGalleryViewModel);

  viewModelList.add(onHomeViewModel);

  UiProvider uiProvider = UiProvider(viewModelList: viewModelList);

  return [
    ChangeNotifierProvider(create: (_) => uiProvider),

    // off
    ChangeNotifierProvider(create: (_) => offWriteViewModel),
    ChangeNotifierProvider(create: (_) => offHomeViewModel),
    ChangeNotifierProvider(create: (_) => offListViewModel),
    ChangeNotifierProvider(create: (_) => offDetailViewModel),
    ChangeNotifierProvider(create: (_) => offGalleryViewModel),

    // on
    ChangeNotifierProvider(create: (_) => onHomeViewModel),
  ];
}
