import 'package:flutter_test/flutter_test.dart';
import 'package:on_off/data/data_source/db/off/off_diary_dao.dart';
import 'package:on_off/data/data_source/db/off/off_image_dao.dart';
import 'package:on_off/domain/entity/off/off_diary.dart';
import 'package:on_off/domain/entity/off/off_image.dart';
import 'package:on_off/util/date_util.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  final database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);

  await database.execute(
      'CREATE TABLE off_diary (id INTEGER PRIMARY KEY AUTOINCREMENT, content TEXT, dateTime INTEGER)');
  await database.execute(
      'CREATE TABLE off_image (id INTEGER PRIMARY KEY AUTOINCREMENT, dateTime Integer, offDiaryId Integer, path TEXT)');

  final offDiaryDAO = OffDiaryDAO(database);
  final offImageDAO = OffImageDAO(database);

  DateTime now = DateTime.now();
  DateTime yesterday = now.add(const Duration(days: -1));
  var unixTime = dateTimeToUnixTime(now);
  var yesterdayUnixTime = dateTimeToUnixTime(yesterday);

  DateTime todayStartDate = DateTime(now.year, now.month, now.day);
  DateTime todayEndDate = todayStartDate.add(const Duration(days: 1));
  DateTime yesterdayStartDate = todayStartDate.add(Duration(days: -1));

  int todayUnixStartDate = dateTimeToUnixTime(todayStartDate);
  int todayUnixEndDate = dateTimeToUnixTime(todayEndDate);
  int yesterdayUnixStartDate = dateTimeToUnixTime(yesterdayStartDate);

  OffDiary? offDiary = OffDiary(dateTime: unixTime, content: 'content test');
  OffDiary? yesterdayOffDiary = OffDiary(dateTime: yesterdayUnixTime, content: 'yesterday content test');

  await offDiaryDAO.insertOffDiary(offDiary);
  await offDiaryDAO.insertOffDiary(yesterdayOffDiary);

  offDiary = (await offDiaryDAO.selectOffDiaryList(todayUnixStartDate, todayUnixEndDate)).first;
  yesterdayOffDiary = (await offDiaryDAO.selectOffDiaryList(yesterdayUnixStartDate, todayUnixStartDate)).first;

  List<OffImage> offImageList = [];
  offImageList.add(OffImage(offDiaryId: offDiary.id!, path: 'image/image01.png'));
  offImageList.add(OffImage(offDiaryId: offDiary.id!, path: 'image/image02.png'));
  offImageList.add(OffImage(offDiaryId: offDiary.id!, path: 'image/image03.png'));
  offImageList.add(OffImage(offDiaryId: offDiary.id!, path: 'image/image04.png'));

  offImageList.add(OffImage(offDiaryId: yesterdayOffDiary.id!, path: 'image/yesterdayImage01.png'));
  offImageList.add(OffImage(offDiaryId: yesterdayOffDiary.id!, path: 'image/yesterdayImage02.png'));
  offImageList.add(OffImage(offDiaryId: yesterdayOffDiary.id!, path: 'image/yesterdayImage03.png'));
  offImageList.add(OffImage(offDiaryId: yesterdayOffDiary.id!, path: 'image/yesterdayImage04.png'));

  test('off_image_dao_test', () async {
    await offImageDAO.insertOffImageList(offImageList);

    offImageList = await offImageDAO.selectOffImageListByOffDiaryId(offDiary!.id!);

    expect(offImageList.length, 4);

    await offImageDAO.deleteOffImage(offImageList.first);

    offImageList = await offImageDAO.selectOffImageListByOffDiaryId(offDiary.id!);

    expect(offImageList.length, 3);

    OffImage? offImage = offImageList.first;

    offImage = offImage.copyWith(path: 'image/imageimagepath.png');

    offImageDAO.updateOffImage(offImage);

    offImage = await offImageDAO.selectOffImage(offImage.id!);

    expect(offImage!.path, 'image/imageimagepath.png');

    expect(offImage.path, isNot(offImageList.first.path));

    await database.close();
  });

}