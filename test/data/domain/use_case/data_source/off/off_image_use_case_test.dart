import 'dart:typed_data';

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

  await database.execute(OffDiaryDAO.ddl);
  await database.execute(OffImageDAO.ddl);

  OffDiaryDAO offDiaryDAO = OffDiaryDAO(database);
  OffImageDAO offImageDAO = OffImageDAO(database);
  OffImageUseCase offImageUseCase = OffImageUseCase(offImageDAO);

  DateTime now = DateTime.now();
  var unixTime = dateTimeToUnixTime(now);

  OffDiary offDiary = OffDiary(id: 1, title: 'title1', dateTime: unixTime, content: 'content test');

  await offDiaryDAO.insertOffDiary(offDiary);

  List<OffImage> offImageList = [];
  offImageList.add(OffImage(offDiaryId: offDiary.id!, imageFile: Uint8List.fromList([1])));
  offImageList.add(OffImage(offDiaryId: offDiary.id!, imageFile: Uint8List.fromList([1, 2])));
  offImageList.add(OffImage(offDiaryId: offDiary.id!, imageFile: Uint8List.fromList([1, 2, 3])));
  offImageList.add(OffImage(offDiaryId: offDiary.id!, imageFile: Uint8List.fromList([1, 2, 3, 4])));

  test('off_image_use_case_test', () async {
    await offImageUseCase.insertAll(offImageList);

    offImageList = await offImageUseCase.selectOffImageList(offDiary.id!);

    expect(offImageList.length, 4);

    offImageUseCase.delete(offImageList.first.id!);

    offImageList = await offImageUseCase.selectOffImageList(offDiary.id!);

    expect(offImageList.length, 3);
  });
}