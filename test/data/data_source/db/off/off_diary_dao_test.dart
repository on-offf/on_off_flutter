import 'package:flutter_test/flutter_test.dart';
import 'package:on_off/data/data_source/db/off/off_diary_dao.dart';
import 'package:on_off/domain/entity/off/off_diary.dart';
import 'package:on_off/util/date_util.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  final database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);

  await database.execute(OffDiaryDAO.ddl);

  final offDiaryDAO = OffDiaryDAO(database);

  DateTime now = DateTime.now();
  DateTime yesterday = now.add(const Duration(days: -1));
  var unixTime = dateTimeToUnixTime(now);
  var yesterdayUnixTime = dateTimeToUnixTime(yesterday);

  DateTime todayStartDate = DateTime(now.year, now.month, now.day);
  DateTime todayEndDate = todayStartDate.add(const Duration(days: 1));
  DateTime yesterdayStartDate = todayStartDate.add(const Duration(days: -1));

  int todayUnixStartDate = dateTimeToUnixTime(todayStartDate);
  int todayUnixEndDate = dateTimeToUnixTime(todayEndDate);
  int yesterdayUnixStartDate = dateTimeToUnixTime(yesterdayStartDate);

  OffDiary offDiary = OffDiary(dateTime: unixTime, content: 'content test');
  OffDiary yesterdayOffDiary = OffDiary(dateTime: yesterdayUnixTime, content: 'yesterday content test');

  test('off_diary_dao_test', () async {
    await offDiaryDAO.insertOffDiary(offDiary);
    await offDiaryDAO.insertOffDiary(yesterdayOffDiary);

    var selectOffDiary = (await offDiaryDAO.selectOffDiaryList(todayUnixStartDate, todayUnixEndDate)).first;

    expect(selectOffDiary, isNot(null));

    expect(selectOffDiary.content, offDiary.content);

    offDiary = selectOffDiary.copyWith(content: "content update test");

    await offDiaryDAO.updateOffDiary(offDiary);

    selectOffDiary = (await offDiaryDAO.selectOffDiaryList(todayUnixStartDate, todayUnixEndDate)).first;

    expect(selectOffDiary.content, offDiary.content);

    List<OffDiary> offDiaryList = await offDiaryDAO.selectOffDiaryList(yesterdayUnixStartDate, todayUnixEndDate);

    expect(offDiaryList.length, 2);

    await offDiaryDAO.deleteOffDiary(selectOffDiary.id!);

    offDiaryList = await offDiaryDAO.selectOffDiaryList(yesterdayUnixStartDate, todayUnixEndDate);

    expect(offDiaryList.length, 1);

    await database.close();
  });

}