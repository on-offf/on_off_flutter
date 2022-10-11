import 'package:flutter_test/flutter_test.dart';
import 'package:on_off/data/data_source/db/off/off_icon_dao.dart';
import 'package:on_off/domain/entity/off/off_icon_entity.dart';
import 'package:on_off/domain/use_case/data_source/off/off_icon_use_case.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  final database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);

  await database.execute(OffIconDAO.ddl);

  OffIconDAO offIconDAO = OffIconDAO(database);
  OffIconUseCase iconUseCase = OffIconUseCase(offIconDAO);

  DateTime now = DateTime.now();
  DateTime yesterday = now.add(const Duration(days: -1));

  test('off_icon_use_case_test', () async {
    await iconUseCase.insert(now, "today.png");
    await iconUseCase.insert(yesterday, "yesterday.png");

    OffIconEntity? offIcon = await iconUseCase.selectOffIcon(now);

    expect(offIcon!.name, "today.png");

    offIcon = offIcon.copyWith(name: 'change name');

    await iconUseCase.update(now, 'change name!');

    offIcon = await iconUseCase.selectOffIcon(now);

    expect(offIcon!.name, 'change name!');

    await iconUseCase.delete(now);

    var offIconList = await iconUseCase.selectOffIconList(yesterday, now);

    expect(offIconList.length, 1);
  });
}