import 'package:flutter_test/flutter_test.dart';
import 'package:on_off/data/data_source/db/off/off_icon_dao.dart';
import 'package:on_off/domain/entity/off/off_icon.dart';
import 'package:on_off/util/date_util.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  final database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);

  await database.execute(
      'CREATE TABLE off_icon (id INTEGER PRIMARY KEY AUTOINCREMENT, dateTime Integer, name TEXT)');

  final offIconDAO = OffIconDAO(database);

  DateTime now = DateTime.now();
  var unixTime = dateTimeToUnixTime(now);

  DateTime todayStartDate = DateTime(now.year, now.month, now.day);
  DateTime todayEndDate = todayStartDate.add(const Duration(days: 1));

  int todayUnixStartDate = dateTimeToUnixTime(todayStartDate);
  int todayUnixEndDate = dateTimeToUnixTime(todayEndDate);

  OffIcon firstOffIcon = OffIcon(dateTime: unixTime, name: 'icon01.png');
  OffIcon secondOffIcon = OffIcon(dateTime: unixTime, name: 'icon02.png');

  test('off_icon_dao_test', () async {
    await offIconDAO.insertOffIcon(firstOffIcon);
    await offIconDAO.insertOffIcon(secondOffIcon);

    List<OffIcon> selectTodayOffIconList = await offIconDAO.selectOffIconList(todayUnixStartDate, todayUnixEndDate);

    expect(selectTodayOffIconList.length, 2);

    OffIcon? selectedOffIcon = selectTodayOffIconList.first;

    selectedOffIcon = selectedOffIcon.copyWith(name: 'icon03.png');

    await offIconDAO.updateOffIcon(selectedOffIcon);

    selectTodayOffIconList = await offIconDAO.selectOffIconList(todayUnixStartDate, todayUnixEndDate);
    selectedOffIcon = selectTodayOffIconList.first;

    expect(selectedOffIcon.name, 'icon03.png');

    await offIconDAO.deleteOffIcon(selectedOffIcon);

    selectTodayOffIconList = await offIconDAO.selectOffIconList(todayUnixStartDate, todayUnixEndDate);

    expect(selectTodayOffIconList.length, 1);

    await database.close();
  });


}