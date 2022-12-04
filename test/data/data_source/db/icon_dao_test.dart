import 'package:flutter_test/flutter_test.dart';
import 'package:on_off/data/data_source/db/off/off_icon_dao.dart';
import 'package:on_off/domain/entity/off/off_icon_entity.dart';
import 'package:on_off/util/date_util.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  final database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);

  await database.execute(OffIconDAO.ddl);

  final iconDAO = OffIconDAO(database);

  DateTime now = DateTime.now();

  DateTime todayStartDate = DateTime(now.year, now.month, now.day);
  DateTime todayEndDate = todayStartDate.add(const Duration(days: 1));

  int todayUnixDate = dateTimeToUnixTime(todayStartDate);
  int tomorrowUnixDate = dateTimeToUnixTime(todayEndDate);

  OffIconEntity todayOffIcon = OffIconEntity(dateTime: todayUnixDate, name: 'icon01.png');
  OffIconEntity tomorrowOffIcon = OffIconEntity(dateTime: tomorrowUnixDate, name: 'icon02.png');

  test('off_icon_dao_test', () async {
    await iconDAO.insertOffIcon(todayOffIcon);
    await iconDAO.insertOffIcon(tomorrowOffIcon);

    OffIconEntity? offIconEntity = await iconDAO.selectOffIcon(todayUnixDate);

    expect(offIconEntity!.dateTime, todayUnixDate);

    offIconEntity = offIconEntity.copyWith(name: 'icon03.png');

    offIconEntity = await iconDAO.updateOffIcon(offIconEntity);

    expect(offIconEntity, await iconDAO.selectOffIcon(todayUnixDate));

    expect(offIconEntity.name, 'icon03.png');

    await iconDAO.deleteOffIcon(offIconEntity.dateTime);

    List<OffIconEntity> list = await iconDAO.selectOffIconList(todayUnixDate, tomorrowUnixDate);

    expect(list.length, 0);

    await database.close();
  });


}