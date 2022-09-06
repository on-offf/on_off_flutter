import 'package:flutter_test/flutter_test.dart';
import 'package:on_off/data/data_source/db/off/off_diary_dao.dart';
import 'package:on_off/domain/entity/off/off_diary.dart';
import 'package:on_off/domain/use_case/data_source/off/off_diary_use_case.dart';
import 'package:on_off/util/date_util.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  final database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);

  await database.execute(
      'CREATE TABLE off_diary (id INTEGER PRIMARY KEY AUTOINCREMENT, content TEXT, dateTime INTEGER)');

  OffDiaryDAO offDiaryDAO = OffDiaryDAO(database);
  OffDiaryUseCase offDiaryUseCase = OffDiaryUseCase(offDiaryDAO);

  DateTime now = DateTime.now();
  DateTime yesterday = now.add(const Duration(days: -1));
  var unixTime = dateTimeToUnixTime(now);
  var yesterdayUnixTime = dateTimeToUnixTime(yesterday);

  OffDiary offDiary = OffDiary(dateTime: unixTime, content: 'content test');
  OffDiary yesterdayOffDiary = OffDiary(dateTime: yesterdayUnixTime, content: 'yesterday content test');

  test('off_diary_use_case_test', () async {
    await offDiaryUseCase.insert(offDiary);
    await offDiaryUseCase.insert(yesterdayOffDiary);

    List<OffDiary> offDiaryList = await offDiaryUseCase.selectOffDiaryList(yesterday, now);

    expect(offDiaryList.length, 2);

    OffDiary? entity = await offDiaryUseCase.selectByDateTime(now);

    entity = entity?.copyWith(content: 'change content test');

    await offDiaryUseCase.update(entity!);

    entity = await offDiaryUseCase.selectByDateTime(now);

    for (var element in offDiaryList) { expect(element.content, isNot(entity!.content)); }

    offDiaryUseCase.delete(entity!);

    offDiaryList = await offDiaryUseCase.selectOffDiaryList(yesterday, now);

    expect(offDiaryList.length, 1);
  });
}