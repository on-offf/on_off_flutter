import 'package:flutter_test/flutter_test.dart';
import 'package:on_off/data/data_source/db/icon_dao.dart';
import 'package:on_off/domain/entity/icon_entity.dart';
import 'package:on_off/domain/use_case/data_source/icon_use_case.dart';
import 'package:on_off/util/date_util.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  final database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);

  await database.execute(IconDAO.ddl);

  IconDAO offIconDAO = IconDAO(database);
  IconUseCase iconUseCase = IconUseCase(offIconDAO);

  DateTime now = DateTime.now();
  DateTime yesterday = now.add(const Duration(days: -1));
  var unixTime = dateTimeToUnixTime(now);

  IconEntity firstOffIcon = IconEntity(dateTime: unixTime, name: 'icon01.png');
  IconEntity secondOffIcon = IconEntity(dateTime: unixTime, name: 'icon02.png');

  test('off_icon_use_case_test', () async {
    await iconUseCase.insertEntity(firstOffIcon);
    await iconUseCase.insertEntity(secondOffIcon);

    List<IconEntity> offIconList = await iconUseCase.selectListByDateTime(now);

    expect(offIconList.length, 2);

    IconEntity? offIcon = await iconUseCase.selectOffIcon(offIconList.first.id!);

    offIcon = offIcon?.copyWith(name: 'change name');

    await iconUseCase.update(offIcon!);

    offIcon = await iconUseCase.selectOffIcon(offIcon.id!);

    for (var element in offIconList) { expect(element.name, isNot(offIcon!.name)); }

    iconUseCase.delete(offIcon!);

    offIconList = await iconUseCase.selectOffIconList(yesterday, now);

    expect(offIconList.length, 1);
  });
}