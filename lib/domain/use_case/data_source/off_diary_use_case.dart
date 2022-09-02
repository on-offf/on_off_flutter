import 'package:on_off/data/data_source/db/off/off_diary_dao.dart';
import 'package:on_off/domain/entity/off/off_diary.dart';
import 'package:on_off/util/date_util.dart';

class OffDiaryUseCase {
  final OffDiaryDAO offDiaryDAO;
  OffDiaryUseCase(this.offDiaryDAO);

  Future<void> insert(OffDiary offDiary) async {
    await offDiaryDAO.insertOffDiary(offDiary);
  }

  Future<void> delete(OffDiary offDiary) async {
    await offDiaryDAO.deleteOffDiary(offDiary);
  }

  Future<void> update(OffDiary offDiary) async {
    await offDiaryDAO.updateOffDiary(offDiary);
  }

  Future<OffDiary?> selectByDateTime(DateTime dateTime) async {
    DateTime startDate = DateTime(dateTime.year, dateTime.month, dateTime.day, 0, 0, 0);
    DateTime endDate = startDate.add(const Duration(days: 1));

    int unixStartDate = dateTimeToUnixTime(startDate);
    int unixEndDate = dateTimeToUnixTime(endDate);

    List<OffDiary> offDiaryList = await offDiaryDAO.selectOffDiaryList(unixStartDate, unixEndDate);

    if (offDiaryList.isNotEmpty) return offDiaryList.first;
    return null;
  }

  Future<List<OffDiary>> selectOffDiaryList(DateTime startDateTime, DateTime endDateTime) async {
    startDateTime = DateTime(startDateTime.year, startDateTime.month, startDateTime.day);
    endDateTime = endDateTime.add(const Duration(days: 1));
    endDateTime = DateTime(endDateTime.year, endDateTime.month, endDateTime.day);

    int startUnixTime = dateTimeToUnixTime(startDateTime);
    int endUnixTime = dateTimeToUnixTime(endDateTime);

    return await offDiaryDAO.selectOffDiaryList(startUnixTime, endUnixTime);
  }

}