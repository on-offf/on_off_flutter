import 'package:flutter_test/flutter_test.dart';
import 'package:on_off/data/data_source/db/off/off_diary_dao.dart';
import 'package:on_off/data/data_source/db/off/off_image_dao.dart';
import 'package:on_off/domain/entity/off/off_diary.dart';
import 'package:on_off/domain/entity/off/off_image.dart';
import 'package:on_off/domain/use_case/data_source/off/off_image_use_case.dart';
import 'package:on_off/util/date_util.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  final database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);

  await database.execute(
      'CREATE TABLE off_diary (id INTEGER PRIMARY KEY AUTOINCREMENT, content TEXT, dateTime INTEGER)');
  await database.execute(
      'CREATE TABLE off_image (id INTEGER PRIMARY KEY AUTOINCREMENT, dateTime Integer, offDiaryId Integer, path TEXT)');

  OffDiaryDAO offDiaryDAO = OffDiaryDAO(database);
  OffImageDAO offImageDAO = OffImageDAO(database);
  OffImageUseCase offImageUseCase = OffImageUseCase(offImageDAO);

  DateTime now = DateTime.now();
  var unixTime = dateTimeToUnixTime(now);

  OffDiary offDiary = OffDiary(id: 1, dateTime: unixTime, content: 'content test');

  await offDiaryDAO.insertOffDiary(offDiary);

  List<OffImage> offImageList = [];
  offImageList.add(OffImage(offDiaryId: offDiary.id!, path: 'image/image01.png'));
  offImageList.add(OffImage(offDiaryId: offDiary.id!, path: 'image/image02.png'));
  offImageList.add(OffImage(offDiaryId: offDiary.id!, path: 'image/image03.png'));
  offImageList.add(OffImage(offDiaryId: offDiary.id!, path: 'image/image04.png'));

  test('off_image_use_case_test', () async {
    await offImageUseCase.insertAll(offImageList);

    offImageList = await offImageUseCase.selectOffImageList(offDiary.id!);

    expect(offImageList.length, 4);

    OffImage? offImage = offImageList.first.copyWith(path: 'path change');

    await offImageUseCase.update(offImage);

    offImage = await offImageUseCase.selectOfImage(offImage.id!);

    for (var element in offImageList) { expect(element.path, isNot(offImage!.path)); }

    offImageUseCase.delete(offImage!);

    offImageList = await offImageUseCase.selectOffImageList(offDiary.id!);

    expect(offImageList.length, 3);
  });
}