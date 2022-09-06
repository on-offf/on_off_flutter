import 'package:flutter_test/flutter_test.dart';
import 'package:on_off/data/data_source/db/icon_dao.dart';
import 'package:on_off/domain/entity/icon_entity.dart';
import 'package:on_off/util/date_util.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  final database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);

  await database.execute(
      'CREATE TABLE icon (id INTEGER PRIMARY KEY AUTOINCREMENT, dateTime Integer, name TEXT)');

  final iconDAO = IconDAO(database);

  DateTime now = DateTime.now();
  var unixTime = dateTimeToUnixTime(now);

  DateTime todayStartDate = DateTime(now.year, now.month, now.day);
  DateTime todayEndDate = todayStartDate.add(const Duration(days: 1));

  int todayUnixStartDate = dateTimeToUnixTime(todayStartDate);
  int todayUnixEndDate = dateTimeToUnixTime(todayEndDate);

  IconEntity firstOffIcon = IconEntity(dateTime: unixTime, name: 'icon01.png');
  IconEntity secondOffIcon = IconEntity(dateTime: unixTime, name: 'icon02.png');

  test('off_icon_dao_test', () async {
    await iconDAO.insertOffIcon(firstOffIcon);
    await iconDAO.insertOffIcon(secondOffIcon);

    List<IconEntity> selectTodayOffIconList = await iconDAO.selectOffIconList(todayUnixStartDate, todayUnixEndDate);

    expect(selectTodayOffIconList.length, 2);

    IconEntity? selectedOffIcon = selectTodayOffIconList.first;

    selectedOffIcon = selectedOffIcon.copyWith(name: 'icon03.png');

    await iconDAO.updateOffIcon(selectedOffIcon);

    selectTodayOffIconList = await iconDAO.selectOffIconList(todayUnixStartDate, todayUnixEndDate);
    selectedOffIcon = selectTodayOffIconList.first;

    expect(selectedOffIcon.name, 'icon03.png');

    await iconDAO.deleteOffIcon(selectedOffIcon);

    selectTodayOffIconList = await iconDAO.selectOffIconList(todayUnixStartDate, todayUnixEndDate);

    expect(selectTodayOffIconList.length, 1);

    await database.close();
  });


}