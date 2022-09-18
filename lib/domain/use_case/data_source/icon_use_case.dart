import 'package:on_off/data/data_source/db/icon_dao.dart';
import 'package:on_off/domain/entity/icon_entity.dart';
import 'package:on_off/util/date_util.dart';

class IconUseCase {
  final IconDAO iconDAO;

  IconUseCase(this.iconDAO);

  Future<void> insert(DateTime dateTime, String name) async {
    dateTime = DateTime(dateTime.year, dateTime.month, dateTime.day);
    await insertEntity(
      IconEntity(
        dateTime: dateTimeToUnixTime(dateTime),
        name: name,
      ),
    );
  }

  Future<void> insertEntity(IconEntity iconEntity) async {
    await iconDAO.insertOffIcon(iconEntity);
  }

  Future<void> delete(IconEntity offIcon) async {
    await iconDAO.deleteOffIcon(offIcon);
  }

  Future<void> update(IconEntity offIcon) async {
    await iconDAO.updateOffIcon(offIcon);
  }

  Future<IconEntity?> selectOffIcon(int id) async {
    return await iconDAO.selectOffIcon(id);
  }

  Future<List<IconEntity>> selectListByDateTime(DateTime dateTime) async {
    DateTime startDate =
        DateTime(dateTime.year, dateTime.month, dateTime.day, 0, 0, 0);
    DateTime endDate = startDate.add(const Duration(days: 1));

    int unixStartDate = dateTimeToUnixTime(startDate);
    int unixEndDate = dateTimeToUnixTime(endDate);

    return await iconDAO.selectOffIconList(unixStartDate, unixEndDate);
  }

  Future<List<IconEntity>> selectOffIconList(
      DateTime startDateTime, DateTime endDateTime) async {
    startDateTime =
        DateTime(startDateTime.year, startDateTime.month, startDateTime.day);
    endDateTime = endDateTime.add(const Duration(days: 1));
    endDateTime =
        DateTime(endDateTime.year, endDateTime.month, endDateTime.day);

    int startUnixTime = dateTimeToUnixTime(startDateTime);
    int endUnixTime = dateTimeToUnixTime(endDateTime);

    return await iconDAO.selectOffIconList(startUnixTime, endUnixTime);
  }
}
